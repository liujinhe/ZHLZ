//
//  ZHLZDatePickerVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/22.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZDatePickerVC.h"

@interface ZHLZDatePickerVC ()

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ZHLZDatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
}

#pragma mark - Action

/// 取消
- (IBAction)cancelAction {
    [self dismissViewControllerAnimated:NO completion:nil];
}

/// 确定
- (IBAction)determineAction {
    @weakify(self);
    [self dismissViewControllerAnimated:NO completion:^{
        @strongify(self);
        if (self.selectDatePickerBlock) {
            self.selectDatePickerBlock([NSString formatterWithDate:self.datePicker.date]);
        }
    }];
}

- (void)setCurrentDate:(NSString *)currentDate {
    _currentDate = currentDate;
    
    self.datePicker.date = [NSDate formatterDateWithDateString:_currentDate];
}

- (void)setMinDate:(NSString *)minDate {
    _minDate = minDate;
    
    self.datePicker.minimumDate = [NSDate formatterDateWithDateString:_minDate];
}

- (void)setMaxDate:(NSString *)maxDate {
    _maxDate = maxDate;
    
    self.datePicker.maximumDate = [NSDate formatterDateWithDateString:_maxDate];
}

@end
