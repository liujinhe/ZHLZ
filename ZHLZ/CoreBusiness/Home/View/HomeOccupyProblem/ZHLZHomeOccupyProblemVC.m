//
//  ZHLZHomeOccupyProblemVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeOccupyProblemVC.h"
#import "ZHLZHomeOccupyProblemVM.h"
#import "ZHLZHomeOccupyProblemSearchVC.h"
#import "ZHLZHomeOccupyProblemTableViewCell.h"
#import "ZHLZHomeOccupyProblemDetailVC.h"

#define ZHLZHomeOccupyProblemReuseIdentifier NSStringFromClass([ZHLZHomeOccupyProblemTableViewCell class])

@interface ZHLZHomeOccupyProblemVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet ZHLZSearchView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ZHLZHomeOccupyProblemSearchVC *homeOccupyProblemSearchVC;

@property (nonatomic, strong) ZHLZHomeOccupyProblemSearchModel *homeOccupyProblemSearchModel;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeOccupyProblemModel *> *array;

@end

@implementation ZHLZHomeOccupyProblemVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    }
    
    self.array = @[].mutableCopy;
    self.homeOccupyProblemSearchModel = [ZHLZHomeOccupyProblemSearchModel new];
    
    self.searchView.isExistRangeSearchSwitch = YES;
    self.searchView.searchBlock = ^{
         @strongify(self);
         [self searchAction];
     };
    self.searchView.onOrOffBlock = ^(BOOL isOn) {
         @strongify(self);
         if (isOn) {
             if (![self.homeOccupyProblemSearchModel.rangeleg isNotBlank]) {
                 self.homeOccupyProblemSearchModel.rangeleg = @"500";
             }
             self.homeOccupyProblemSearchModel.rangeleg = 
             
             self.homeOccupyProblemSearchModel.isrange = @"1";
             
             NSDictionary *coordinate = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentLocationCoordinateConst];
             if (coordinate) {
                 self.homeOccupyProblemSearchModel.lng = [coordinate objectForKey:@"longitude"];
                 self.homeOccupyProblemSearchModel.lat = [coordinate objectForKey:@"latitude"];
             }
         } else {
             self.homeOccupyProblemSearchModel.rangeleg = nil;
             self.homeOccupyProblemSearchModel.isrange = nil;
             self.homeOccupyProblemSearchModel.lng = nil;
             self.homeOccupyProblemSearchModel.lat = nil;
         }
         
         [self loadData];
     };
    
    self.homeOccupyProblemSearchVC = [ZHLZHomeOccupyProblemSearchVC new];
    self.homeOccupyProblemSearchVC.selectSearchBlock = ^(ZHLZHomeOccupyProblemSearchModel * _Nonnull homeOccupyProblemSearchModel) {
        @strongify(self);
        self.homeOccupyProblemSearchModel = homeOccupyProblemSearchModel;
        
        [self loadData];
    };
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:ZHLZHomeOccupyProblemReuseIdentifier bundle:nil] forCellReuseIdentifier:ZHLZHomeOccupyProblemReuseIdentifier];
    
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
    self.task = [[ZHLZHomeOccupyProblemVM sharedInstance] loadHomeOccupyProblemDataWithPageNo:self.pageNo withModel:self.homeOccupyProblemSearchModel withBlock:^(NSArray<ZHLZHomeOccupyProblemModel *> * _Nonnull array, NSError * _Nonnull error) {
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
    ZHLZHomeOccupyProblemDetailVC *homeOccupyProblemDetailVC = [ZHLZHomeOccupyProblemDetailVC new];
    homeOccupyProblemDetailVC.type = 1;
    homeOccupyProblemDetailVC.reloadDataBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:homeOccupyProblemDetailVC animated:YES];
}

- (void)searchAction {
    [self presentViewController:self.homeOccupyProblemSearchVC animated:NO completion:^{
        [self.homeOccupyProblemSearchVC showFilterView];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeOccupyProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHLZHomeOccupyProblemReuseIdentifier];
    if (cell == nil) {
        cell = [[ZHLZHomeOccupyProblemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHLZHomeOccupyProblemReuseIdentifier];
    }
    
    [cell homeOccupyProblem:self.array[indexPath.row] withIndex:indexPath.row];
    
    cell.clickButton = ^(NSInteger selectIndex) {
        ZHLZHomeOccupyProblemModel *occupyProblemModel = self.array[selectIndex];
        
        if ([occupyProblemModel.prostatus integerValue] == 1) {///开启
            
            @weakify(self);
            [self popActionWithTip:@"是否开启问题？" withBlock:^{
                @strongify(self);
                self.task = [[ZHLZHomeOccupyProblemVM sharedInstance] openOccupyProblemWithId:occupyProblemModel.proid withBlock:^{
                    
                    occupyProblemModel.prostatus = @"0";
                    [self.array replaceObjectAtIndex:selectIndex withObject:occupyProblemModel];

                    [self.tableView reloadData];
                    [GRToast makeText:@"开启成功"];
                }];
            }];
            
        } else {///关闭
            
            @weakify(self);
            [self popActionWithTip:@"是否关闭问题？" withBlock:^{
                @strongify(self);
                self.task = [[ZHLZHomeOccupyProblemVM sharedInstance] closeOccupyProblemWithParms:@{@"id":occupyProblemModel.proid,@"closeType":@""} withBlock:^{
                    @strongify(self);
                    occupyProblemModel.prostatus = @"1";
                    [self.array replaceObjectAtIndex:selectIndex withObject:occupyProblemModel];
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
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeOccupyProblemModel *model = self.array[indexPath.row];
    if (model) {
        ZHLZHomeOccupyProblemDetailVC *homeOccupyProblemDetailVC = [ZHLZHomeOccupyProblemDetailVC new];
        homeOccupyProblemDetailVC.detailId = model.proid;
        homeOccupyProblemDetailVC.type = 2;
        [self.navigationController pushViewController:homeOccupyProblemDetailVC animated:YES];
    }
}

@end
