//
//  ZHLZDateSearchView.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZDateSearchView.h"
#import "ZHLZDatePickerVC.h"

@interface ZHLZDateSearchView ()
{
    NSString *_startDate;
    NSString *_endDate;
}

@property (nonatomic, strong) UIButton *startDateButton;
@property (nonatomic, strong) UIButton *endDateButton;
@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) ZHLZDatePickerVC *startDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDatePickerVC;

@end

@implementation ZHLZDateSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initUI];
}

- (void)initUI {
    NSDate *currentDate = [NSDate date];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.adjustsImageWhenHighlighted = NO;
    self.searchButton.titleLabel.font = kFont(14);
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:kThemeColor forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.offset(85);
    }];
    
    self.startDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startDateButton.adjustsImageWhenHighlighted = NO;
    self.startDateButton.titleLabel.font = kFont(14);
    [self.startDateButton setTitle:[NSString formatterBeforeOrAfterDateWithDate:currentDate withMonth:-1] forState:UIControlStateNormal];
    [self.startDateButton addTarget:self action:@selector(startDateAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.startDateButton];
    [self.startDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.offset(30);
        make.centerX.equalTo(self);
    }];
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.font = kFont(14);
    tagLabel.text = @"至";
    tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tagLabel];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.searchButton.mas_right);
        make.width.equalTo(tagLabel.mas_width);
    }];
    
    self.endDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endDateButton.adjustsImageWhenHighlighted = NO;
    self.endDateButton.titleLabel.font = kFont(14);
    [self.endDateButton setTitle:[NSString formatterWithDate:currentDate] forState:UIControlStateNormal];
    [self.endDateButton addTarget:self action:@selector(endDateAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.endDateButton];
    [self.endDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagLabel.mas_right);
        make.right.equalTo(self.searchButton.mas_left).offset(10);
        make.height.offset(30);
        make.centerX.equalTo(self);
        make.width.equalTo(self.startDateButton.mas_width);
    }];
    
    @weakify(self);
    self.startDatePickerVC = [ZHLZDatePickerVC new];
    self.startDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        
        self->_startDate = date;

        [self.startDateButton setTitle:date forState:UIControlStateNormal];
    };
    
    self.endDatePickerVC = [ZHLZDatePickerVC new];
    self.endDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        
        self->_endDate = date;
        
        [self.endDateButton setTitle:date forState:UIControlStateNormal];
    };
}

- (void)searchAction {
    if (self.searchWithDateBlock) {
        self.searchWithDateBlock(_startDate, _endDate);
    }
}

- (void)startDateAction {
    [_currentVC presentViewController:self.startDatePickerVC animated:NO completion:nil];
}

- (void)endDateAction {
    [_currentVC presentViewController:self.endDatePickerVC animated:NO completion:nil];
}

- (void)setCurrentVC:(UIViewController *)currentVC {
    _currentVC = currentVC;
}

@end
