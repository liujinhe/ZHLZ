//
//  ZHLZHomeInfoStatisticsListVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/29.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeInfoStatisticsListVC.h"
#import "ZHLZHomeInfoStatisticsVM.h"
#import "ZHLZHomeInfoStatisticsTableViewCell.h"

#define ZHLZHomeInfoStatisticsReuseIdentifier NSStringFromClass([ZHLZHomeInfoStatisticsTableViewCell class])

@interface ZHLZHomeInfoStatisticsListVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<ZHLZHomeInfoStatisticsModel *> *array;

@end

@implementation ZHLZHomeInfoStatisticsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:ZHLZHomeInfoStatisticsReuseIdentifier bundle:nil]
         forCellReuseIdentifier:ZHLZHomeInfoStatisticsReuseIdentifier];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self loadData];
}

- (void)loadData {
    @weakify(self);
    self.task = [[ZHLZHomeInfoStatisticsVM sharedInstance] loadHomeInfoStatisticsDataWithType:self.type withBlock:^(NSArray<ZHLZHomeInfoStatisticsModel *> * _Nonnull array) {
        @strongify(self);
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        self.array = array;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeInfoStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHLZHomeInfoStatisticsReuseIdentifier forIndexPath:indexPath];
    if (cell) {
        cell.homeInfoStatisticsModel = self.array[indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
