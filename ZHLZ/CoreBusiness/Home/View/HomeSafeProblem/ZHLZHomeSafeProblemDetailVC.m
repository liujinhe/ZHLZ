//
//  ZHLZHomeSafeProblemDetailVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemDetailVC.h"
#import "ZHLZHomeSafeProblemVM.h"
#import "ZHLZAddCouncilorVC.h"
#import "ZHLZChooseListVC.h"
#import "ZHLZPickerViewVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZListPickerViewVC.h"

@interface ZHLZHomeSafeProblemDetailVC ()

@property (weak, nonatomic) IBOutlet UIButton *homeSafeButton;
@property (weak, nonatomic) IBOutlet UIButton *areaNameButton;
@property (weak, nonatomic) IBOutlet UIButton *dutyAreaButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *workUserButton;

@property (weak, nonatomic) IBOutlet ZHLZTextView *problemDetailTextView;
@property (weak, nonatomic) IBOutlet ZHLZTextView *problemMarkTextView;






@property (weak, nonatomic) IBOutlet ZHLZButton *problemSubmitButton;

@property (nonatomic , strong) ZHLZHomeSafeProblemModel *homeSafeProblemModel;

@property (nonatomic , strong) ZHLZHomeSafeProblemSUbmitModel *homeSafeProblemSUbmitModel;

@end

@implementation ZHLZHomeSafeProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSafeProblemDetailView];
}

- (void)editAction {
    ZHLZHomeSafeProblemDetailVC *safeProblemDetailVC = [ZHLZHomeSafeProblemDetailVC new];
    safeProblemDetailVC.detailType = 3;
    safeProblemDetailVC.detailId = [NSString stringWithFormat:@"%@",self.homeSafeProblemModel.objectID];
    [self.navigationController pushViewController:safeProblemDetailVC animated:YES];
}

- (void)getProblemDetailData{
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeSafeProblemModel * _Nonnull homeSafeProblem) {
        self.homeSafeProblemModel = homeSafeProblem;
        

        
    }];
}

- (void)initSafeProblemDetailView {
    
    if (self.detailType == 1) {
        self.title = @"新增安全(三防)问题";
        [self.problemSubmitButton setTitle:@"确定添加" forState:UIControlStateNormal];
        
        
    } else if (self.detailType == 2){
        self.title = @"查看安全(三防)问题";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        [self getProblemDetailData];
        
        [self lookSetView];
        
    } else {
        
        self.title = @"编辑安全(三防)问题";
        [self.problemSubmitButton setTitle:@"确定修改" forState:UIControlStateNormal];
        
        [self getProblemDetailData];
        
    }
    
    self.homeSafeProblemSUbmitModel = [ZHLZHomeSafeProblemSUbmitModel new];
    
    [self.workUserButton setTitle:[ZHLZUserManager sharedInstance].user.fullname forState:UIControlStateNormal];
    
    self.homeSafeProblemSUbmitModel.promanager = [ZHLZUserManager sharedInstance].user.fullname;
}

- (void)lookSetView {
    self.problemSubmitButton.hidden = YES;
}


///台账id
- (IBAction)homeSafeAction:(UIButton *)sender {
    ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
    chooseListVC.selectIndex = 0;
    chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        self.homeSafeProblemSUbmitModel.risksid = code;
        [self.homeSafeButton setTitle:name forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:chooseListVC animated:YES];
}
///片区名称
- (IBAction)areaNameAction:(UIButton *)sender {
    ZHLZPickerViewVC *pickerVC = [ZHLZPickerViewVC new];
    NSString *orgnameString = [ZHLZUserManager sharedInstance].user.orgname;
    if ([orgnameString isEqualToString:@"一大队"]) {
        pickerVC.titleArray = @[@"北片",@"南片"];
    } else if ([orgnameString isEqualToString:@"二大队"]) {
        pickerVC.titleArray = @[@"南北片",@"芳村片"];
    } else if ([orgnameString isEqualToString:@"三大队"]) {
        pickerVC.titleArray = @[@"南片",@"北片"];
    } else if ([orgnameString isEqualToString:@"四大队"]) {
        pickerVC.titleArray = @[@"北片",@"西南片"];
    } else if ([orgnameString isEqualToString:@"五大队"]) {
        pickerVC.titleArray = @[@"广圆快速路"];
    }
    pickerVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        [self.areaNameButton setTitle:name forState:UIControlStateNormal];
        
        if ([orgnameString isEqualToString:@"五大队"]) {
            if (index == 0) {
                self.homeSafeProblemSUbmitModel.areaid = @"4";
            }
        } else {
            if (index == 0) {
                self.homeSafeProblemSUbmitModel.areaid = @"3";
            } else if (index == 1) {
                self.homeSafeProblemSUbmitModel.areaid = @"4";
            }
        }
    };
    [self presentViewController:pickerVC animated:NO completion:nil];
}

///责任区县
- (IBAction)dutyAreaAction:(UIButton *)sender {
    ZHLZListPickerViewVC *projectTypePickerViewVC = [ZHLZListPickerViewVC new];
        projectTypePickerViewVC.type = 5;
        @weakify(self)
        projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
            @strongify(self);
            
            self.homeSafeProblemSUbmitModel.belong = code;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dutyAreaButton setTitle:name forState:UIControlStateNormal];
            });
        };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];

}

///发现问题时间
- (IBAction)problemTimeAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            self.homeSafeProblemSUbmitModel.finddate = date;
            [self.problemTimeButton setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}


- (IBAction)setSupervisorAction:(UIButton *)sender {
    ZHLZAddCouncilorVC *addCouncilorVC = [ZHLZAddCouncilorVC new];
    addCouncilorVC.addCouncilorBlock = ^(NSString * _Nonnull detailStr) {
        
    };
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}

- (IBAction)problemSubmitAction:(ZHLZButton *)sender {
    
    self.homeSafeProblemSUbmitModel.ddssjtms = @"123";
    self.homeSafeProblemSUbmitModel.prodescription = self.problemDetailTextView.text;
    self.homeSafeProblemSUbmitModel.remark = self.problemMarkTextView.text;
    self.homeSafeProblemSUbmitModel.uploadId = @"123";
    
    
    @weakify(self)
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] submitHomeSafeProblemWithSubmitType:self.detailType andSubmitModel:self.homeSafeProblemSUbmitModel withBlock:^{
        
        @strongify(self)
        if (self.detailType == 1) {
            [GRToast makeText:@"新增成功"];
        } else {
            [GRToast makeText:@"修改成功"];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
