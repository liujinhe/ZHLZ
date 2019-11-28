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

@interface ZHLZHomeMunicipalProblemVC () <UITableViewDataSource, UITableViewDelegate>

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
    self.searchView.openOrCloseBlock = ^(NSInteger status) {
        @strongify(self);
        if (status == 1) {
            self.homeMunicipalProblemSearchModel.isrange = @"1";
            ZHLZUserModel *userModel = [ZHLZUserModel new];
            if (userModel) {
                self.homeMunicipalProblemSearchModel.lng = userModel.longitude;
                self.homeMunicipalProblemSearchModel.lat = userModel.latitude;
            }
        } else {
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
    
    [self.tableView registerNib:[UINib nibWithNibName:ZHLZHomeMunicipalProblemReuseIdentifier bundle:nil] forCellReuseIdentifier:ZHLZHomeMunicipalProblemReuseIdentifier];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
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
    self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] loadHomeMunicipalProblemDataWithPageNo:self.pageNo withModel:self.homeMunicipalProblemSearchModel withBlock:^(NSArray<ZHLZHomeMunicipalProblemModel *> * _Nonnull array) {
        @strongify(self);
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
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
    cell.homeMunicipalProblemModel = self.array[indexPath.row];
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
        [self.navigationController pushViewController:homeMunicipalProblemDetailVC animated:YES];
    }
}

@end
