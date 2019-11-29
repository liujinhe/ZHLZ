//
//  ZHLZHomeSafeProblemVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemVC.h"
#import "ZHLZHomeSafeProblemCell.h"
#import "ZHLZHomeSafeProblemVM.h"
#import "ZHLZHomeSafeProblemDetailVC.h"
#import "ZHLZHomeSafeProblemSearchVC.h"

#define ZHLZHomeSafeProblemReuseIdentifier NSStringFromClass([ZHLZHomeSafeProblemCell class])

@interface ZHLZHomeSafeProblemVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet ZHLZSearchView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *homeSafeProblemTableView;

@property (nonatomic, strong) ZHLZHomeSafeProblemSearchVC *homeSafeProblemSearchVC;

@property (nonatomic, strong) ZHLZHomeSafeProblemSearchModel *homeSafeProblemSearchModel;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeSafeProblemModel *> *homeSafeProblemModelArray;

@end

@implementation ZHLZHomeSafeProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    }
    
    [self loadHomeSafeProblemView];
    
    [self loadHomeSafeProblemData];
}

- (void)addAction {
    ZHLZHomeSafeProblemDetailVC *homeSafeProblemDetailVC = [ZHLZHomeSafeProblemDetailVC new];
    homeSafeProblemDetailVC.detailType = 1;
    [self.navigationController pushViewController:homeSafeProblemDetailVC animated:YES];
}

- (void)searchAction {
    [self presentViewController:self.homeSafeProblemSearchVC animated:NO completion:^{
        [self.homeSafeProblemSearchVC showFilterView];
    }];
}

- (void)loadHomeSafeProblemData {
    @weakify(self)
    if (self.homeSafeProblemTableView.mj_footer.isRefreshing) {
        self.pageNo++;
    } else {
        self.pageNo = 1;
        [self.homeSafeProblemTableView.mj_footer resetNoMoreData];
    }
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeProblemDataWithPageNum:self.pageNo withModel:self.homeSafeProblemSearchModel withBlock:^(NSArray<ZHLZHomeSafeProblemModel *> * _Nonnull homeSafeProblemArray) {
        @strongify(self)
        
        if (self.homeSafeProblemTableView.mj_header.isRefreshing) {
            [self.homeSafeProblemTableView.mj_header endRefreshing];
        }
        if ([self.homeSafeProblemTableView.mj_footer isRefreshing]) {
            [self.homeSafeProblemTableView.mj_footer endRefreshing];
        }
        
        if (self.pageNo == 1) {
            self.homeSafeProblemModelArray = homeSafeProblemArray.mutableCopy;
        } else {
            if (homeSafeProblemArray.count > 0) {
                [self.homeSafeProblemModelArray addObjectsFromArray:homeSafeProblemArray];
            } else {
                [self.homeSafeProblemTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        [self.homeSafeProblemTableView reloadData];
    }];
}

- (void)loadHomeSafeProblemView {
    @weakify(self);
    self.searchView.searchBlock = ^{
        @strongify(self);
        [self searchAction];
    };
    
    self.homeSafeProblemSearchVC = [ZHLZHomeSafeProblemSearchVC new];
    self.homeSafeProblemSearchVC.selectSearchBlock = ^(ZHLZHomeSafeProblemSearchModel * _Nonnull homeSafeProblemSearchModel) {
        @strongify(self);
        self.homeSafeProblemSearchModel = homeSafeProblemSearchModel;
        
        [self loadHomeSafeProblemData];
    };
    
    self.homeSafeProblemModelArray = [NSMutableArray <ZHLZHomeSafeProblemModel *> new];
    
    self.homeSafeProblemTableView.dataSource = self;
    self.homeSafeProblemTableView.delegate = self;
    
    [self.homeSafeProblemTableView registerNib:[UINib nibWithNibName:ZHLZHomeSafeProblemReuseIdentifier bundle:nil] forCellReuseIdentifier:ZHLZHomeSafeProblemReuseIdentifier];
    
    self.homeSafeProblemTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeProblemData)];
    self.homeSafeProblemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeProblemData)];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeSafeProblemModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeSafeProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHLZHomeSafeProblemReuseIdentifier];
    if (cell == nil) {
        cell = [[ZHLZHomeSafeProblemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHLZHomeSafeProblemReuseIdentifier];
    }
    cell.homeSafeProblemModel = self.homeSafeProblemModelArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeSafeProblemModel *safeProblemModel = self.homeSafeProblemModelArray[indexPath.row];
    ZHLZHomeSafeProblemDetailVC *homeSafeProblemDetailVC = [ZHLZHomeSafeProblemDetailVC new];
    homeSafeProblemDetailVC.detailType = 2;
    homeSafeProblemDetailVC.detailId = [NSString stringWithFormat:@"%@", safeProblemModel.objectID];
    [self.navigationController pushViewController:homeSafeProblemDetailVC animated:YES];
}

@end
