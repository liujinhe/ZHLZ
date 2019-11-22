//
//  ZHLZAddCouncilorVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZAddCouncilorVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZPickerViewVC.h"
#import "ZHLZChosseStepVC.h"

@interface ZHLZAddCouncilorVC ()

@property (weak, nonatomic) IBOutlet UIButton *supervisorTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *supervisorTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *isPutOutButton;
@property (weak, nonatomic) IBOutlet ZHLZTextView *supervisorDetailTextView;


@end

@implementation ZHLZAddCouncilorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增督导措施";
}


- (IBAction)supervisorTimeAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            [self.supervisorTimeButton setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}

- (IBAction)supervisorTypeAction:(UIButton *)sender {
    ZHLZChosseStepVC *chosseStepVC = [ZHLZChosseStepVC new];
    [self.navigationController pushViewController:chosseStepVC animated:YES];
}

- (IBAction)isPutOutAction:(UIButton *)sender {
    ZHLZPickerViewVC *pickerVC = [ZHLZPickerViewVC new];
    pickerVC.titleArray = @[@"是",@"否"];
    pickerVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        [self.isPutOutButton setTitle:name forState:UIControlStateNormal];
    };
    [self presentViewController:pickerVC animated:NO completion:nil];
}

- (IBAction)addSupervisorAction:(UIButton *)sender {
    
}

@end
