//
//  ZHLZHomeCRV.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCRV.h"

@interface ZHLZHomeCRV ()

@property (nonatomic, strong) UIButton *roadConstructionButton;

@property (nonatomic, strong) UIButton *municipalFacilityButton;

@end

@implementation ZHLZHomeCRV

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"最新消息";
    titleLabel.textColor = kHexRGB(0x666666);
    titleLabel.font = kFont(12);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.height.offset(35);
    }];
    
    self.roadConstructionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.roadConstructionButton.tag = 0;
    self.roadConstructionButton.selected = YES;
    self.roadConstructionButton.titleLabel.font = kFont(12);
    [self.roadConstructionButton setTitle:@"占道施工问题" forState:UIControlStateNormal];
    [self.roadConstructionButton setTitleColor:kHexRGB(0x666666) forState:UIControlStateNormal];
    [self.roadConstructionButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    [self.roadConstructionButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [self.roadConstructionButton setBackgroundImage:[UIImage imageWithColor:kThemeColor] forState:UIControlStateSelected];
    [self.roadConstructionButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.roadConstructionButton];
    [self.roadConstructionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    self.municipalFacilityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.municipalFacilityButton.tag = 1;
    self.municipalFacilityButton.selected = NO;
    self.municipalFacilityButton.titleLabel.font = kFont(12);
    [self.municipalFacilityButton setTitle:@"市政设施问题" forState:UIControlStateNormal];
    [self.municipalFacilityButton setTitleColor:kHexRGB(0x666666) forState:UIControlStateNormal];
    [self.municipalFacilityButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    [self.municipalFacilityButton setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [self.municipalFacilityButton setBackgroundImage:[UIImage imageWithColor:kThemeColor] forState:UIControlStateSelected];
    [self.municipalFacilityButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.municipalFacilityButton];
    [self.municipalFacilityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.roadConstructionButton);
        make.left.equalTo(self.roadConstructionButton.mas_right);
        make.right.equalTo(self);
        make.width.equalTo(self.roadConstructionButton.mas_width);
    }];
}

- (void)selectType:(UIButton *)button {
    if (self.roadConstructionButton.isSelected) {
        self.roadConstructionButton.selected = NO;
    }
    if (self.municipalFacilityButton.isSelected) {
        self.municipalFacilityButton.selected = NO;
    }
    button.selected = YES;
    if (self.selectedLatestMessageTypeBlock) {
        self.selectedLatestMessageTypeBlock(button.tag, self.currentIndexPath);
    }
}

@end
