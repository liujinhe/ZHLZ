//
//  ZHLZHomeVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeVC.h"

#import "ZHLZHomeCollectionReusableView.h"
#import "ZHLZHomeBannerCollectionViewCell.h"
#import "ZHLZHomeCollectionViewCell.h"
#import "ZHLZHomeRoadConstructionCollectionViewCell.h"
#import "ZHLZHomeMunicipalFacilityCollectionViewCell.h"

static NSString * const ZHLZHomeCRV = @"ZHLZHomeCollectionReusableView";
static NSString * const ZHLZHomeBannerCVC = @"ZHLZHomeBannerCollectionViewCell";
static NSString * const ZHLZHomeCVC = @"ZHLZHomeCollectionViewCell";
static NSString * const ZHLZHomeRoadConstructionCVC = @"ZHLZHomeRoadConstructionCollectionViewCell";
static NSString * const ZHLZHomeMunicipalFacilityCVC = @"ZHLZHomeMunicipalFacilityCollectionViewCell";

@interface ZHLZHomeVC () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ZHLZHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"智慧路政";
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeCRV bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:ZHLZHomeCVC];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeBannerCVC bundle:nil]
                       forCellWithReuseIdentifier:ZHLZHomeBannerCVC];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeCVC bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeCVC];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeRoadConstructionCVC bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeRoadConstructionCVC];
    [self.collectionView registerNib:[UINib nibWithNibName:ZHLZHomeMunicipalFacilityCVC bundle:nil]
          forCellWithReuseIdentifier:ZHLZHomeMunicipalFacilityCVC];
}

#pragma mark - UICollectionViewDelegateFlowLayout


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return 12;
    } else if (section == 2) {
        return 1;
    } else {
        return 1;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
