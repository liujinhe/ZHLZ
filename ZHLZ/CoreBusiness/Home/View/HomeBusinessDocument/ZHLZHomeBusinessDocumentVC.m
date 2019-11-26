//
//  ZHLZHomeBusinessDocumentVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBusinessDocumentVC.h"
#import "ZHLZBusinessDocumentCell.h"
#import "ZHLZHomeBusinessDocumentVM.h"
#import "ZHLZHomeDownloadBusinessDocumentVC.h"

static NSString * const cellID = @"ZHLZBusinessDocumentCell";

@interface ZHLZHomeBusinessDocumentVC () <UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *businessDocumentTableView;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeBusinessDocumentModel *> *businessDocumentModelArray;

@property (nonatomic, strong) ZHLZHomeDownloadBusinessDocumentVC *homeDownloadBusinessDocumentVC;

@end

@implementation ZHLZHomeBusinessDocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodBusinessDocumentView];
    
    [self homeBusinessDocumentData];
}

- (void)laodBusinessDocumentView {
    self.title = @"业务文件";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openDocWithPathAction:) name:OpenDocNotificationConst object:nil];
    
    if (@available(iOS 11.0, *)) {
        self.businessDocumentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.businessDocumentModelArray = [NSMutableArray <ZHLZHomeBusinessDocumentModel *> new];
    
    self.homeDownloadBusinessDocumentVC = [ZHLZHomeDownloadBusinessDocumentVC new];
    
    self.businessDocumentTableView.dataSource = self;
    self.businessDocumentTableView.delegate = self;
    
    [self.businessDocumentTableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    
    self.businessDocumentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(homeBusinessDocumentData)];
    self.businessDocumentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(homeBusinessDocumentData)];
}

- (void)homeBusinessDocumentData {
    @weakify(self);
    if (self.businessDocumentTableView.mj_footer.isRefreshing) {
        self.pageNo++;
    } else {
        self.pageNo = 1;
        [self.businessDocumentTableView.mj_footer resetNoMoreData];
    }
    self.task = [[ZHLZHomeBusinessDocumentVM sharedInstance] loadHomeBusinessDocumentDataWithPageNum:self.pageNo WithBlock:^(NSArray<ZHLZHomeBusinessDocumentModel *> * _Nonnull homeBusinessDocumentModel) {
        @strongify(self);
        if (self.businessDocumentTableView.mj_header.isRefreshing) {
            [self.businessDocumentTableView.mj_header endRefreshing];
        }
        if (self.businessDocumentTableView.mj_footer.isRefreshing) {
            [self.businessDocumentTableView.mj_footer endRefreshing];
        }
        
        if (self.pageNo == 1) {
            self.businessDocumentModelArray = homeBusinessDocumentModel.mutableCopy;
        } else {
            if (homeBusinessDocumentModel && homeBusinessDocumentModel.count > 0) {
                [self.businessDocumentModelArray addObjectsFromArray:homeBusinessDocumentModel];
            } else {
                [self.businessDocumentTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        [self.businessDocumentTableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businessDocumentModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZBusinessDocumentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZHLZBusinessDocumentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ZHLZHomeBusinessDocumentModel *model = self.businessDocumentModelArray[indexPath.row];
    if (model) {
        cell.homeBusinessDocumentModel = model;
        cell.isHasDownLoad = [[NSFileManager defaultManager] fileExistsAtPath:[self getFileFullPath:model.url]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    ZHLZHomeBusinessDocumentModel *model = self.businessDocumentModelArray[indexPath.row];
    if (model && [model.url isNotBlank]) {
        NSString *fullPath = [self getFileFullPath:model.url];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) { // 文件已经存在，直接打开
            [self openDocWithPath:[NSURL fileURLWithPath:fullPath]];
        } else { // 文件不存在，下载
            [self presentViewController:self.homeDownloadBusinessDocumentVC animated:NO completion:^{
                @strongify(self);
                self.homeDownloadBusinessDocumentVC.homeBusinessDocumentModel = model;
                self.homeDownloadBusinessDocumentVC.fullPath = fullPath;
            }];
        }
    }
}

/// 获取文件全地址
/// @param filePath 文件地址
- (NSString *)getFileFullPath:(NSString *)filePath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documents lastObject];
    
    NSString *filesPath = [documentsPath stringByAppendingPathComponent:@"ZHLZDocFiles"];
    NSArray *filePathArray = [filePath componentsSeparatedByString:@"/"];
    for (NSInteger i = 0; i < filePathArray.count - 1; i++) {
        filesPath = [filesPath stringByAppendingPathComponent:filePathArray[i]];
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 是否存在 ZHLZDocFiles 目录
    if (![fileManager fileExistsAtPath:filesPath]) {
        [fileManager createDirectoryAtPath:filesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [filesPath stringByAppendingPathComponent:[filePathArray lastObject]];
}

- (void)openDocWithPath:(NSURL *)filePath {
    @weakify(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否打开文件" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        UIDocumentInteractionController *doc = [UIDocumentInteractionController interactionControllerWithURL:filePath];
        doc.delegate = self;
        [doc presentPreviewAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)openDocWithPathAction:(NSNotification *)notification {
    [self homeBusinessDocumentData];
    
    [self openDocWithPath:[notification.object objectForKey:@"filePath"]];
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller {
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller {
    return CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height);
}

@end
