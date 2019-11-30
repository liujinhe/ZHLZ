//
//  ZHLZHomeScanCodeUseCarVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeScanCodeUseCarVC.h"
#import "ZHLZHomeRichScanVC.h"
#import <YYKit/YYTimer.h>

@interface ZHLZHomeScanCodeUseCarVC ()
{
    NSDate *_currentDate; // 当前时间
    NSTimeInterval _currentTimeInteger; // 当前时间戳
    YYTimer *_timer;
}


@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCardLabel;

@property (weak, nonatomic) IBOutlet UIView *userCarView;

@property (weak, nonatomic) IBOutlet UILabel *carUserStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentTime;

@property (weak, nonatomic) IBOutlet UILabel *currentLocation;

@end

@implementation ZHLZHomeScanCodeUseCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scanCodeUseCarView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

-(void)userCarAction:(id)tap{
    ZHLZHomeRichScanVC *homeRichScanVC = [[ZHLZHomeRichScanVC alloc] init];
    homeRichScanVC.scanType = 2;
    [self.navigationController pushViewController:homeRichScanVC animated:YES];
}

- (void)scanCodeUseCarView{
    
    self.userCarView.layer.cornerRadius = 60;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userCarAction:)];
    [self.userCarView addGestureRecognizer:tapGesturRecognizer];

    self.currentUserNameLabel.text = [NSString stringWithFormat:@"当前用户：%@",[ZHLZUserManager sharedInstance].user.fullname];
    
    _currentDate = [NSDate date];
    _currentTimeInteger = [_currentDate timeIntervalSince1970];
    
    self.currentTime.text = [NSString formatterWithTimeInterval:_currentTimeInteger];
    
    NSString *carCheckInStr = [[NSUserDefaults standardUserDefaults] objectForKey:CarCheckInDateConst];
    
    if ([carCheckInStr isNotBlank]) {
        self.userCardLabel.text = [NSString stringWithFormat:@"当前用车：%@",carCheckInStr];
        self.carUserStatusLabel.text = @"立即还车";
        
    } else {
        self.carUserStatusLabel.text = @"立即用车";
    }
    
    _timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(timingAction) repeats:YES];
    
    self.currentLocation.text = [NSString stringWithFormat:@"当前位置：%@", @""];
}

- (void)timingAction {
    _currentTimeInteger = _currentTimeInteger + 1;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentTime.text = [NSString formatterWithTimeInterval:self->_currentTimeInteger];
    });
}



@end
