//
//  ZHLZHomeSafeVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeVC.h"
#import "ZHLZHomeSafeCell.h"
#import "ZHLZHomeSafeVM.h"
#import "ZHLZHomeSafeDetailVC.h"
#import "ZHLZHomeSafeSearchVC.h"

#define ZHLZHomeSafeReuseIdentifier NSStringFromClass([ZHLZHomeSafeCell class])

@interface ZHLZHomeSafeVC () <UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet ZHLZSearchView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *homeSafeTableView;

@property (nonatomic, strong) ZHLZHomeSafeSearchVC *homeSafeSearchVC;

@property (nonatomic, strong) ZHLZHomeSafeSearchModel *homeSafeSearchModel;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeSafeModel *> *homeSafeModelArray;

@end

@implementation ZHLZHomeSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    }
    
    [self loadHomeSafeView];
    
    [self loadHomeSafeList];
}

- (void)addAction {
    ZHLZHomeSafeDetailVC *homeSafeDetailVC = [ZHLZHomeSafeDetailVC new];
    homeSafeDetailVC.type = 1;
    homeSafeDetailVC.reloadDataBlock = ^{
        [self.homeSafeTableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:homeSafeDetailVC animated:YES];
}

- (void)searchAction {
    [self presentViewController:self.homeSafeSearchVC animated:NO completion:^{
        [self.homeSafeSearchVC showFilterView];
    }];
}

- (void)loadHomeSafeList {
    @weakify(self)
    if (self.homeSafeTableView.mj_footer.isRefreshing) {
        self.pageNo++;
    } else {
        self.pageNo = 1;
        [self.homeSafeTableView.mj_footer resetNoMoreData];
    }
    self.task = [[ZHLZHomeSafeVM sharedInstance] loadHomeSafeDataWithPageNum:self.pageNo withModel:self.homeSafeSearchModel withBlock:^(NSArray<ZHLZHomeSafeModel *> * _Nonnull homeSafeModelArray) {
        @strongify(self)
        if (self.homeSafeTableView.mj_header.isRefreshing) {
            [self.homeSafeTableView.mj_header endRefreshing];
        }
        if ([self.homeSafeTableView.mj_footer isRefreshing]) {
            [self.homeSafeTableView.mj_footer endRefreshing];
        }
        
        if (self.pageNo == 1) {
            self.homeSafeModelArray = homeSafeModelArray.mutableCopy;
        } else {
            if (homeSafeModelArray.count > 0) {
                [self.homeSafeModelArray addObjectsFromArray:homeSafeModelArray];
            } else {
                [self.homeSafeTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.homeSafeTableView reloadData];
    }];
}

- (void)loadHomeSafeView {
    @weakify(self);
    self.searchView.searchBlock = ^{
        @strongify(self);
        [self searchAction];
    };
    
    self.homeSafeSearchVC = [ZHLZHomeSafeSearchVC new];
    self.homeSafeSearchVC.selectSearchBlock = ^(ZHLZHomeSafeSearchModel * _Nonnull homeSafeSearchModel) {
        @strongify(self);
        self.homeSafeSearchModel = homeSafeSearchModel;
        
        [self loadHomeSafeList];
    };
    
    self.homeSafeModelArray = [NSMutableArray <ZHLZHomeSafeModel *> new];
    
    self.homeSafeTableView.dataSource = self;
    self.homeSafeTableView.delegate = self;
    self.homeSafeTableView.emptyDataSetSource = self;
    self.homeSafeTableView.emptyDataSetDelegate = self;
    
    [self.homeSafeTableView registerNib:[UINib nibWithNibName:ZHLZHomeSafeReuseIdentifier bundle:nil] forCellReuseIdentifier:ZHLZHomeSafeReuseIdentifier];
    
    self.homeSafeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeList)];
    self.homeSafeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeList)];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeSafeModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHLZHomeSafeReuseIdentifier];
    if (cell == nil) {
        cell = [[ZHLZHomeSafeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHLZHomeSafeReuseIdentifier];
    }
    cell.homeSafeModel = self.homeSafeModelArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeSafeModel *safeModel = self.homeSafeModelArray[indexPath.row];
    ZHLZHomeSafeDetailVC *homeSafeDetailVC = [ZHLZHomeSafeDetailVC new];
    homeSafeDetailVC.type = 2;
    homeSafeDetailVC.detailId = [NSString stringWithFormat:@"%@", safeModel.objectID];
    [self.navigationController pushViewController:homeSafeDetailVC animated:YES];
}


#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return kEmptyDataNoReservationLook;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [self emptyDataTip:@"~暂无数据哟~"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    self.pageNo = 1;
    [self loadHomeSafeList];
}


@end
