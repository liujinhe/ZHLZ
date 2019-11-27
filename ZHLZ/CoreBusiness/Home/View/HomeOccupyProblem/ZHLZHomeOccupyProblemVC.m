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

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ZHLZHomeOccupyProblemSearchVC *homeOccupyProblemSearchVC;

@property (nonatomic, strong) ZHLZHomeOccupyProblemSearchModel *homeOccupyProblemSearchModel;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeOccupyProblemModel *> *array;

@end

@implementation ZHLZHomeOccupyProblemVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.array = @[].mutableCopy;
    
    self.homeOccupyProblemSearchModel = [ZHLZHomeOccupyProblemSearchModel new];
    
    [self addRightBarButtonItemWithImageName:@"icon_search_light" action:@selector(searchAction)];
    
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
    self.task = [[ZHLZHomeOccupyProblemVM sharedInstance] loadHomeOccupyProblemDataWithPageNo:self.pageNo withModel:self.homeOccupyProblemSearchModel withBlock:^(NSArray<ZHLZHomeOccupyProblemModel *> * _Nonnull array) {
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
    cell.homeOccupyProblemModel = self.array[indexPath.row];
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
        homeOccupyProblemDetailVC.detailId = model.objectID;
        homeOccupyProblemDetailVC.type = 2;
        [self.navigationController pushViewController:homeOccupyProblemDetailVC animated:YES];
    }
}

@end
