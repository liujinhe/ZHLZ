//
//  ZHLZHomeVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeVC.h"

#import "ZHLZHomeCRV.h"
#import "ZHLZHomeBannerCVC.h"
#import "ZHLZHomeBulletinCVC.h"
#import "ZHLZHomeCVC.h"
#import "ZHLZHomeRoadConstructionCVC.h"
#import "ZHLZHomeMunicipalFacilityCVC.h"

static NSString * const ZHLZHomeCRVReuseIdentifier = @"ZHLZHomeCRV";
static NSString * const ZHLZHomeBannerCVCReuseIdentifier = @"ZHLZHomeBannerCVC";
static NSString * const ZHLZHomeBulletinCVCReuseIdentifier = @"ZHLZHomeBulletinCVC";
static NSString * const ZHLZHomeCVCReuseIdentifier = @"ZHLZHomeCVC";
static NSString * const ZHLZHomeRoadConstructionCVCReuseIdentifier = @"ZHLZHomeRoadConstructionCVC";
static NSString * const ZHLZHomeMunicipalFacilityCVCReuseIdentifier = @"ZHLZHomeMunicipalFacilityCVC";

@interface ZHLZHomeVC () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *moduleTitleArray;
@property (nonatomic, strong) NSArray *moduleImageArray;

@end

@implementation ZHLZHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"智慧路政";
    
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
    
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeCRVReuseIdentifier bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:ZHLZHomeCVCReuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeBannerCVCReuseIdentifier bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeBannerCVCReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeBulletinCVCReuseIdentifier bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeBulletinCVCReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeCVCReuseIdentifier bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeCVCReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeRoadConstructionCVCReuseIdentifier bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeRoadConstructionCVCReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeMunicipalFacilityCVCReuseIdentifier bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeMunicipalFacilityCVCReuseIdentifier];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout


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
        return 1;
    } else { // Banner
        return 1;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:ZHLZHomeCRVReuseIdentifier
                                                  withReuseIdentifier:UICollectionElementKindSectionHeader
                                                         forIndexPath:indexPath];
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 公告
        return [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeBulletinCVCReuseIdentifier forIndexPath:indexPath];
    } else if (indexPath.section == 2) { // 模块
        return [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeCVCReuseIdentifier forIndexPath:indexPath];
    } else if (indexPath.section == 3) { // 最新消息
        return [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeRoadConstructionCVCReuseIdentifier forIndexPath:indexPath];
        //        return [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeMunicipalFacilityCVCReuseIdentifier forIndexPath:indexPath];
    } else { // Banner
        return [collectionView dequeueReusableCellWithReuseIdentifier:ZHLZHomeBannerCVCReuseIdentifier forIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
//        ((ZHLZHomeCRV *)view)
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { // 公告
        
    } else if (indexPath.section == 2) { // 模块
        
    } else if (indexPath.section == 3) { // 最新消息
        
    } else { // Banner
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
