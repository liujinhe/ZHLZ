//
//  ZHLZHomeVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeVC.h"

#import "ZHLZHomeBannerCVC.h"
#import "ZHLZHomeBulletinCVC.h"
#import "ZHLZHomeCVC.h"
#import "ZHLZHomeCRV.h"
#import "ZHLZHomeRoadConstructionCVC.h"
#import "ZHLZHomeMunicipalFacilityCVC.h"

#import "ZHLZHomeVM.h"

#import "ZHLZHomeMapVC.h"
#import "ZHLZHomeBuildProjectVC.h"
#import "ZHLZHomeSafeVC.h"
#import "ZHLZHomeOccupyProblemVC.h"
#import "ZHLZHomeOccupyProblemDetailVC.h"
#import "ZHLZHomeMunicipalProblemVC.h"
#import "ZHLZHomeMunicipalProblemDetailVC.h"
#import "ZHLZHomeSafeProblemVC.h"
#import "ZHLZHomeRoadPatrolVC.h"
#import "ZHLZHomeCheckInVC.h"
#import "ZHLZWebViewVC.h"
#import "ZHLZHomeBusinessDocumentVC.h"
#import "ZHLZHomeScanCodeUseCarVC.h"
#import "ZHLZHomeInfoStatisticsVC.h"

#import "ZHLZRoadMaintenancePickerViewVC.h"

#define kHomeListCellWidth (kScreenWidth - 10.f * 2)

static NSString * const ZHLZHomeBannerCVCReuseIdentifier = @"ZHLZHomeBannerCVCReuseIdentifier";
static NSString * const ZHLZHomeBulletinCVCReuseIdentifier = @"ZHLZHomeBulletinCVCReuseIdentifier";
static NSString * const ZHLZHomeCVCReuseIdentifier = @"ZHLZHomeCVCReuseIdentifier";

static NSString * const ZHLZHomeCRVHeaderReuseIdentifier = @"ZHLZHomeCRVHeaderReuseIdentifier";
static NSString * const ZHLZHomeRoadConstructionCVCReuseIdentifier = @"ZHLZHomeRoadConstructionCVCReuseIdentifier";
static NSString * const ZHLZHomeMunicipalFacilityCVCReuseIdentifier = @"ZHLZHomeMunicipalFacilityCVCReuseIdentifier";

@interface ZHLZHomeVC () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
{
    // 显示的最新消息类型（0:占道施工问题 1:市政设施问题）
    NSInteger _showLatestMessageType;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *moduleTitleArray;
@property (nonatomic, strong) NSArray *moduleImageArray;

@property (nonatomic, strong) NSArray<ZHLZHomeBannerModel *> *homeBannerArray;
@property (nonatomic, strong) NSArray<ZHLZHomeBulletinModel *> *homeBulletinArray;
@property (nonatomic, strong) NSArray<ZHLZHomeRoadConstructionModel *> *homeRoadConstructionArray;
@property (nonatomic, strong) NSMutableArray *homeRoadConstructionHeightArray;
@property (nonatomic, strong) NSArray<ZHLZHomeMunicipalFacilityModel *> *homeMunicipalFacilityArray;
@property (nonatomic, strong) NSMutableArray *homeMunicipalFacilityHeightArray;

@end

@implementation ZHLZHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:LoadDataNotificationConst object:nil];
    
    self.navTitle = @"智慧路政";
    
    _showLatestMessageType = 0;
    
    self.moduleTitleArray = @[@"地图展示",
                              @"在建项目",
                              @"安全(三防)台账",
                              @"占道问题",
                              @"市政问题",
                              @"安全(三防)问题",
                              @"路巡小结",
                              @"人员签到",
                              @"路巡统计",
                              @"业务文件",
                              @"扫码用车",
                              @"信息统计"];
    self.moduleImageArray = @[@"icon_home_map",
                              @"icon_home_build_project",
                              @"icon_home_safe",
                              @"icon_home_occupy_problem",
                              @"icon_home_municipal_problem",
                              @"icon_home_safe_problem",
                              @"icon_home_road_patrol",
                              @"icon_home_check_in",
                              @"icon_home_road_patrol_statistics",
                              @"icon_home_business_document",
                              @"icon_home_scan_code_use_car",
                              @"icon_home_info_statistics"];
    
    self.homeBannerArray = @[];
    self.homeBulletinArray = @[];
    self.homeRoadConstructionArray = @[];
    self.homeMunicipalFacilityArray = @[];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([[ZHLZHomeBannerCVC class] class]) bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeBannerCVCReuseIdentifier];
    [self.collectionView registerClass:[ZHLZHomeBulletinCVC class]
            forCellWithReuseIdentifier:ZHLZHomeBulletinCVCReuseIdentifier];
    [self.collectionView registerClass:[ZHLZHomeCVC class]
            forCellWithReuseIdentifier:ZHLZHomeCVCReuseIdentifier];
    
    [self.collectionView registerClass:[ZHLZHomeCRV class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:ZHLZHomeCRVHeaderReuseIdentifier];
    [self.collectionView registerClass:[ZHLZHomeRoadConstructionCVC class]
            forCellWithReuseIdentifier:ZHLZHomeRoadConstructionCVCReuseIdentifier];
    [self.collectionView registerClass:[ZHLZHomeMunicipalFacilityCVC class]
            forCellWithReuseIdentifier:ZHLZHomeMunicipalFacilityCVCReuseIdentifier];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)loadData {
    @weakify(self);
    self.task = [[ZHLZHomeVM sharedInstance] loadDataWithRefreshing:self.collectionView.mj_header.isRefreshing WithBlock:^(NSArray<ZHLZHomeBannerModel *> * _Nonnull homeBannerArray, NSArray<ZHLZHomeBulletinModel *> * _Nonnull homeBulletinArray, NSArray<ZHLZHomeRoadConstructionModel *> * _Nonnull homeRoadConstructionArray, NSArray<ZHLZHomeMunicipalFacilityModel *> * _Nonnull homeMunicipalFacilityArray) {
        @strongify(self);
        
        if (self.collectionView.mj_header.isRefreshing) {
            [self.collectionView.mj_header endRefreshing];
        }
        
        self.homeBannerArray = homeBannerArray;
        self.homeBulletinArray = homeBulletinArray;
        self.homeRoadConstructionArray = homeRoadConstructionArray;
        self.homeMunicipalFacilityArray = homeMunicipalFacilityArray;
        
        self.homeRoadConstructionHeightArray = @[].mutableCopy;
        for (ZHLZHomeRoadConstructionModel *model in self.homeRoadConstructionArray) {
            CGFloat height = [model.prodescription sizeForFont:kFont(12) size:CGSizeMake(kHomeListCellWidth - 10.f * 2, MAXFLOAT) mode:NSLineBreakByWordWrapping].height;
            [self.homeRoadConstructionHeightArray addObject:@(127.f + height)];
        }
        
        self.homeMunicipalFacilityHeightArray = @[].mutableCopy;
        for (ZHLZHomeMunicipalFacilityModel *model in self.homeMunicipalFacilityArray) {
            CGFloat height = [model.problemDet sizeForFont:kFont(12) size:CGSizeMake(kHomeListCellWidth - 10.f * 2, MAXFLOAT) mode:NSLineBreakByWordWrapping].height;
            [self.homeMunicipalFacilityHeightArray addObject:@(96.f + height)];
        }
        
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return CGSizeMake(kScreenWidth, 80.f);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 公告
        return CGSizeMake(kScreenWidth, 40.f);
    } else if (indexPath.section == 2) { // 模块
        return CGSizeMake((kScreenWidth - 2.f * 2) / 3, 85.f);
    } else if (indexPath.section == 3) { // 最新消息
        if (_showLatestMessageType == 1) { // 市政设施问题
            return CGSizeMake(kHomeListCellWidth, [self.homeMunicipalFacilityHeightArray[indexPath.row] floatValue]);
        } else {
            return CGSizeMake(kHomeListCellWidth, [self.homeRoadConstructionHeightArray[indexPath.row] floatValue]);
        }
    } else { // Banner
        return CGSizeMake(kScreenWidth, kAutoFitReal(180));
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return section == 3 ? 5.f : 2.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.f;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) { // 公告
        return 1;
    } else if (section == 2) { // 模块
        return self.moduleTitleArray.count;
    } else if (section == 3) { // 最新消息
        if (_showLatestMessageType == 1) { // 市政设施问题
            return self.homeMunicipalFacilityArray.count;
        } else {
            return self.homeRoadConstructionArray.count;
        }
    } else { // Banner
        return 1;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 3) {
        ZHLZHomeCRV *homeCRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                  withReuseIdentifier:ZHLZHomeCRVHeaderReuseIdentifier
                                                                         forIndexPath:indexPath];
        if (homeCRV) {
            homeCRV.currentIndexPath = indexPath;
            homeCRV.selectedLatestMessageTypeBlock = ^(NSInteger type, NSIndexPath * _Nonnull currentIndexPath) {
                @strongify(self);
                self->_showLatestMessageType = type;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            };
        }
        return homeCRV;
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    if (indexPath.section == 1) { // 公告
        ZHLZHomeBulletinCVC *homeBulletinCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeBulletinCVCReuseIdentifier
                                                                                         forIndexPath:indexPath];
        if (homeBulletinCVC) {
            homeBulletinCVC.homeBulletinArray = self.homeBulletinArray;
            homeBulletinCVC.selectBulletinBlock = ^(NSString * _Nonnull tip) {
                @strongify(self);
                [self popPromptActionWithTitle:@"公告" withTip:tip];
            };
        }
        return homeBulletinCVC;
    } else if (indexPath.section == 2) { // 模块
        ZHLZHomeCVC *homeCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeCVCReuseIdentifier
                                                                         forIndexPath:indexPath];
        if (homeCVC) {
            homeCVC.imgName = self.moduleImageArray[indexPath.row];
            homeCVC.desc = self.moduleTitleArray[indexPath.row];
        }
        return homeCVC;
    } else if (indexPath.section == 3) { // 最新消息
        if (_showLatestMessageType == 1) { // 市政设施问题
            ZHLZHomeMunicipalFacilityCVC *homeMunicipalFacilityCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeMunicipalFacilityCVCReuseIdentifier
                                                                                                               forIndexPath:indexPath];
            if (homeMunicipalFacilityCVC) {
                homeMunicipalFacilityCVC.homeMunicipalFacilityModel = self.homeMunicipalFacilityArray[indexPath.row];
            }
            return homeMunicipalFacilityCVC;
        } else {
            ZHLZHomeRoadConstructionCVC *homeRoadConstructionCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeRoadConstructionCVCReuseIdentifier
                                                                                                             forIndexPath:indexPath];
            if (homeRoadConstructionCVC) {
                homeRoadConstructionCVC.homeRoadConstructionModel = self.homeRoadConstructionArray[indexPath.row];
            }
            return homeRoadConstructionCVC;
        }
    } else { // Banner
        ZHLZHomeBannerCVC *homeBannerCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeBannerCVCReuseIdentifier
                                                                                     forIndexPath:indexPath];
        if (homeBannerCVC) {
            homeBannerCVC.homeBannerArray = self.homeBannerArray;
        }
        return homeBannerCVC;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) { // 模块
        NSString *navTitle = self.moduleTitleArray[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                ZHLZHomeMapVC *homeMapVC = [ZHLZHomeMapVC new];
                homeMapVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeMapVC
                                                     animated:YES];
            }
                break;
            case 1:
            {
                ZHLZHomeBuildProjectVC *homeBuildProjectVC = [ZHLZHomeBuildProjectVC new];
                homeBuildProjectVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeBuildProjectVC
                                                     animated:YES];
            }
                break;
            case 2:
            {
                ZHLZHomeSafeVC *homeSafeVC = [ZHLZHomeSafeVC new];
                homeSafeVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeSafeVC
                                                     animated:YES];
            }
                break;
            case 3:
            {
                ZHLZHomeOccupyProblemVC *homeOccupyProblemVC = [ZHLZHomeOccupyProblemVC new];
                homeOccupyProblemVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeOccupyProblemVC
                                                     animated:YES];
            }
                break;
            case 4:
            {
                ZHLZHomeMunicipalProblemVC *homeMunicipalProblemVC = [ZHLZHomeMunicipalProblemVC new];
                homeMunicipalProblemVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeMunicipalProblemVC
                                                     animated:YES];
            }
                break;
            case 5:
            {
                ZHLZHomeSafeProblemVC *homeSafeProblemVC = [ZHLZHomeSafeProblemVC new];
                homeSafeProblemVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeSafeProblemVC
                                                     animated:YES];
            }
                break;
            case 6:
            {
                ZHLZHomeRoadPatrolVC *homeRoadPatrolVC = [ZHLZHomeRoadPatrolVC new];
                homeRoadPatrolVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeRoadPatrolVC
                                                     animated:YES];
            }
                break;
            case 7:
            {
                ZHLZHomeCheckInVC *homeCheckInVC = [ZHLZHomeCheckInVC new];
                homeCheckInVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeCheckInVC
                                                     animated:YES];
            }
                break;
            case 8:
            {
                ZHLZWebViewVC *webViewVC = [ZHLZWebViewVC new];
                webViewVC.navTitle = navTitle;
                webViewVC.url = [BaseAPIURLConst stringByAppendingString:RoadPatrolSummaryStatisticsAPIURLConst];
                [self.navigationController pushViewController:webViewVC
                                                     animated:YES];
            }
                break;
            case 9:
            {
                ZHLZHomeBusinessDocumentVC *homeBusinessDocumentVC = [ZHLZHomeBusinessDocumentVC new];
                homeBusinessDocumentVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeBusinessDocumentVC
                                                     animated:YES];
            }
                break;
            case 10:
            {
                ZHLZHomeScanCodeUseCarVC *homeScanCodeUseCarVC = [ZHLZHomeScanCodeUseCarVC new];
                homeScanCodeUseCarVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeScanCodeUseCarVC
                                                     animated:YES];
            }
                break;
            case 11:
            {
                ZHLZHomeInfoStatisticsVC *homeInfoStatisticsVC = [ZHLZHomeInfoStatisticsVC new];
                homeInfoStatisticsVC.navTitle = navTitle;
                [self.navigationController pushViewController:homeInfoStatisticsVC
                                                     animated:YES];
            }
                break;
                
        }
    } else if (indexPath.section == 3) { // 最新消息
        if (_showLatestMessageType == 1) { // 市政设施问题
            ZHLZHomeMunicipalProblemDetailVC *homeMunicipalProblemDetailVC = [ZHLZHomeMunicipalProblemDetailVC new];
            homeMunicipalProblemDetailVC.type = 2;
            homeMunicipalProblemDetailVC.detailId = self.homeMunicipalFacilityArray[indexPath.row].objectID;
            [self.navigationController pushViewController:homeMunicipalProblemDetailVC
                                                 animated:YES];
        } else {
            ZHLZHomeOccupyProblemDetailVC *homeOccupyProblemDetailVC = [ZHLZHomeOccupyProblemDetailVC new];
            homeOccupyProblemDetailVC.type = 2;
            homeOccupyProblemDetailVC.detailId = self.homeRoadConstructionArray[indexPath.row].proid;
            [self.navigationController pushViewController:homeOccupyProblemDetailVC
                                                 animated:YES];
        }
    }
}

@end
