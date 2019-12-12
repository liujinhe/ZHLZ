//
//  ZHLZHomeBuildProjectVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectVC.h"
#import "ZHLZHomeBuildProjectCell.h"
#import "ZHLZHomeBuildProjectVM.h"
#import "ZHLZBuildProjectSearchVC.h"
#import "ZHLZHomeBuildProjectDetailVC.h"

#define ZHLZHomeBuildProjectReuseIdentifier NSStringFromClass([ZHLZHomeBuildProjectCell class])

@interface ZHLZHomeBuildProjectVC () <UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet ZHLZSearchView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *hmeBuildProjectTableView;

@property (nonatomic, strong) ZHLZBuildProjectSearchVC *buildProjectSearchVC;

@property (nonatomic, strong) ZHLZBuildProjectSearchModel *buildProjectSearchModel;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeBuildProjectModel *> *homeBuildProjectModelArray;

@end

@implementation ZHLZHomeBuildProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    }
    
    [self loadHomeProjectBuildView];
    
    [self loadHomeProjectBuildData];
}

- (void)addAction {
    ZHLZHomeBuildProjectDetailVC *homeBuildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
    homeBuildProjectDetailVC.detailType = 1;
    homeBuildProjectDetailVC.reloadDataBlock = ^{
        [self.hmeBuildProjectTableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:homeBuildProjectDetailVC animated:YES];
}

- (void)searchAction {
    [self presentViewController:self.buildProjectSearchVC animated:NO completion:^{
        [self.buildProjectSearchVC showFilterView];
    }];
}

- (void)loadHomeProjectBuildData {
    @weakify(self)
    if (self.hmeBuildProjectTableView.mj_footer.isRefreshing) {
        self.pageNo++;
    } else {
        self.pageNo = 1;
        [self.hmeBuildProjectTableView.mj_footer resetNoMoreData];
    }
    self.task = [[ZHLZHomeBuildProjectVM sharedInstance] loadHomeBuildProjectDataWithPageNum:self.pageNo withModel:self.buildProjectSearchModel withBlock:^(NSArray<ZHLZHomeBuildProjectModel *> * _Nonnull homeBuildProjectModelArray) {
        @strongify(self)
        
        if (self.hmeBuildProjectTableView.mj_header.isRefreshing) {
            [self.hmeBuildProjectTableView.mj_header endRefreshing];
        }
        if ([self.hmeBuildProjectTableView.mj_footer isRefreshing]) {
            [self.hmeBuildProjectTableView.mj_footer endRefreshing];
        }
        
        if (self.pageNo == 1) {
            self.homeBuildProjectModelArray = homeBuildProjectModelArray.mutableCopy;
        } else {
            if (homeBuildProjectModelArray.count > 0) {
                [self.homeBuildProjectModelArray addObjectsFromArray:homeBuildProjectModelArray];
            } else {
                [self.hmeBuildProjectTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        [self.hmeBuildProjectTableView reloadData];
    }];
}

- (void)loadHomeProjectBuildView {
    @weakify(self);
    self.searchView.searchBlock = ^{
        @strongify(self);
        [self searchAction];
    };
    
    self.buildProjectSearchVC = [ZHLZBuildProjectSearchVC new];
    self.buildProjectSearchVC.selectSearchBlock = ^(ZHLZBuildProjectSearchModel * _Nonnull buildProjectSearchModel) {
        @strongify(self);
        self.buildProjectSearchModel = buildProjectSearchModel;
        
        [self loadHomeProjectBuildData];
    };
    
    self.buildProjectSearchModel = [ZHLZBuildProjectSearchModel new];
    
    self.homeBuildProjectModelArray = [NSMutableArray <ZHLZHomeBuildProjectModel *> new];
    
    self.hmeBuildProjectTableView.dataSource = self;
    self.hmeBuildProjectTableView.delegate = self;
    self.hmeBuildProjectTableView.emptyDataSetSource = self;
    self.hmeBuildProjectTableView.emptyDataSetDelegate = self;
    
    [self.hmeBuildProjectTableView registerNib:[UINib nibWithNibName:ZHLZHomeBuildProjectReuseIdentifier bundle:nil]
                        forCellReuseIdentifier:ZHLZHomeBuildProjectReuseIdentifier];
    
    self.hmeBuildProjectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeProjectBuildData)];
    self.hmeBuildProjectTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeProjectBuildData)];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeBuildProjectModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeBuildProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHLZHomeBuildProjectReuseIdentifier];
    if (cell == nil) {
        cell = [[ZHLZHomeBuildProjectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHLZHomeBuildProjectReuseIdentifier];
    }
    cell.homeBuildProjectModel  = self.homeBuildProjectModelArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeBuildProjectModel *homeBuildProjectModel = self.homeBuildProjectModelArray[indexPath.row];
    
    ZHLZHomeBuildProjectDetailVC *homeBuildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
    homeBuildProjectDetailVC.detailType = 2;
    homeBuildProjectDetailVC.detailId = [NSString stringWithFormat:@"%@",homeBuildProjectModel.objectID];
    [self.navigationController pushViewController:homeBuildProjectDetailVC animated:YES];
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
    [self loadHomeProjectBuildData];
}


@end
