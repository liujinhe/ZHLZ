//
//  ZHLZHomeVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeVC.h"

#import <SDCycleScrollView/SDCollectionViewCell.h>

#import "ZHLZHomeBulletinCVC.h"
#import "ZHLZHomeCVC.h"
#import "ZHLZHomeCRV.h"
#import "ZHLZHomeRoadConstructionCVC.h"
#import "ZHLZHomeMunicipalFacilityCVC.h"

#import "ZHLZHomeVM.h"

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
    
    [self.collectionView registerClass:[SDCollectionViewCell class]
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
    
    if ([ZHLZUserManager sharedInstance].isLogin) {
        [self loadData];
    }
}

- (void)loadData {
    @weakify(self);
    self.task = [[ZHLZHomeVM sharedInstance] loadDataWithBlock:^(NSArray<ZHLZHomeBannerModel *> * _Nonnull homeBannerArray, NSArray<ZHLZHomeBulletinModel *> * _Nonnull homeBulletinArray, NSArray<ZHLZHomeRoadConstructionModel *> * _Nonnull homeRoadConstructionArray, NSArray<ZHLZHomeMunicipalFacilityModel *> * _Nonnull homeMunicipalFacilityArray) {
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
            CGFloat height = [model.prodescription sizeForFont:kFont(12) size:CGSizeMake(kScreenWidth - 15.f * 2 - 10.f * 2, MAXFLOAT) mode:NSLineBreakByWordWrapping].height;
            [self.homeRoadConstructionHeightArray addObject:@(127.f + height)];
        }
        
        self.homeMunicipalFacilityHeightArray = @[].mutableCopy;
        for (ZHLZHomeMunicipalFacilityModel *model in self.homeMunicipalFacilityArray) {
            CGFloat height = [model.problemDet sizeForFont:kFont(12) size:CGSizeMake(kScreenWidth - 15.f * 2 - 10.f * 2, MAXFLOAT) mode:NSLineBreakByWordWrapping].height;
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
            return CGSizeMake(kScreenWidth - 15.f * 2, [self.homeMunicipalFacilityHeightArray[indexPath.row] floatValue]);
        } else {
            return CGSizeMake(kScreenWidth - 15.f * 2, [self.homeRoadConstructionHeightArray[indexPath.row] floatValue]);
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
        return self.homeBannerArray.count;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 3) {
        ZHLZHomeCRV *homeCRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                  withReuseIdentifier:ZHLZHomeCRVHeaderReuseIdentifier
                                                                         forIndexPath:indexPath];
        if (homeCRV) {
            homeCRV.selectedLatestMessageTypeBlock = ^(NSInteger type) {
                @strongify(self);
                self->_showLatestMessageType = type;
                
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
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
        SDCollectionViewCell *homeBannerCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeBannerCVCReuseIdentifier
                                                                                        forIndexPath:indexPath];
        if (homeBannerCVC) {
            ZHLZHomeBannerModel *homeBannerModel = self.homeBannerArray[indexPath.row];
            if (homeBannerModel) {
                [homeBannerCVC.imageView sd_setImageWithURL:[NSURL URLWithString:[BaseAPIURLConst stringByAppendingString:homeBannerModel.url]] placeholderImage:[UIImage imageNamed:@"home_banner_bg"]];
            }
        }
        return homeBannerCVC;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 公告
        return;
    } else if (indexPath.section == 2) { // 模块
        
    } else if (indexPath.section == 3) { // 最新消息
        if (_showLatestMessageType == 1) { // 市政设施问题
            
        } else {
            
        }
    } else { // Banner
        
    }
}

@end
