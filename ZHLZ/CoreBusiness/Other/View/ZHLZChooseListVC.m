//
//  ZHLZChooseListVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZChooseListVC.h"
#import "ZHLZChooseListCell.h"
#import "ZHLZAddressBookVM.h"
#import "ZHLZHomeSafeVM.h"

#import "ZHLZMonadModel.h"
#import "ZHLZSpecialModel.h"
#import "ZHLZCityManagementModel.h"
#import "ZHLZAreaManagementModel.h"
#import "ZHLZConstructionModel.h"
#import "ZHLZExamineModel.h"
#import "ZHLZRoadWorkModel.h"
#import "ZHLZHomeBuildProjectVM.h"


#import "ZHLZRoadWorkVC.h"//施工单位
#import "ZHLZExamineVC.h"//审批部门
#import "ZHLZConstructionVC.h"//建设单位

#import "ZHLZAreaManagementVC.h"//区管管理单位
#import "ZHLZCityManagementVC.h"//市管管理单位
#import "ZHLZSpecialVC.h"//特殊业主单位
#import "ZHLZMonadVC.h"

#import "ZHLZHomeSafeDetailVC.h"//台账
#import "ZHLZHomeBuildProjectDetailVC.h"//项目

@interface ZHLZChooseListVC ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextFile;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewHeightConstraint;


@property (weak, nonatomic) IBOutlet UITableView *chooseListTableview;

@property (nonatomic , strong) NSMutableArray <MonadModelList *>*MonadModelArray;//责任单位
@property (nonatomic , strong) NSMutableArray <SpecialList *>*specialListModelArray;//特殊业主单位
@property (nonatomic , strong) NSMutableArray <CityManagementList *>*cityManagementListModelArray;//市管单位
@property (nonatomic , strong) NSMutableArray <AreaManagementList *>*areaManagementListModelArray;//区管单位
@property (nonatomic , strong) NSMutableArray <ConstructionList *>*constructionModelArray;//建设单位
@property (nonatomic , strong) NSMutableArray <ExamineList *>*examineModelArray;//审批单位
@property (nonatomic , strong) NSMutableArray <RoadWorkList *>*roadWorkModelArray;//施工单位
@property (nonatomic , strong) NSMutableArray <ZHLZHomeSafeModel *> *homeSafeModelArray;//台账id
@property (nonatomic , strong) NSMutableArray <ZHLZHomeBuildProjectModel *> *homeBuildProjectModelArray;//在建项目


@property (nonatomic , assign) NSInteger pageNum;

@end

@implementation ZHLZChooseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initChooseListView];
    
    [self loadAddressListData];
}

- (void)addAction {
    if (self.selectIndex == 0) {
        ZHLZRoadWorkVC *roadWorkVC = [ZHLZRoadWorkVC new];
        roadWorkVC.editType = 1;
        roadWorkVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:roadWorkVC animated:YES];
        
    } else if(self.selectIndex == 1){
        ZHLZExamineVC *examineVC = [ZHLZExamineVC new];
        examineVC.setType = 1;
        examineVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:examineVC animated:YES];
        
    } else if(self.selectIndex == 2){
        ZHLZConstructionVC *constructionVC = [ZHLZConstructionVC new];
        constructionVC.setType = 1;
        constructionVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:constructionVC animated:YES];
        
    } else if(self.selectIndex == 3){
        ZHLZCityManagementVC *areaManagementVC = [ZHLZCityManagementVC new];
        areaManagementVC.setType = 1;
        areaManagementVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:areaManagementVC animated:YES];
        
    } else if(self.selectIndex == 4){
        ZHLZAreaManagementVC *areaManagementVC = [ZHLZAreaManagementVC new];
        areaManagementVC.setType = 1;
        areaManagementVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:areaManagementVC animated:YES];
        
    } else if(self.selectIndex == 5){
        ZHLZSpecialVC *specialVC = [ZHLZSpecialVC new];
        specialVC.setType = 1;
        specialVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:specialVC animated:YES];
        
    } else if(self.selectIndex == 6){
        ZHLZMonadVC *monadVC = [ZHLZMonadVC new];
        monadVC.setType = 1;
        monadVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:monadVC animated:YES];
        
    } else if(self.selectIndex == 7){
        
        ZHLZHomeSafeDetailVC *homeSafeDetailVC = [ZHLZHomeSafeDetailVC new];
        homeSafeDetailVC.type = 1;
        homeSafeDetailVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:homeSafeDetailVC animated:YES];
        
    } else if(self.selectIndex == 8){
        
        ZHLZHomeBuildProjectDetailVC *homeBuildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
        homeBuildProjectDetailVC.detailType = 1;
        homeBuildProjectDetailVC.reloadDataBlock = ^{
            [self.chooseListTableview.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:homeBuildProjectDetailVC animated:YES];
    }
}

#pragma mark --初始化视图

- (void)initChooseListView{
    

    if (self.selectIndex == 7 || self.selectIndex == 8) {
        self.searchView.hidden = YES;
        self.searchViewHeightConstraint.constant = 0;
        
    }
    
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    }
    
    self.pageNum = 1;
    
    switch (self.selectIndex) {
        case 0:
            self.title = @"选择施工单位";
        break;
        case 1:
            self.title = @"选择审批部门";
        break;
        case 2:
            self.title = @"选择建设单位";
        break;
        case 3:
            self.title = @"选择市管管理单位";
        break;
        case 4:
            self.title = @"选择区管管理单位";
        break;
        case 5:
            self.title = @"选择特殊业主单位";
        break;
        case 6:
            self.title = @"选择责任单位";
        break;
        case 7:
            self.title = @"选择台账id";
        break;
        case 8:
            self.title = @"选择项目";
        break;
            
        default:
            break;
    }

    
    self.roadWorkModelArray = [NSMutableArray <RoadWorkList *> new];
    self.examineModelArray = [NSMutableArray <ExamineList *> new];
    self.constructionModelArray = [NSMutableArray <ConstructionList *> new];
    self.areaManagementListModelArray = [NSMutableArray <AreaManagementList *> new];
    self.cityManagementListModelArray = [NSMutableArray <CityManagementList *> new];
    self.specialListModelArray = [NSMutableArray <SpecialList *> new];
    self.MonadModelArray = [NSMutableArray <MonadModelList *> new];
    self.homeSafeModelArray = [NSMutableArray <ZHLZHomeSafeModel *> new];
    self.homeBuildProjectModelArray = [NSMutableArray <ZHLZHomeBuildProjectModel *> new];
    
    
    self.chooseListTableview.dataSource = self;
    self.chooseListTableview.delegate = self;
    self.chooseListTableview.emptyDataSetSource = self;
    self.chooseListTableview.emptyDataSetDelegate = self;
    
    self.chooseListTableview.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.chooseListTableview.showsVerticalScrollIndicator = NO;
    
    [self.chooseListTableview registerNib:[UINib nibWithNibName:@"ZHLZChooseListCell" bundle:nil] forCellReuseIdentifier:@"ZHLZChooseListCell"];
    
    self.chooseListTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadAddressListHeader)];
    self.chooseListTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadAddressListFooter)];
    
    
}

- (void)loadAddressListFooter {
    self.pageNum ++;
    [self loadAddressListData];
}

- (void)loadAddressListData{
    
    if (self.selectIndex == 7) {
        self.task = [[ZHLZHomeSafeVM sharedInstance] loadHomeSafeDataWithPageNum:self.pageNum withModel:nil withBlock:^(NSArray<ZHLZHomeSafeModel *> * _Nonnull homeSafeModelArray) {
            if (self.chooseListTableview.mj_header.isRefreshing) {
                [self.chooseListTableview.mj_header endRefreshing];
            }
            if ([self.chooseListTableview.mj_footer isRefreshing]) {
                [self.chooseListTableview.mj_footer endRefreshing];
            }
        
            if (self.pageNum == 1) {
                self.homeSafeModelArray = homeSafeModelArray.mutableCopy;
            } else {
                if (homeSafeModelArray.count > 0) {
                    [self.homeSafeModelArray addObjectsFromArray:homeSafeModelArray];
                } else {
                    [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
                }
            }
            self.pageNum ++;
            
            [self.chooseListTableview reloadData];
        }];
    }
    
    else if (self.selectIndex == 8 ){
        @weakify(self)
        self.task = [[ZHLZHomeBuildProjectVM sharedInstance] loadHomeBuildProjectDataWithPageNum:self.pageNum withModel:nil withBlock:^(NSArray<ZHLZHomeBuildProjectModel *> * _Nonnull homeBuildProjectModelArray) {
            @strongify(self)
            
            if (self.chooseListTableview.mj_header.isRefreshing) {
                [self.chooseListTableview.mj_header endRefreshing];
            }
            if ([self.chooseListTableview.mj_footer isRefreshing]) {
                [self.chooseListTableview.mj_footer endRefreshing];
            }
            
            if (self.pageNum == 1) {
                self.homeBuildProjectModelArray = homeBuildProjectModelArray.mutableCopy;
            } else {
                if (homeBuildProjectModelArray.count > 0) {
                    [self.homeBuildProjectModelArray addObjectsFromArray:homeBuildProjectModelArray];
                } else {
                    [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [self.chooseListTableview reloadData];
        }];
        
        
    }
    
    
    
    else {
    
        self.task = [[ZHLZAddressBookVM sharedInstance] loadListWithType:self.selectIndex withPageNum:self.pageNum andSearchKeyString:self.searchTextFile.text CallBack:^(NSDictionary * _Nonnull parms) {
            
            if (self.chooseListTableview.mj_header.isRefreshing) {
                [self.chooseListTableview.mj_header endRefreshing];
            }
            if ([self.chooseListTableview.mj_footer isRefreshing]) {
                [self.chooseListTableview.mj_footer endRefreshing];
            }
            

            if (self.selectIndex == 0) {
                NSArray *roadWorkListArray = [NSArray modelArrayWithClass:[RoadWorkList class] json:[parms objectForKey:@"list"]];
                if (self.pageNum == 1) {
                    self.roadWorkModelArray = roadWorkListArray.mutableCopy;
                } else {
                    if (roadWorkListArray.count > 0) {
                        [self.roadWorkModelArray addObjectsFromArray:roadWorkListArray];
                    } else {
                        [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
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
                        [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
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
                        [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
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
                        [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
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
                        [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
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
                        [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
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
                        [self.chooseListTableview.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                
            }
            
            [self.chooseListTableview reloadData];
            
        }];
    }
}


- (void)loadAddressListHeader {
    [self.roadWorkModelArray removeAllObjects];
    [self.examineModelArray removeAllObjects];
    [self.constructionModelArray removeAllObjects];
    [self.areaManagementListModelArray removeAllObjects];
    [self.cityManagementListModelArray removeAllObjects];
    [self.specialListModelArray removeAllObjects];
    [self.MonadModelArray removeAllObjects];
    [self.homeSafeModelArray removeAllObjects];
    [self.homeBuildProjectModelArray removeAllObjects];
    
    self.pageNum = 1;
    [self loadAddressListData];
}


- (IBAction)searchAction:(UIButton *)sender {
    [self.searchTextFile resignFirstResponder];
    [self loadAddressListHeader];
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
    }else if(self.selectIndex == 7){
        return self.homeSafeModelArray.count;
    }else if(self.selectIndex == 8){
        return self.homeBuildProjectModelArray.count;
    }
    
    else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZChooseListCell";

    ZHLZChooseListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZChooseListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    }else if(self.selectIndex == 7){
        cell.homeSafeModel = self.homeSafeModelArray[indexPath.row];
    }else if(self.selectIndex == 8){
        cell.homeBuildProjectModel = self.homeBuildProjectModelArray[indexPath.row];
    }
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *name = @"";
    NSString *codeId = @"";
    if (self.selectIndex == 0) {
        RoadWorkList *RoadWorkList = self.roadWorkModelArray[indexPath.row];
        name =  RoadWorkList.name;
        codeId =  RoadWorkList.objectID;
        
    } else if(self.selectIndex == 1){
        ExamineList *ExamineList = self.examineModelArray[indexPath.row];
        name =  ExamineList.name;
        codeId =  ExamineList.objectID;
        
    } else if(self.selectIndex == 2){
        ConstructionList *ConstructionList = self.constructionModelArray[indexPath.row];
        name =  ConstructionList.name;
        codeId =  ConstructionList.objectID;
        
    } else if(self.selectIndex == 3){
        CityManagementList *CityManagementList = self.cityManagementListModelArray[indexPath.row];
        name =  CityManagementList.name;
        codeId =  CityManagementList.objectID;
        
    } else if(self.selectIndex == 4){
        AreaManagementList *AreaManagementList = self.areaManagementListModelArray[indexPath.row];
        name =  AreaManagementList.name;
        codeId =  AreaManagementList.objectID;
        
    } else if(self.selectIndex == 5){
        SpecialList *SpecialList = self.specialListModelArray[indexPath.row];
        name =  SpecialList.name;
        codeId =  SpecialList.objectID;
        
    } else if(self.selectIndex == 6){
        MonadModelList *MonadModelList = self.MonadModelArray[indexPath.row];
        name =  MonadModelList.name;
        codeId =  MonadModelList.objectID;
        
    }else if(self.selectIndex == 7){
        ZHLZHomeSafeModel *ZHLZHomeSafeModel = self.homeSafeModelArray[indexPath.row];
        name =  ZHLZHomeSafeModel.objectID;
        codeId =  ZHLZHomeSafeModel.objectID;
        
    }else if(self.selectIndex == 8){
        
        ZHLZHomeBuildProjectModel *BuildProjectModel = self.homeBuildProjectModelArray[indexPath.row];
        
        if (self.selectBuildProjectListBlock) {
            self.selectBuildProjectListBlock(BuildProjectModel.objectID , BuildProjectModel.name, BuildProjectModel.areaid);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    if (self.selectListBlock) {
        self.selectListBlock(codeId, name);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
    [self loadAddressListData];
}


@end
