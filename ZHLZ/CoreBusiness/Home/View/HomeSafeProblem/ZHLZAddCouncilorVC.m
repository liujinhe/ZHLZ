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

@property (nonatomic , strong) ZHLZSupervisorSubmitModel *supervisorSubmitModel;

@end

@implementation ZHLZAddCouncilorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增督导措施";
    
    self.supervisorDetailTextView.placeholder = @"请选择督导措施";
    
    [self.supervisorDetailTextView setEditable:NO];
    
    self.supervisorSubmitModel = [ZHLZSupervisorSubmitModel new];
    
    NSString *dateString = [NSString formatterWithDate:[NSDate date]];
    [self.supervisorTimeButton setTitle:dateString forState:UIControlStateNormal];
    self.stepTimeString = dateString;
    
    [self.isPutOutButton setTitle:@"是" forState:UIControlStateNormal];
    self.isPutOutString = @"1";
}

- (IBAction)supervisorTimeAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            [self.supervisorTimeButton setTitle:date forState:UIControlStateNormal];
            self.stepTimeString = date;
            
            if ([self.stepCodeString isNotBlank]) {
                self.supervisorDetailTextView.text = [NSString stringWithFormat:@"%@对该问题进行“%@”的措施;",date,self.supervisorDetailTextView.text];
            }
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}

- (IBAction)supervisorTypeAction:(UIButton *)sender {
    ZHLZChosseStepVC *chosseStepVC = [ZHLZChosseStepVC new];
    chosseStepVC.chooseStepBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        NSString *dateString = @"";
        if ([self.stepTimeString isNotBlank]) {
            dateString = [NSString stringWithFormat:@"于%@",self.stepTimeString];
        }
        self.supervisorDetailTextView.text = [NSString stringWithFormat:@"%@对该问题进行“%@”的措施;",dateString,name];
        [self.supervisorTypeButton setTitle:self.supervisorDetailTextView.text forState:UIControlStateNormal];
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
        if (index == 0) {
            self.isPutOutString = @"1";
        } else if (index == 1) {
            self.isPutOutString = @"0";
        }
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
    
    self.supervisorSubmitModel.meadate = self.stepTimeString;
    self.supervisorSubmitModel.isexport = self.isPutOutString;
    self.supervisorSubmitModel.book = self.stepCodeString;
    self.supervisorSubmitModel.meCustomize = self.supervisorDetailTextView.text;
    self.supervisorSubmitModel.uuid = [self random:8];
    
    if (self.addCouncilorBlock) {
        self.addCouncilorBlock(self.supervisorSubmitModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

// 随机生成字符串(由大小写字母、数字组成)
- (NSString *)random:(int)len {
    char ch[len];
    for (int index=0; index<len; index++) {
        int num = arc4random_uniform(75)+48;
        if (num>57 && num<65) { num = num%57+48; }
        else if (num>90 && num<97) { num = num%90+65; }
        ch[index] = num;
    }
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}


@end
