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
#import "ZHLZHomeBuildProjectDetailVC.h"



@interface ZHLZHomeBuildProjectVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hmeBuildProjectTableView;

@property (nonatomic , assign) NSInteger pageNum;

@property (nonatomic , strong) NSMutableArray <ZHLZHomeBuildProjectModel *> *homeBuildProjectModelArray;

@end

@implementation ZHLZHomeBuildProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    
    [self loadHomeProjectBuildView];
    
    [self loadHomeProjectBuildData];
}

- (void)addAction {
    
    ZHLZHomeBuildProjectDetailVC *homeBuildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
    homeBuildProjectDetailVC.detailType = 1;
    [self.navigationController pushViewController:homeBuildProjectDetailVC animated:YES];
}

- (void)loadHomeProjectBuildData{
    @weakify(self)
    self.task = [[ZHLZHomeBuildProjectVM sharedInstance] loadHomeBuildProjectDataWithPageNum:self.pageNum WithBlock:^(NSArray<ZHLZHomeBuildProjectModel *> * _Nonnull homeBuildProjectModelArray) {
        @strongify(self)
        
        if (self.hmeBuildProjectTableView.mj_header.isRefreshing) {
            [self.hmeBuildProjectTableView.mj_header endRefreshing];
        }
        if ([self.hmeBuildProjectTableView.mj_footer isRefreshing]) {
            [self.hmeBuildProjectTableView.mj_footer endRefreshing];
        }
        
        if (self.pageNum == 1) {
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

- (void)loadHomeProjectBuildView{
    
    self.pageNum = 1;
    
    self.homeBuildProjectModelArray = [NSMutableArray <ZHLZHomeBuildProjectModel *> new];
    
    self.hmeBuildProjectTableView.dataSource = self;
    self.hmeBuildProjectTableView.delegate = self;
    self.hmeBuildProjectTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.hmeBuildProjectTableView.showsVerticalScrollIndicator = NO;
    
    [self.hmeBuildProjectTableView registerNib:[UINib nibWithNibName:@"ZHLZHomeBuildProjectCell" bundle:nil] forCellReuseIdentifier:@"ZHLZHomeBuildProjectCell"];
    
    self.hmeBuildProjectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeBuildProjectHeader)];
    self.hmeBuildProjectTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeBuildProjectHeaderFooter)];
}

- (void)loadHomeBuildProjectHeader{
    self.pageNum = 1;
    
    [self loadHomeProjectBuildData];
}

- (void)loadHomeBuildProjectHeaderFooter{
    self.pageNum ++;
    
    [self loadHomeProjectBuildData];
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeBuildProjectModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZHomeBuildProjectCell";

    ZHLZHomeBuildProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZHomeBuildProjectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.homeBuildProjectModel  = self.homeBuildProjectModelArray[indexPath.row];
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHLZHomeBuildProjectModel *homeBuildProjectModel = self.homeBuildProjectModelArray[indexPath.row];
    
    ZHLZHomeBuildProjectDetailVC *homeBuildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
    homeBuildProjectDetailVC.detailType = 2;
    homeBuildProjectDetailVC.detailId = [NSString stringWithFormat:@"%@",homeBuildProjectModel.objectID];
    [self.navigationController pushViewController:homeBuildProjectDetailVC animated:YES];

}



@end
