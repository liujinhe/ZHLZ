//
//  ZHLZHomeCheckInVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCheckInVC.h"

@interface ZHLZHomeCheckInVC ()

@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;

@property (weak, nonatomic) IBOutlet UIView *workerInView;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentLocationLabel;

@end

@implementation ZHLZHomeCheckInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self homeCheckInView];
}

- (void)homeCheckInView{
    
    self.workerInView.layer.cornerRadius = 60;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(workerInAction:)];
    [self.workerInView addGestureRecognizer:tapGesturRecognizer];

//    NSString *nowStr = [self getCurrentTimeyyyymmdd];
}

-(void)workerInAction:(id)tap{


}

- (NSString *)getCurrentTimeyyyymmdd {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
}

@end
