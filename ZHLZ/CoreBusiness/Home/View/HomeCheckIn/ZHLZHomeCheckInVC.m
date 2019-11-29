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
    
    self.currentTypeLabel.text = @""; // @"下班打卡" : @"上班打卡";
    self.currentTimeLabel.text = [NSString formatterWithTime:[NSDate date]];
    self.currentLocationLabel.text = [NSString stringWithFormat:@"当前位置：%@", @""];
    
    self.workerInView.layer.cornerRadius = 60;
    [self.workerInView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(workerInAction:)]];
}

- (void)workerInAction:(id)tap {
    
    
}

@end
