//
//  ZHLZBookListVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBookListVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZBookListCell.h"
#import "ZHLZAddressBookVM.h"

#import "ZHLZMonadModel.h"
#import "ZHLZSpecialModel.h"
#import "ZHLZCityManagementModel.h"
#import "ZHLZAreaManagementModel.h"
#import "ZHLZConstructionModel.h"
#import "ZHLZExamineModel.h"
#import "ZHLZRoadWorkModel.h"


#import "ZHLZRoadWorkVC.h"//施工单位
#import "ZHLZExamineVC.h"//审批部门
#import "ZHLZConstructionVC.h"//建设单位

#import "ZHLZAreaManagementVC.h"//区管管理单位
#import "ZHLZCityManagementVC.h"//市管管理单位
#import "ZHLZSpecialVC.h"//特殊业主单位

#import "ZHLZMonadVC.h"//责任单位


@interface ZHLZBookListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bookListTableView;


@property (nonatomic , strong) ZHLZMonadModel *monadModel;//责任单位
@property (nonatomic , strong) ZHLZSpecialModel *specialModel;//特殊业主单位
@property (nonatomic , strong) ZHLZCityManagementModel *cityManagementModel;//市管单位
@property (nonatomic , strong) ZHLZAreaManagementModel *areaManagementModel;//区管单位
@property (nonatomic , strong) ZHLZConstructionModel *constructionModel;//建设单位
@property (nonatomic , strong) ZHLZExamineModel *examineModel;//审批单位
@property (nonatomic , strong) ZHLZRoadWorkModel *roadWorkModel;//施工单位





@property (nonatomic , assign) NSInteger pageNum;

@property (nonatomic , assign) NSInteger clickIndex;

@end

@implementation ZHLZBookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBookListView];
    
    [self loadAddressListData];
}

- (void)loadAddressListData{
    self.task = [[ZHLZAddressBookVM sharedInstance] loadListWithType:self.selectIndex withPageNum:self.pageNum CallBack:^(NSDictionary * _Nonnull parms) {
        
        if (self.bookListTableView.mj_header.isRefreshing) {
            [self.bookListTableView.mj_header endRefreshing];
        }
        
        self.pageNum ++;
        
        if (self.selectIndex == 0) {
            self.roadWorkModel = [ZHLZRoadWorkModel modelWithJSON:parms];
            
        } else if(self.selectIndex == 1){
            self.examineModel = [ZHLZExamineModel modelWithJSON:parms];
            
        } else if(self.selectIndex == 2){
            self.constructionModel = [ZHLZConstructionModel modelWithJSON:parms];
            
        } else if(self.selectIndex == 3){
            self.cityManagementModel = [ZHLZCityManagementModel modelWithJSON:parms];
            
        } else if(self.selectIndex == 4){
            self.areaManagementModel = [ZHLZAreaManagementModel modelWithJSON:parms];
            
        } else if(self.selectIndex == 5){
            self.specialModel = [ZHLZSpecialModel modelWithJSON:parms];
            
        } else if(self.selectIndex == 6){
            self.monadModel = [ZHLZMonadModel modelWithJSON:parms];
        }
        
        [self.bookListTableView reloadData];
        
    }];
}

- (void)loadAddressListHeader{
    self.pageNum = 1;
    [self loadAddressListData];
}

#pragma mark --初始化视图

- (void)initBookListView{
    
    self.pageNum = 1;
    
    self.title = self.titleNameString;
    
    UIButton *areaManagementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [areaManagementButton setTitle:@"添加" forState:UIControlStateNormal];
    [areaManagementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [areaManagementButton sizeToFit];
    @weakify(self);
    [areaManagementButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id _Nonnull sender) {
        @strongify(self);
        [self clickAddActionwithType:1];
    }];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:areaManagementButton]];
    
    
    
    self.bookListTableView.dataSource = self;
    self.bookListTableView.delegate = self;
    self.bookListTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.bookListTableView.showsVerticalScrollIndicator = NO;
    
    [self.bookListTableView registerNib:[UINib nibWithNibName:@"ZHLZBookListCell" bundle:nil] forCellReuseIdentifier:@"ZHLZBookListCell"];
    
    self.bookListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadAddressListHeader)];
    self.bookListTableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadAddressListData)];
    
}

- (void)clickAddActionwithType:(NSInteger)type{
    
    if (self.selectIndex == 0) {
        RoadWorkList *list = self.roadWorkModel.list[self.clickIndex];
        ZHLZRoadWorkVC *roadWorkVC = [ZHLZRoadWorkVC new];
        roadWorkVC.editType = type;
        if (type == 2) {
            roadWorkVC.roadWorkModel = list;
        }
        roadWorkVC.reloadDataBlock = ^{
            [self.bookListTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:roadWorkVC animated:YES];
        
    } else if(self.selectIndex == 1){
        ExamineList *list = self.examineModel.list[self.clickIndex];
        ZHLZExamineVC *examineVC = [ZHLZExamineVC new];
        examineVC.setType = type;
        if (type == 2) {
            examineVC.examineModel = list;
        }
        examineVC.reloadDataBlock = ^{
            [self.bookListTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:examineVC animated:YES];
        
    } else if(self.selectIndex == 2){
        ConstructionList *list = self.constructionModel.list[self.clickIndex];
        ZHLZConstructionVC *constructionVC = [ZHLZConstructionVC new];
        constructionVC.setType = type;
        if (type == 2) {
            constructionVC.constructionModel = list;
        }
        constructionVC.reloadDataBlock = ^{
            [self.bookListTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:constructionVC animated:YES];
        
    } else if(self.selectIndex == 3){
        CityManagementList *list = self.cityManagementModel.list[self.clickIndex];
        ZHLZCityManagementVC *areaManagementVC = [ZHLZCityManagementVC new];
        areaManagementVC.setType = type;
        if (type == 2) {
            areaManagementVC.cityManagementModel = list;
        }
        areaManagementVC.reloadDataBlock = ^{
            [self.bookListTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:areaManagementVC animated:YES];
        
    } else if(self.selectIndex == 4){
        AreaManagementList *list = self.areaManagementModel.list[self.clickIndex];
        ZHLZAreaManagementVC *areaManagementVC = [ZHLZAreaManagementVC new];
        areaManagementVC.setType = type;
        if (type == 2) {
            areaManagementVC.areaManagementModel = list;
        }
        areaManagementVC.reloadDataBlock = ^{
            [self.bookListTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:areaManagementVC animated:YES];
        
    } else if(self.selectIndex == 5){
        SpecialList *list = self.specialModel.list[self.clickIndex];
        ZHLZSpecialVC *specialVC = [ZHLZSpecialVC new];
        specialVC.setType = type;
        if (type == 2) {
            specialVC.specialModel = list;
        }
        specialVC.reloadDataBlock = ^{
            [self.bookListTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:specialVC animated:YES];
        
    } else if(self.selectIndex == 6){
        MonadModelList *list = self.monadModel.list[self.clickIndex];
        ZHLZMonadVC *monadVC = [ZHLZMonadVC new];
        monadVC.setType = type;
        if (type == 2) {
            monadVC.monadModel = list;
        }
        monadVC.reloadDataBlock = ^{
            [self.bookListTableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:monadVC animated:YES];
    }
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.selectIndex == 0) {
        return self.roadWorkModel.list.count;
    } else if(self.selectIndex == 1){
        return self.examineModel.list.count;
    } else if(self.selectIndex == 2){
        return self.constructionModel.list.count;
    } else if(self.selectIndex == 3){
        return self.cityManagementModel.list.count;
    } else if(self.selectIndex == 4){
        return self.areaManagementModel.list.count;
    } else if(self.selectIndex == 5){
        return self.specialModel.list.count;
    } else if(self.selectIndex == 6){
        return self.monadModel.list.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZBookListCell";

    ZHLZBookListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZBookListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }


    if (self.selectIndex == 0) {
        cell.roadWorkList = self.roadWorkModel.list[indexPath.row];
    } else if(self.selectIndex == 1){
        cell.examineList = self.examineModel.list[indexPath.row];
    } else if(self.selectIndex == 2){
        cell.constructionList = self.constructionModel.list[indexPath.row];
    } else if(self.selectIndex == 3){
        cell.cityManagementList = self.cityManagementModel.list[indexPath.row];
    } else if(self.selectIndex == 4){
        cell.areaManagementList = self.areaManagementModel.list[indexPath.row];
    } else if(self.selectIndex == 5){
        cell.specialList = self.specialModel.list[indexPath.row];
    } else if(self.selectIndex == 6){
        cell.monadList = self.monadModel.list[indexPath.row];
    }
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.clickIndex = indexPath.row;
    [self clickAddActionwithType:2];
}

@end
