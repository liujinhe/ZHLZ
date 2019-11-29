//
//  ZHLZHomeRoadPatrolVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeRoadPatrolVC.h"
#import "ZHLZHomeRoadPatrolVM.h"
#import "ZHLZHomeRoadPatrolTableViewCell.h"
#import "ZHLZWebViewVC.h"

#define ZHLZHomeRoadPatrolReuseIdentifier NSStringFromClass([ZHLZHomeRoadPatrolTableViewCell class])

@interface ZHLZHomeRoadPatrolVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_startDate;
    NSString *_endDate;
}

@property (weak, nonatomic) IBOutlet ZHLZDateSearchView *dateSearchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeRoadPatrolModel *> *array;

@property (nonatomic, strong) NSMutableArray *heightArray;

@end

@implementation ZHLZHomeRoadPatrolVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.array = @[].mutableCopy;
    
    _startDate = [NSString formatterBeforeOrAfterDateWithDate:[NSDate date] withMonth:-1];
    _endDate = [NSString formatterWithDate:[NSDate date]];
    
    self.dateSearchView.currentVC = self;
    self.dateSearchView.startDate = _startDate;
    self.dateSearchView.endDate = _endDate;
    self.dateSearchView.searchWithDateBlock = ^(NSString * _Nonnull startDate, NSString * _Nonnull endDate) {
        @strongify(self);
        
        self->_startDate = startDate;
        self->_endDate = endDate;

        [self loadData];
    };
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:ZHLZHomeRoadPatrolReuseIdentifier bundle:nil] forCellReuseIdentifier:ZHLZHomeRoadPatrolReuseIdentifier];
    
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
    self.task = [[ZHLZHomeRoadPatrolVM sharedInstance] loadHomeRoadPatrolWithPageNo:self.pageNo withStartDate:_startDate withEndDate:_endDate withBlock:^(NSArray<ZHLZHomeRoadPatrolModel *> * _Nonnull array) {
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
        
        self.heightArray = @[].mutableCopy;
        for (ZHLZHomeRoadPatrolModel *model in self.array) {
            CGFloat height = [model.remark sizeForFont:kFont(12) size:CGSizeMake(kScreenWidth - 10.f * 2 - 10.f * 2 - 38.f - 5.f, MAXFLOAT) mode:NSLineBreakByCharWrapping].height;
            height = height > 0 ? 110.f + height : 110.f;
            [self.heightArray addObject:@(height)];
        }
        
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeRoadPatrolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHLZHomeRoadPatrolReuseIdentifier];
    if (cell == nil) {
        cell = [[ZHLZHomeRoadPatrolTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHLZHomeRoadPatrolReuseIdentifier];
    }
    cell.homeRoadPatrolModel = self.array[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.heightArray[indexPath.row] floatValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZHomeRoadPatrolModel *model = self.array[indexPath.row];
    if (model) {
        ZHLZWebViewVC *webViewVC = [ZHLZWebViewVC new];
        webViewVC.url = @"/summary.html?type=1";
        [self.navigationController pushViewController:webViewVC animated:YES];
    }
}

@end
