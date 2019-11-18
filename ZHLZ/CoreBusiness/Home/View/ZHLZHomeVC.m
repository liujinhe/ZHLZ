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
static NSString * const ZHLZHomeCRVFooterReuseIdentifier = @"ZHLZHomeCRVFooterReuseIdentifier";
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
@property (nonatomic, strong) NSArray<ZHLZHomeMunicipalFacilityModel *> *homeMunicipalFacilityArray;

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
                              @"icon_home_road patrol",
                              @"icon_home_check_in",
                              @"icon_home_road patrol_statistics",
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
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:ZHLZHomeCRVFooterReuseIdentifier];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 2.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 公告
        return CGSizeMake(kScreenWidth, 40.f);
    } else if (indexPath.section == 2) { // 模块
        return CGSizeMake((kScreenWidth - 2.f * 2) / 3, 85.f);
    } else if (indexPath.section == 3) { // 最新消息
        return CGSizeMake(kScreenWidth - 15.f * 2, 78.f);
    } else { // Banner
        return CGSizeMake(kScreenWidth, 180.f);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.f;
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
            return self.homeRoadConstructionArray.count;
        } else {
            return self.homeMunicipalFacilityArray.count;
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
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footerCRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                 withReuseIdentifier:ZHLZHomeCRVFooterReuseIdentifier
                                                                                        forIndexPath:indexPath];
        if (footerCRV) {
            UIView *footerView = [[UIView alloc] initWithFrame:footerCRV.frame];
            footerView.backgroundColor = UIColor.whiteColor;
            [footerCRV addSubview:footerView];
        }
        return footerCRV;
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 公告
        ZHLZHomeBulletinCVC *homeBulletinCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeBulletinCVCReuseIdentifier
                                                                                         forIndexPath:indexPath];
        homeBulletinCVC.bulletin = @"你的健康都会尽快恢复好的释放";
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
            return [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeMunicipalFacilityCVCReuseIdentifier forIndexPath:indexPath];
        } else {
            return [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeRoadConstructionCVCReuseIdentifier
                                                             forIndexPath:indexPath];
        }
    } else { // Banner
        SDCollectionViewCell *homeBannerCVC = [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeBannerCVCReuseIdentifier
                                                                                        forIndexPath:indexPath];
        if (homeBannerCVC) {
            ZHLZHomeBannerModel *homeBannerModel = self.homeBannerArray[indexPath.row];
            if (homeBannerModel) {
                [homeBannerCVC.imageView sd_setImageWithURL:[NSURL URLWithString:[BaseAPIURLConst stringByAppendingString:homeBannerModel.url]]];
            }
        }
        return homeBannerCVC;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 公告
        
    } else if (indexPath.section == 2) { // 模块
        
    } else if (indexPath.section == 3) { // 最新消息
        if (_showLatestMessageType == 1) { // 市政设施问题
            
        } else {
            
        }
    } else { // Banner
        
    }
}

@end
