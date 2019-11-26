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

@interface ZHLZHomeSafeVC ()<UITableViewDelegate , UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *homeSafeTableView;

@property (nonatomic , assign) NSInteger pageNum;

@property (nonatomic , strong) NSMutableArray <ZHLZHomeSafeModel *> *homeSafeModelArray;

@end

@implementation ZHLZHomeSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithTitle:@"添加" action:@selector(addAction)];
    
    [self loadHomeSafeView];
    
    [self loadHomeSafeList];
}

- (void)addAction {
    ZHLZHomeSafeDetailVC *homeSafeDetailVC = [ZHLZHomeSafeDetailVC new];
    homeSafeDetailVC.type = 1;
    [self.navigationController pushViewController:homeSafeDetailVC animated:YES];
}

- (void)loadHomeSafeList{
    @weakify(self)
    self.task = [[ZHLZHomeSafeVM sharedInstance] loadHomeSafeDataWithPageNum:self.pageNum WithBlock:^(NSArray<ZHLZHomeSafeModel *> * _Nonnull homeSafeModelArray) {
        @strongify(self)
        if (self.homeSafeTableView.mj_header.isRefreshing) {
            [self.homeSafeTableView.mj_header endRefreshing];
        }
        if ([self.homeSafeTableView.mj_footer isRefreshing]) {
            [self.homeSafeTableView.mj_footer endRefreshing];
        }

        if (self.pageNum == 1) {
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

- (void)loadHomeSafeView{
    
    self.pageNum = 1;
    
    self.homeSafeModelArray = [NSMutableArray <ZHLZHomeSafeModel *> new];
    
    self.homeSafeTableView.dataSource = self;
    self.homeSafeTableView.delegate = self;
    self.homeSafeTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.homeSafeTableView.showsVerticalScrollIndicator = NO;
    
    [self.homeSafeTableView registerNib:[UINib nibWithNibName:@"ZHLZHomeSafeCell" bundle:nil] forCellReuseIdentifier:@"ZHLZHomeSafeCell"];
    
    self.homeSafeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeHeader)];
    self.homeSafeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeFooter)];
}

- (void)loadHomeSafeHeader{
    self.pageNum = 1;
    [self loadHomeSafeList];
}

- (void)loadHomeSafeFooter{
    self.pageNum ++;
    [self loadHomeSafeList];
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeSafeModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZHomeSafeCell";

    ZHLZHomeSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZHomeSafeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.homeSafeModel = self.homeSafeModelArray[indexPath.row];

    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHLZHomeSafeModel *safeModel = self.homeSafeModelArray[indexPath.row];
    ZHLZHomeSafeDetailVC *homeSafeDetailVC = [ZHLZHomeSafeDetailVC new];
    homeSafeDetailVC.type = 2;
    homeSafeDetailVC.detailId = [NSString stringWithFormat:@"%@",safeModel.objectID];
    [self.navigationController pushViewController:homeSafeDetailVC animated:YES];
}



@end
