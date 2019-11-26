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
#import "ZHLZHomeSafeProblemVM.h"


@interface ZHLZAddCouncilorVC ()

@property (weak, nonatomic) IBOutlet UIButton *supervisorTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *supervisorTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *isPutOutButton;
@property (weak, nonatomic) IBOutlet ZHLZTextView *supervisorDetailTextView;


@property (nonatomic , strong) NSString *stepCodeString;
@property (nonatomic , strong) NSString *stepTimeString;
@property (nonatomic , strong) NSString *isPutOutString;

@end

@implementation ZHLZAddCouncilorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增督导措施";
    
    [self.supervisorDetailTextView setEditable:NO];
}

- (IBAction)supervisorTimeAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            [self.supervisorTimeButton setTitle:date forState:UIControlStateNormal];
            self.stepTimeString = date;
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}

- (IBAction)supervisorTypeAction:(UIButton *)sender {
    ZHLZChosseStepVC *chosseStepVC = [ZHLZChosseStepVC new];
    chosseStepVC.chooseStepBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        self.supervisorDetailTextView.text = [NSString stringWithFormat:@"对该问题进行“%@”的措施;",name];
        self.stepCodeString = code;
    };
    [self.navigationController pushViewController:chosseStepVC animated:YES];
}

- (IBAction)isPutOutAction:(UIButton *)sender {
    
    NSArray *outArray = @[@"是",@"否"];
    
    ZHLZPickerViewVC *pickerVC = [ZHLZPickerViewVC new];
    pickerVC.titleArray = outArray;
    pickerVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        [self.isPutOutButton setTitle:name forState:UIControlStateNormal];
        self.isPutOutString = outArray[index];
    };
    [self presentViewController:pickerVC animated:NO completion:nil];
}

- (IBAction)addSupervisorAction:(UIButton *)sender {
    
    if (![self.stepTimeString isNotBlank]) {
        [GRToast makeText:@"请选择督导时间"];
        return;
    }
    if (![self.stepCodeString isNotBlank]) {
        [GRToast makeText:@"请选择督导措施"];
        return;
    }
    if (![self.isPutOutString isNotBlank]) {
        [GRToast makeText:@"请选择是否导出"];
        return;
    }
    
    @weakify(self)
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] submitSupervisorWithParms:@{@"meadate":self.stepTimeString,@"isexport":self.isPutOutString,@"meCustomize":self.supervisorDetailTextView.text,@"book":self.stepCodeString} withBlock:^{
        @strongify(self)
        
        if (self.addCouncilorBlock) {
            self.addCouncilorBlock(self.supervisorDetailTextView.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

@end
