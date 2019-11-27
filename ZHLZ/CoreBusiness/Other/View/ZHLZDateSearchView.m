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

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *startDateButton;
@property (nonatomic, strong) UIButton *endDateButton;

@property (nonatomic, strong) ZHLZDatePickerVC *startDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDatePickerVC;

@end

@implementation ZHLZDateSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initUI];
}

- (void)initUI {
    self.backgroundColor = UIColor.whiteColor;
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.adjustsImageWhenHighlighted = NO;
    self.searchButton.titleLabel.font = kFont(14);
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:kThemeColor forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self);
        make.width.offset(60);
    }];
    
    self.startDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startDateButton.layer.cornerRadius = 5.f;
    self.startDateButton.adjustsImageWhenHighlighted = NO;
    self.startDateButton.backgroundColor = kHexRGB(0xc9c9c9);
    self.startDateButton.titleLabel.font = kFont(14);
    [self.startDateButton setTitleColor:kHexRGB(0x333333) forState:UIControlStateNormal];
    [self.startDateButton setTitle:@"请选择开始日期" forState:UIControlStateNormal];
    [self.startDateButton addTarget:self action:@selector(startDateAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.startDateButton];
    [self.startDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.offset(30);
        make.centerY.equalTo(self.searchButton.mas_centerY);
    }];
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.font = kFont(14);
    tagLabel.text = @"至";
    tagLabel.textColor = kHexRGB(0x333333);
    tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tagLabel];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.startDateButton.mas_right);
        make.width.equalTo(tagLabel.mas_height);
    }];
    
    self.endDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endDateButton.layer.cornerRadius = 5.f;
    self.endDateButton.adjustsImageWhenHighlighted = NO;
    self.endDateButton.backgroundColor = kHexRGB(0xc9c9c9);
    self.endDateButton.titleLabel.font = kFont(14);
    [self.endDateButton setTitleColor:kHexRGB(0x333333) forState:UIControlStateNormal];
    [self.endDateButton setTitle:@"请选择结束日期" forState:UIControlStateNormal];
    [self.endDateButton addTarget:self action:@selector(endDateAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.endDateButton];
    [self.endDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagLabel.mas_right);
        make.right.equalTo(self.searchButton.mas_left);
        make.height.equalTo(self.startDateButton.mas_height);
        make.centerY.equalTo(self.searchButton.mas_centerY);
        make.width.equalTo(self.startDateButton.mas_width);
    }];
    
    @weakify(self);
    self.startDatePickerVC = [ZHLZDatePickerVC new];
    self.startDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        
        self->_startDate = date;

        [self.startDateButton setTitle:date forState:UIControlStateNormal];
        
        self.endDatePickerVC.minDate = date;
    };
    
    self.endDatePickerVC = [ZHLZDatePickerVC new];
    self.endDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        
        self->_endDate = date;
        
        [self.endDateButton setTitle:date forState:UIControlStateNormal];
        
        self.startDatePickerVC.maxDate = date;
    };
}

- (void)searchAction {
    if (self.searchWithDateBlock) {
        self.searchWithDateBlock(_startDate, _endDate);
    }
}

- (void)startDateAction {
    @weakify(self);
    [_currentVC presentViewController:self.startDatePickerVC animated:NO completion:^{
        @strongify(self);
        self.startDatePickerVC.currentDate = self->_startDate;
        self.startDatePickerVC.maxDate = self->_endDate;
    }];
}

- (void)endDateAction {
    @weakify(self);
    [_currentVC presentViewController:self.endDatePickerVC animated:NO completion:^{
        @strongify(self);
        self.endDatePickerVC.currentDate = self->_endDate;
        self.endDatePickerVC.minDate = self->_startDate;
    }];
}

- (void)setCurrentVC:(UIViewController *)currentVC {
    _currentVC = currentVC;
}

- (void)setStartDate:(NSString *)startDate {
    _startDate = startDate;
    
    [self.startDateButton setTitle:_startDate forState:UIControlStateNormal];
}

- (void)setEndDate:(NSString *)endDate {
    _endDate = endDate;
    
    [self.endDateButton setTitle:_endDate forState:UIControlStateNormal];
}

@end
