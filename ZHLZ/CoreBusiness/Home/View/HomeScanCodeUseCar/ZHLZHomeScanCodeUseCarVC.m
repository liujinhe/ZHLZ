//
//  ZHLZHomeScanCodeUseCarVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeScanCodeUseCarVC.h"
#import "ZHLZHomeRichScanVC.h"

@interface ZHLZHomeScanCodeUseCarVC ()

@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCardLabel;

@property (weak, nonatomic) IBOutlet UIView *userCarView;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;

@property (weak, nonatomic) IBOutlet UILabel *currentLocation;

@end

@implementation ZHLZHomeScanCodeUseCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scanCodeUseCarView];
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
    
}


@end
