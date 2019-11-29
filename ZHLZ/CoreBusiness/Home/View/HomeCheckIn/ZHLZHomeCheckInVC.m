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
}

@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (weak, nonatomic) IBOutlet UIView *workerInView;
@property (weak, nonatomic) IBOutlet UILabel *currentTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLocationLabel;

@end

@implementation ZHLZHomeCheckInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self homeCheckInView];
}

- (void)homeCheckInView {
    self.workerInView.layer.cornerRadius = 60;
    [self.workerInView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(workerInAction:)]];
    
    _currentDate = [NSDate date];
    _currentTime = [_currentDate timeIntervalSince1970];
    
    self.currentTimeLabel.text = [NSString formatterWithTimeInterval:_currentTime];
    
    NSString *peopleCheckInDateStr = [[NSUserDefaults standardUserDefaults] objectForKey:PeopleCheckInDateConst];
    NSString *currentDateStr = [NSString formatterWithDate:_currentDate];
    if ([peopleCheckInDateStr isEqualToString:currentDateStr]) {
        self.currentTypeLabel.text = @"下班打卡";
    } else {
        self.currentTypeLabel.text = @"上班打卡";
    }
    
    _timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(timingAction) repeats:YES];
    
    self.currentLocationLabel.text = [NSString stringWithFormat:@"当前位置：%@", @""];
}

- (void)timingAction {
    _currentTime = _currentTime + 1;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentTimeLabel.text = [NSString formatterWithTimeInterval:self->_currentTime];
    });
}

- (void)workerInAction:(id)tap {
    @weakify(self);
    self.task = [[ZHLZHomeCheckInVM sharedInstance] checkInDataWithType:2 withAddress:@"" withBlock:^{
        @strongify(self);
        [[NSUserDefaults standardUserDefaults] setValue:[NSString formatterWithDate:self->_currentDate] forKey:PeopleCheckInDateConst];
    }];
}

@end
