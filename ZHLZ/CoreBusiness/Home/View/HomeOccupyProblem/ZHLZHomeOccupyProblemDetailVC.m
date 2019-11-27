//
//  ZHLZHomeOccupyProblemDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeOccupyProblemDetailVC.h"
#import "ZHLZHomeOccupyProblemVM.h"
#import "ZHLZChooseListVC.h"
#import "ZHLZListPickerViewVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZAddCouncilorVC.h"


@interface ZHLZHomeOccupyProblemDetailVC ()

@property (weak, nonatomic) IBOutlet UIButton *projectNameButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTimeButtotn;
@property (weak, nonatomic) IBOutlet UIButton *workPoeopleButton;

@property (weak, nonatomic) IBOutlet ZHLZTextView *problemTextView;
@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;


@end

@implementation ZHLZHomeOccupyProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self occupyProblemDetailView];
}

- (void)occupyProblemDetailView {
    if (self.type == 2) {
        self.navTitle = @"占道施工详情";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
    } else if (self.type == 3) {
        self.navTitle = @"编辑占道施工详情";
    }
    
    [self loadOccupyProblemDetail];
}

- (void)loadOccupyProblemDetail {
    self.task = [[ZHLZHomeOccupyProblemVM sharedInstance] loadHomeOccupyProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeOccupyProblemDetailModel * _Nonnull occupyProblemDetailModel) {
        
    }];
}

- (void)editAction {
    ZHLZHomeOccupyProblemDetailVC *occupyProblemDetailVC = [ZHLZHomeOccupyProblemDetailVC new];
    occupyProblemDetailVC.detailId = self.detailId;
    occupyProblemDetailVC.type = 3;
    [self.navigationController pushViewController:occupyProblemDetailVC animated:YES];
}
///项目名称
- (IBAction)projectNameAction:(UIButton *)sender {
    ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
    chooseListVC.selectIndex = 8;
    @weakify(self)
    chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self)
        
//        self.safeSubmitModel.unitId = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.projectNameButton setTitle:name forState:UIControlStateNormal];
        });
    };
    [self.navigationController pushViewController:chooseListVC animated:YES];
}

///问题类型
- (IBAction)problemTypeAction:(UIButton *)sender {
    ZHLZListPickerViewVC *problemTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    problemTypeListPickerViewVC.type = 7;
    @weakify(self)
    problemTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
//        self->_problemType = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.problemTypeButton.selected = YES;
            [self.problemTypeButton setTitle:name forState:UIControlStateSelected];
        });
    };
    [self presentViewController:problemTypeListPickerViewVC animated:NO completion:nil];
}

///所属区县
- (IBAction)areaAction:(UIButton *)sender {
    ZHLZListPickerViewVC *projectTypePickerViewVC = [ZHLZListPickerViewVC new];
    projectTypePickerViewVC.type = 5;
    @weakify(self)
    projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        
//        self.projectSubmitModel.belong = code;
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.dutyAreaButton setTitle:name forState:UIControlStateNormal];
        });
    };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
}

///问题时间
- (IBAction)problemTimeAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
//            self.projectSubmitModel.finishdate = date;
//            [self.licenceEndButton setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}

///经办人
- (IBAction)workPeopleAction:(UIButton *)sender {
    
}

///督导
- (IBAction)supervisorAction:(UIButton *)sender {
    ZHLZAddCouncilorVC *addCouncilorVC = [ZHLZAddCouncilorVC new];
    @weakify(self)
    addCouncilorVC.addCouncilorBlock = ^(ZHLZSupervisorSubmitModel * _Nonnull supervisorSubmitModel) {
        @strongify(self)
        if (supervisorSubmitModel) {
//            [self.supervisorSubmitModelArray addObject:supervisorSubmitModel];
        }
    };
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}

///修改提交
- (IBAction)submitAction:(ZHLZButton *)sender {
    
}

@end
