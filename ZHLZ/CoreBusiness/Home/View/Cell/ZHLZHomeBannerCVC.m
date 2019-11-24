//
//  ZHLZHomeBannerCVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/24.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBannerCVC.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface ZHLZHomeBannerCVC () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sycleScrollView;

@end

@implementation ZHLZHomeBannerCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sycleScrollView.delegate = self;
    self.sycleScrollView.placeholderImage = [UIImage imageNamed:@"home_banner_bg"];
}

- (void)setHomeBannerArray:(NSArray<ZHLZHomeBannerModel *> *)homeBannerArray {
    _homeBannerArray = homeBannerArray;
    
    NSMutableArray *titleArray = @[].mutableCopy;
    NSMutableArray *imgURLArray = @[].mutableCopy;
    for (ZHLZHomeBannerModel *model in _homeBannerArray) {
        [titleArray addObject:model.title?:@""];
        [imgURLArray addObject:[BaseAPIURLConst stringByAppendingString:model.url]];
    }
    
    self.sycleScrollView.titlesGroup = titleArray.copy;
    self.sycleScrollView.imageURLStringsGroup = imgURLArray.copy;
    self.sycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

@end
