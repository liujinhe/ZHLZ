//
//  ZHLZHomeBulletinCVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/15.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBulletinCVC.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "ZHLZHomeBulletinModel.h"

@interface ZHLZHomeBulletinCVC () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bulletinCycleScrollView;

@property (nonatomic, strong) NSMutableArray *bulletinNameArray;

@end

@implementation ZHLZHomeBulletinCVC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = UIColor.clearColor;
    
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.whiteColor;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2);
        make.bottom.equalTo(self).offset(-2);
        make.left.right.equalTo(self);
    }];
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.backgroundColor = kThemeColor;
    tagLabel.font = kFont(12);
    tagLabel.text = @"公告";
    tagLabel.textColor = UIColor.whiteColor;
    tagLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:tagLabel];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.centerY.equalTo(view);
        make.width.offset(32);
        make.height.offset(21);
    }];
    
    self.bulletinCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.bulletinCycleScrollView.delegate = self;
    self.bulletinCycleScrollView.backgroundColor = UIColor.clearColor;
    self.bulletinCycleScrollView.titleLabelTextColor = UIColor.redColor;
    self.bulletinCycleScrollView.titleLabelTextFont = kFont(12);
    self.bulletinCycleScrollView.titleLabelBackgroundColor = UIColor.clearColor;
    self.bulletinCycleScrollView.titleLabelHeight = 22.f;
    self.bulletinCycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.bulletinCycleScrollView.onlyDisplayText = YES;
    self.bulletinCycleScrollView.autoScrollTimeInterval = 3.f;
    [self.bulletinCycleScrollView disableScrollGesture];
    [view addSubview:self.bulletinCycleScrollView];
    [self.bulletinCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagLabel.mas_right);
        make.right.equalTo(view).offset(-15);
        make.top.bottom.equalTo(view);
    }];
}

- (void)setHomeBulletinArray:(NSArray<ZHLZHomeBulletinModel *> *)homeBulletinArray {
    _homeBulletinArray = homeBulletinArray;
    
    self.bulletinNameArray = @[].mutableCopy;
    for (ZHLZHomeBulletinModel *homeBulletinModel in _homeBulletinArray) {
        [self.bulletinNameArray addObject:homeBulletinModel.describe?:@""];
    }
    self.bulletinCycleScrollView.titlesGroup = self.bulletinNameArray;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSString *tip = self.bulletinNameArray[index];
    if ([tip isNotBlank] && self.selectBulletinBlock) {
        self.selectBulletinBlock(tip);
    }
}

@end