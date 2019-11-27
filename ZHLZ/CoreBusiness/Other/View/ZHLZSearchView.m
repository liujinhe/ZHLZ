//
//  ZHLZSearchView.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZSearchView.h"

@interface ZHLZSearchView ()

@property (nonatomic, strong) UISwitch *openOrCloseSwitch;
@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation ZHLZSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initUI];
}

- (void)initUI {
    self.backgroundColor = UIColor.whiteColor;
    
    self.openOrCloseSwitch = [UISwitch new];
    self.openOrCloseSwitch.on = NO;
    self.openOrCloseSwitch.onTintColor = kThemeColor;
    [self.openOrCloseSwitch addTarget:self action:@selector(openOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.openOrCloseSwitch];
    [self.openOrCloseSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-15);
    }];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.adjustsImageWhenHighlighted = NO;
    self.searchButton.titleLabel.font = kFont(14);
    self.searchButton.layer.cornerRadius = 5.f;
    self.searchButton.backgroundColor = kHexRGB(0xc9c9c9);
    [self.searchButton setImage:[UIImage imageNamed:@"icon_search_light"] forState:UIControlStateNormal];
    self.searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    self.searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.offset(30);
        make.centerY.equalTo(self.openOrCloseSwitch.mas_centerY);
    }];
}

- (void)openOrCloseAction:(UISwitch *)sender {
    if (self.openOrCloseBlock) {
        self.openOrCloseBlock(sender.isOn);
    }
}

- (void)searchAction {
    if (self.searchBlock) {
        self.searchBlock();
    }
}

- (void)setIsExistRangeSearchSwitch:(BOOL)isExistRangeSearchSwitch {
    _isExistRangeSearchSwitch = isExistRangeSearchSwitch;
    
    if (_isExistRangeSearchSwitch) {
        CGFloat rightMargin = CGRectGetWidth(self.openOrCloseSwitch.frame) + 10.f + 15.f;
        [self.searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-rightMargin);
        }];
    }
}

@end
