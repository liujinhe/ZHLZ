//
//  ZHLZHomeCheckInVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCheckInVC.h"
#import "ZHLZHomeCheckInVM.h"

#import <YYKit/YYTimer.h>

@interface ZHLZHomeCheckInVC ()
{
    NSDate *_currentDate; // 当前时间
    NSTimeInterval _currentTime; // 当前时间戳
    YYTimer *_timer;
    NSString *_address; // 当前位置
    NSInteger _optionType; // 操作类型（0-已完成打卡 1-上班打卡 2-下班打卡）
}

@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (weak, nonatomic) IBOutlet UIView *workerInView;
@property (weak, nonatomic) IBOutlet UILabel *currentTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLocationLabel;
@property (weak, nonatomic) IBOutlet UIButton *regetLocationButton;

@end

@implementation ZHLZHomeCheckInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCurrentLocationInfoAction) name:ReloadCurrentLocationInfoConst object:nil];
    
    [self homeCheckInView];
}

- (void)homeCheckInView {
    self.workerInView.userInteractionEnabled = YES;
    self.workerInView.layer.cornerRadius = 60;
    [self.workerInView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(workerInAction)]];
    
    self.currentUserNameLabel.text = [ZHLZUserManager sharedInstance].user.fullname?:@"";
    
    _currentDate = [NSDate date];
    _currentTime = [_currentDate timeIntervalSince1970];
    
    self.currentTimeLabel.text = [NSString formatterWithTimeInterval:_currentTime];
    
    NSDate *peopleCheckInDateOnWork = [[NSUserDefaults standardUserDefaults] objectForKey:PeopleCheckInDateOnWorkConst];
    NSDate *peopleCheckInDateOffWork = [[NSUserDefaults standardUserDefaults] objectForKey:PeopleCheckInDateOffWorkConst];
    NSString *currentDateStr = [NSString formatterWithDate:_currentDate];
    NSString *peopleCheckInDateOnWorkStr = [NSString formatterWithDate:peopleCheckInDateOnWork];
    NSString *peopleCheckInDateOffWorkStr = [NSString formatterWithDate:peopleCheckInDateOffWork];
    if (![peopleCheckInDateOnWorkStr isEqualToString:currentDateStr]) {
        self.currentTypeLabel.text = @"上班打卡";
        _optionType = 1;
    } else if (![peopleCheckInDateOffWorkStr isEqualToString:currentDateStr]) {
        self.currentTypeLabel.text = @"下班打卡";
        _optionType = 2;
    } else {
        self.currentTypeLabel.text = @"今日已打卡";
        self.workerInView.backgroundColor = UIColor.lightGrayColor;
        self.workerInView.userInteractionEnabled = NO;
    }
    
    _timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(timingAction) repeats:YES];
    
    [self reloadCurrentLocationInfoAction];
}

- (IBAction)regetLocationAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:RegetLocationNotificationConst object:nil];
}

/// 刷新当前位置信息
- (void)reloadCurrentLocationInfoAction {
    _address = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentLocationAddressConst];
    if ([_address isNotBlank]) {
        self.currentLocationLabel.text = [NSString stringWithFormat:@"当前位置：%@", _address];
        self.regetLocationButton.hidden = YES;
    } else {
        self.regetLocationButton.hidden = NO;
    }
}

- (void)timingAction {
    _currentTime = _currentTime + 1;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentTimeLabel.text = [NSString formatterWithTimeInterval:self->_currentTime];
    });
}

- (void)workerInAction {
    @weakify(self);
    if (![_address isNotBlank]) {
        [GRToast makeText:@"无法定位当前位置"];
        return;
    }
    self.task = [[ZHLZHomeCheckInVM sharedInstance] checkInDataWithType:2 withAddress:_address withBlock:^{
        @strongify(self);
        if (self->_optionType == 1) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:PeopleCheckInDateOnWorkConst];
            self->_optionType = 2;
            self.currentTypeLabel.text = @"下班打卡";
            return;
        }
        if (self->_optionType == 2) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:PeopleCheckInDateOffWorkConst];
            self->_optionType = 0;
            self.currentTypeLabel.text = @"今日已打卡";
            self.workerInView.backgroundColor = UIColor.lightGrayColor;
            self.workerInView.userInteractionEnabled = NO;
            return;
        }
    }];
}

@end
