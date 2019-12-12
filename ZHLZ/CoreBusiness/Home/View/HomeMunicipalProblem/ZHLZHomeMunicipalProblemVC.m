//
//  ZHLZHomeMunicipalProblemVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMunicipalProblemVC.h"
#import "ZHLZHomeMunicipalProblemVM.h"
#import "ZHLZHomeMunicipalProblemSearchVC.h"
#import "ZHLZHomeMunicipalProblemTableViewCell.h"
#import "ZHLZHomeMunicipalProblemDetailVC.h"

#define ZHLZHomeMunicipalProblemReuseIdentifier NSStringFromClass([ZHLZHomeMunicipalProblemTableViewCell class])

@interface ZHLZHomeMunicipalProblemVC () <UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet ZHLZSearchView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ZHLZHomeMunicipalProblemSearchVC *homeMunicipalProblemSearchVC;

@property (nonatomic, strong) ZHLZHomeMunicipalProblemSearchModel *homeMunicipalProblemSearchModel;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeMunicipalProblemModel *> *array;

@end

@implementation ZHLZHomeMunicipalProblemVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    }
    
    self.array = @[].mutableCopy;
    self.homeMunicipalProblemSearchModel = [ZHLZHomeMunicipalProblemSearchModel new];
    
    self.searchView.isExistRangeSearchSwitch = YES;
    self.searchView.searchBlock = ^{
        @strongify(self);
        [self searchAction];
    };
    self.searchView.onOrOffBlock = ^(BOOL isOn) {
        @strongify(self);
        if (isOn) {
            if (![self.homeMunicipalProblemSearchModel.rangeleg isNotBlank]) {
                self.homeMunicipalProblemSearchModel.rangeleg = @"500";
            }
            self.homeMunicipalProblemSearchModel.isrange = @"1";
            
            NSDictionary *coordinate = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentLocationCoordinateConst];
            if (coordinate) {
                self.homeMunicipalProblemSearchModel.lng = [coordinate objectForKey:@"longitude"];
                self.homeMunicipalProblemSearchModel.lat = [coordinate objectForKey:@"latitude"];
            }
        } else {
            self.homeMunicipalProblemSearchModel.rangeleg = nil;
            self.homeMunicipalProblemSearchModel.isrange = nil;
            self.homeMunicipalProblemSearchModel.lng = nil;
            self.homeMunicipalProblemSearchModel.lat = nil;
        }
        
        [self loadData];
    };
    
    self.homeMunicipalProblemSearchVC = [ZHLZHomeMunicipalProblemSearchVC new];
    self.homeMunicipalProblemSearchVC.selectSearchBlock = ^(ZHLZHomeMunicipalProblemSearchModel * _Nonnull homeMunicipalProblemSearchModel) {
        @strongify(self);
        self.homeMunicipalProblemSearchModel = homeMunicipalProblemSearchModel;
        
        [self loadData];
    };
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:ZHLZHomeMunicipalProblemReuseIdentifier bundle:nil] forCellReuseIdentifier:ZHLZHomeMunicipalProblemReuseIdentifier];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self loadData];
}

- (void)loadData {
    @weakify(self);
    if (self.tableView.mj_footer.isRefreshing) {
        self.pageNo++;
    } else {
        self.pageNo = 1;
        [self.tableView.mj_footer resetNoMoreData];
    }
    self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] loadHomeMunicipalProblemDataWithPageNo:self.pageNo withModel:self.homeMunicipalProblemSearchModel withBlock:^(NSArray<ZHLZHomeMunicipalProblemModel *> * _Nonnull array, NSError * _Nonnull error) {
        @strongify(self);
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        if (error) {
            self.searchView.isOnSwitch = NO;
            return;
        }
        
        if (self.pageNo == 1) {
            self.array = array.mutableCopy;
        } else {
            if (array && array.count > 0) {
                [self.array addObjectsFromArray:array];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        [self.tableView reloadData];
    }];
}

#pragma mark - Action

- (void)addAction {
    ZHLZHomeMunicipalProblemDetailVC *homeMunicipalProblemDetailVC = [ZHLZHomeMunicipalProblemDetailVC new];
    homeMunicipalProblemDetailVC.type = 1;
    homeMunicipalProblemDetailVC.reloadDataBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:homeMunicipalProblemDetailVC animated:YES];
}

- (void)searchAction {
    [self presentViewController:self.homeMunicipalProblemSearchVC animated:NO completion:^{
        [self.homeMunicipalProblemSearchVC showFilterView];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeMunicipalProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHLZHomeMunicipalProblemReuseIdentifier];
    if (cell == nil) {
        cell = [[ZHLZHomeMunicipalProblemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHLZHomeMunicipalProblemReuseIdentifier];
    }
    [cell homeMunicipalProblemModel:self.array[indexPath.row] andWithIndex:indexPath.row];
    
    cell.clickButton = ^(NSInteger selectIndex) {
        ZHLZHomeMunicipalProblemModel *municipalProblemModel = self.array[selectIndex];
                
                if ([municipalProblemModel.problemStatus integerValue] == 2) {///开启
                    
                    @weakify(self);
                    [self popActionWithTip:@"是否开启问题？" withBlock:^{
                        @strongify(self);
                        self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] openMunicipalProblemWithId:municipalProblemModel.objectID withBlock:^{
                            
                            municipalProblemModel.problemStatus = @"0";
                            [self.array replaceObjectAtIndex:selectIndex withObject:municipalProblemModel];
        
                            [self.tableView reloadData];
                            [GRToast makeText:@"开启成功"];
                        }];
                    }];
                    
                } else {///关闭
                    
                    @weakify(self);
                    [self popActionWithTip:@"是否关闭问题？" withBlock:^{
                        @strongify(self);
                        self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] closeMunicipalProblemWithParms:@{@"id":municipalProblemModel.objectID,@"closeType":@""} withBlock:^{
                            @strongify(self);
                            municipalProblemModel.problemStatus = @"2";
                            [self.array replaceObjectAtIndex:selectIndex withObject:municipalProblemModel];
                            [self.tableView reloadData];
                            [GRToast makeText:@"关闭成功"];
                        }];
                    }];
                }
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeMunicipalProblemModel *model = self.array[indexPath.row];
    if (model) {
        ZHLZHomeMunicipalProblemDetailVC *homeMunicipalProblemDetailVC = [ZHLZHomeMunicipalProblemDetailVC new];
        homeMunicipalProblemDetailVC.detailId = model.objectID;
        homeMunicipalProblemDetailVC.type = 2;
        [self.navigationController pushViewController:homeMunicipalProblemDetailVC animated:YES];
    }
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
    [self loadData];
}


@end
