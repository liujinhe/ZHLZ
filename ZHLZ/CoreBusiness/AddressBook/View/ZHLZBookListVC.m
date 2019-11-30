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
@property (weak, nonatomic) IBOutlet UITextField *searchTextFile;


@property (nonatomic , strong) NSMutableArray <MonadModelList *>*MonadModelArray;//责任单位
@property (nonatomic , strong) NSMutableArray <SpecialList *>*specialListModelArray;//特殊业主单位
@property (nonatomic , strong) NSMutableArray <CityManagementList *>*cityManagementListModelArray;//市管单位
@property (nonatomic , strong) NSMutableArray <AreaManagementList *>*areaManagementListModelArray;//区管单位
@property (nonatomic , strong) NSMutableArray <ConstructionList *>*constructionModelArray;//建设单位
@property (nonatomic , strong) NSMutableArray <ExamineList *>*examineModelArray;//审批单位
@property (nonatomic , strong) NSMutableArray <RoadWorkList *>*roadWorkModelArray;//施工单位



@property (nonatomic , assign) NSInteger pageNum;

@property (nonatomic , assign) NSInteger clickIndex;

@end

@implementation ZHLZBookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBookListView];
    
    [self loadAddressListData];
}


- (IBAction)searchAction:(UIButton *)sender {

    self.pageNum = 1;
    [self loadAddressListData];
    
}

- (void)loadAddressListData{
    self.task = [[ZHLZAddressBookVM sharedInstance] loadListWithType:self.selectIndex withPageNum:self.pageNum andSearchKeyString:self.searchTextFile.text CallBack:^(NSDictionary * _Nonnull parms) {
        
        if (self.bookListTableView.mj_header.isRefreshing) {
            [self.bookListTableView.mj_header endRefreshing];
        }
        if ([self.bookListTableView.mj_footer isRefreshing]) {
            [self.bookListTableView.mj_footer endRefreshing];
        }
        

        if (self.selectIndex == 0) {
            NSArray *roadWorkListArray = [NSArray modelArrayWithClass:[RoadWorkList class] json:[parms objectForKey:@"list"]];
            if (self.pageNum == 1) {
                self.roadWorkModelArray = roadWorkListArray.mutableCopy;
            } else {
                if (roadWorkListArray.count > 0) {
                    [self.roadWorkModelArray addObjectsFromArray:roadWorkListArray];
                } else {
                    [self.bookListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
        } else if(self.selectIndex == 1){
            
            NSArray *examineListArray = [NSArray modelArrayWithClass:[ExamineList class] json:[parms objectForKey:@"list"]];
            if (self.pageNum == 1) {
                self.examineModelArray = examineListArray.mutableCopy;
            } else {
                if (examineListArray.count > 0) {
                    [self.examineModelArray addObjectsFromArray:examineListArray];
                } else {
                    [self.bookListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }

            
        } else if(self.selectIndex == 2){
            
            NSArray *constructionModelArray = [NSArray modelArrayWithClass:[ConstructionList class] json:[parms objectForKey:@"list"]];
            if (self.pageNum == 1) {
                self.constructionModelArray = constructionModelArray.mutableCopy;
            } else {
                if (constructionModelArray.count > 0) {
                    [self.constructionModelArray addObjectsFromArray:constructionModelArray];
                } else {
                    [self.bookListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            
        } else if(self.selectIndex == 3){
            
            NSArray *cityManagementListModelArray = [NSArray modelArrayWithClass:[CityManagementList class] json:[parms objectForKey:@"list"]];
            if (self.pageNum == 1) {
                self.cityManagementListModelArray = cityManagementListModelArray.mutableCopy;
            } else {
                if (cityManagementListModelArray.count > 0) {
                    [self.cityManagementListModelArray addObjectsFromArray:cityManagementListModelArray];
                } else {
                    [self.bookListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
        } else if(self.selectIndex == 4){
            
            NSArray *areaManagementListModelArray = [NSArray modelArrayWithClass:[AreaManagementList class] json:[parms objectForKey:@"list"]];
            if (self.pageNum == 1) {
                self.areaManagementListModelArray = areaManagementListModelArray.mutableCopy;
            } else {
                if (areaManagementListModelArray.count > 0) {
                    [self.areaManagementListModelArray addObjectsFromArray:areaManagementListModelArray];
                } else {
                    [self.bookListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
        } else if(self.selectIndex == 5){
            
            NSArray *specialListModelArray = [NSArray modelArrayWithClass:[SpecialList class] json:[parms objectForKey:@"list"]];
            if (self.pageNum == 1) {
                self.specialListModelArray = specialListModelArray.mutableCopy;
            } else {
                if (specialListModelArray.count > 0) {
                    [self.specialListModelArray addObjectsFromArray:specialListModelArray];
                } else {
                    [self.bookListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
                        
        } else if(self.selectIndex == 6){
            
            NSArray *MonadModelArray = [NSArray modelArrayWithClass:[MonadModelList class] json:[parms objectForKey:@"list"]];
            if (self.pageNum == 1) {
                self.MonadModelArray = MonadModelArray.mutableCopy;
            } else {
                if (MonadModelArray.count > 0) {
                    [self.MonadModelArray addObjectsFromArray:MonadModelArray];
                } else {
                    [self.bookListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
        }
        
        self.pageNum ++;
        
        [self.bookListTableView reloadData];
        
    }];
}

- (void)loadAddressListHeader{
    
    [self.roadWorkModelArray removeAllObjects];
    [self.examineModelArray removeAllObjects];
    [self.constructionModelArray removeAllObjects];
    [self.areaManagementListModelArray removeAllObjects];
    [self.cityManagementListModelArray removeAllObjects];
    [self.specialListModelArray removeAllObjects];
    [self.MonadModelArray removeAllObjects];
    
    self.pageNum = 1;
    [self loadAddressListData];
}

#pragma mark --初始化视图

- (void)addAction {
    [self clickAddActionwithType:1];
}

- (void)initBookListView{
    
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    }
    
    
    
    self.pageNum = 1;
    
    self.title = self.titleNameString;

    
    self.roadWorkModelArray = [NSMutableArray <RoadWorkList *> new];
    self.examineModelArray = [NSMutableArray <ExamineList *> new];
    self.constructionModelArray = [NSMutableArray <ConstructionList *> new];
    self.areaManagementListModelArray = [NSMutableArray <AreaManagementList *> new];
    self.cityManagementListModelArray = [NSMutableArray <CityManagementList *> new];
    self.specialListModelArray = [NSMutableArray <SpecialList *> new];
    self.MonadModelArray = [NSMutableArray <MonadModelList *> new];
    
    
    
    self.bookListTableView.dataSource = self;
    self.bookListTableView.delegate = self;
    self.bookListTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.bookListTableView.showsVerticalScrollIndicator = NO;
    
    [self.bookListTableView registerNib:[UINib nibWithNibName:@"ZHLZBookListCell" bundle:nil] forCellReuseIdentifier:@"ZHLZBookListCell"];
    
    self.bookListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadAddressListHeader)];
    self.bookListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadAddressListData)];
    
}

- (void)clickAddActionwithType:(NSInteger)type{
    
    if (self.selectIndex == 0) {
        RoadWorkList *list = self.roadWorkModelArray[self.clickIndex];
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
        ExamineList *list = self.examineModelArray[self.clickIndex];
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
        ConstructionList *list = self.constructionModelArray[self.clickIndex];
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
        CityManagementList *list = self.cityManagementListModelArray[self.clickIndex];
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
        AreaManagementList *list = self.areaManagementListModelArray[self.clickIndex];
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
        SpecialList *list = self.specialListModelArray[self.clickIndex];
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
        MonadModelList *list = self.MonadModelArray[self.clickIndex];
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
        return self.roadWorkModelArray.count;
    } else if(self.selectIndex == 1){
        return self.examineModelArray.count;
    } else if(self.selectIndex == 2){
        return self.constructionModelArray.count;
    } else if(self.selectIndex == 3){
        return self.cityManagementListModelArray.count;
    } else if(self.selectIndex == 4){
        return self.areaManagementListModelArray.count;
    } else if(self.selectIndex == 5){
        return self.specialListModelArray.count;
    } else if(self.selectIndex == 6){
        return self.MonadModelArray.count;
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
        cell.roadWorkList = self.roadWorkModelArray[indexPath.row];
    } else if(self.selectIndex == 1){
        cell.examineList = self.examineModelArray[indexPath.row];
    } else if(self.selectIndex == 2){
        cell.constructionList = self.constructionModelArray[indexPath.row];
    } else if(self.selectIndex == 3){
        cell.cityManagementList = self.cityManagementListModelArray[indexPath.row];
    } else if(self.selectIndex == 4){
        cell.areaManagementList = self.areaManagementListModelArray[indexPath.row];
    } else if(self.selectIndex == 5){
        cell.specialList = self.specialListModelArray[indexPath.row];
    } else if(self.selectIndex == 6){
        cell.monadList = self.MonadModelArray[indexPath.row];
    }
    
    cell.selectIndex = indexPath.row;
    
    @weakify(self)
    cell.clickPhoneButton = ^(NSInteger selectIndex) {
        @strongify(self)
        
        
        NSString *phoneString = @"";
        if (self.selectIndex == 0) {
            phoneString = self.roadWorkModelArray[indexPath.row].phone;
        } else if(self.selectIndex == 1){
//            phoneString = self.examineModelArray[indexPath.row];
        } else if(self.selectIndex == 2){
            phoneString = self.constructionModelArray[indexPath.row].phone;
        } else if(self.selectIndex == 3){
            phoneString = self.cityManagementListModelArray[indexPath.row].phone;
        } else if(self.selectIndex == 4){
            phoneString = self.areaManagementListModelArray[indexPath.row].phone;
        } else if(self.selectIndex == 5){
            phoneString = self.specialListModelArray[indexPath.row].phone;
        } else if(self.selectIndex == 6){
            phoneString = self.MonadModelArray[indexPath.row].phone;
        }
        
        [self callPhoneWithPhoneString:phoneString];
    };
    
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.clickIndex = indexPath.row;
    [self clickAddActionwithType:2];
}

- (void)callPhoneWithPhoneString:(NSString *)phoneString {
    if ([phoneString isNotBlank]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneString]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            });
        }
    }
    
    else {
        [GRToast makeText:@"暂无联系方式"];
    }
    
}


@end
