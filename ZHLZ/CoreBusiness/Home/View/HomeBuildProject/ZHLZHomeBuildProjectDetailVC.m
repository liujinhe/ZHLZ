//
//  ZHLZHomeBuildProjectDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectDetailVC.h"
#import "ZHLZProjectDetailTableViewCell.h"
#import "ZHLZHomeBuildProjectVM.h"
#import "ZHLZOtherVM.h"
#import "ZHLZListPickerViewVC.h"
#import "ZHLZBrigadePickerViewVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZAreaPickerViewVC.h"
#import "ZHLZChooseListVC.h"
#import "ZHLZPickerViewVC.h"

@interface ZHLZHomeBuildProjectDetailVC ()

@property (weak, nonatomic) IBOutlet UITextField *projectNameTextFile;
@property (weak, nonatomic) IBOutlet UIButton *projectTypeButton;
@property (weak, nonatomic) IBOutlet UITextField *projectLocationTextFile;
@property (weak, nonatomic) IBOutlet UIButton *developmentUnitButton;
@property (weak, nonatomic) IBOutlet UIButton *roadWorkButton;
@property (weak, nonatomic) IBOutlet UIButton *approvalAuthorityButton;

@property (weak, nonatomic) IBOutlet UIButton *licenceStartButton;
@property (weak, nonatomic) IBOutlet UIButton *licenceEndButton;
@property (weak, nonatomic) IBOutlet UIButton *demandTimeButton;

@property (weak, nonatomic) IBOutlet UIButton *roadWorkTypeButton;

@property (weak, nonatomic) IBOutlet UIButton *brigadeButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UIButton *dutyAreaButton;

@property (weak, nonatomic) IBOutlet UITextField *acreageTextFile;
@property (weak, nonatomic) IBOutlet UITextField *licenceNumTextFile;

@property (weak, nonatomic) IBOutlet UITextField *projectNumTextFile;
@property (weak, nonatomic) IBOutlet UIButton *emphasisProjectButton;


@property (weak, nonatomic) IBOutlet UILabel *locationXLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationYLabel;
@property (weak, nonatomic) IBOutlet ZHLZTextView *remarkTextView;


@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;

@property (nonatomic , strong) ZHLZHomeBuildProjectSubmitModel *projectSubmitModel;

@end

@implementation ZHLZHomeBuildProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildProjectDetailView];
}

-(void)editAction {
    ZHLZHomeBuildProjectDetailVC *buildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
    buildProjectDetailVC.detailType = 3;
    buildProjectDetailVC.reloadDataBlock = ^{
        [self loadDetailData];
    };
    buildProjectDetailVC.detailId = self.detailId;
    [self.navigationController pushViewController:buildProjectDetailVC animated:YES];
}

- (void)buildProjectDetailView{
    
    if (self.detailType == 1) {
        
        self.title = @"新增在建项目";
        [self.submitButton setTitle:@"确认新建" forState:UIControlStateNormal];
        
    } else if (self.detailType == 2){
        self.title = @"查看在建项目";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        self.submitButton.hidden = YES;
        
        [self loadDetailData];
        
        [self setViewToLookDetail];
        
    } else {
        self.title = @"编辑在建项目";
        [self.submitButton setTitle:@"确认保存" forState:UIControlStateNormal];
        
        [self loadDetailData];
    }
    
    self.projectSubmitModel = [ZHLZHomeBuildProjectSubmitModel new];
    
    self.remarkTextView.placeholder = @"备注";
    
    self.brigadeButton.userInteractionEnabled = NO;
    
    if (self.detailType == 1 || self.detailType == 3) {
        [self.brigadeButton setTitle:[ZHLZUserManager sharedInstance].user.orgname forState:UIControlStateNormal];
        self.projectSubmitModel.bid = [ZHLZUserManager sharedInstance].user.orgId;
        
        NSDictionary *coordinate = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentLocationCoordinateConst];
        
        if (coordinate) {
            self.locationXLabel.text = [NSString stringWithFormat:@"经度：%@",[coordinate objectForKey:@"longitude"]];
            self.locationYLabel.text = [NSString stringWithFormat:@"纬度：%@",[coordinate objectForKey:@"latitude"]];
        }
    }
}

- (void)setViewToLookDetail {
    
    //设置UIButton背景颜色
//    self.projectTypeButton.backgroundColor = [UIColor whiteColor];
//    self.projectTypeButton.backgroundColor = [UIColor whiteColor];
//    self.developmentUnitButton.backgroundColor = [UIColor whiteColor];
//    self.roadWorkButton.backgroundColor = [UIColor whiteColor];
//    self.approvalAuthorityButton.backgroundColor = [UIColor whiteColor];
//    
//    self.licenceStartButton.backgroundColor = [UIColor whiteColor];
//    self.licenceEndButton.backgroundColor = [UIColor whiteColor];
//    self.demandTimeButton.backgroundColor = [UIColor whiteColor];
//    self.roadWorkTypeButton.backgroundColor = [UIColor whiteColor];
//    self.brigadeButton.backgroundColor = [UIColor whiteColor];
//    
//    self.areaButton.backgroundColor = [UIColor whiteColor];
//    self.dutyAreaButton.backgroundColor = [UIColor whiteColor];
//    self.emphasisProjectButton.backgroundColor = [UIColor whiteColor];
    
    
    //设置按钮不可编辑
    self.projectNameTextFile.userInteractionEnabled = NO;
    self.projectTypeButton.userInteractionEnabled = NO;
    self.projectLocationTextFile.userInteractionEnabled = NO;
    self.developmentUnitButton.userInteractionEnabled = NO;
    self.roadWorkButton.userInteractionEnabled = NO;
    
    self.approvalAuthorityButton.userInteractionEnabled = NO;
    self.licenceStartButton.userInteractionEnabled = NO;
    self.licenceEndButton.userInteractionEnabled = NO;
    self.demandTimeButton.userInteractionEnabled = NO;
    self.roadWorkTypeButton.userInteractionEnabled = NO;
    
    self.brigadeButton.userInteractionEnabled = NO;
    self.areaButton.userInteractionEnabled = NO;
    self.dutyAreaButton.userInteractionEnabled = NO;
    self.acreageTextFile.userInteractionEnabled = NO;
    self.licenceNumTextFile.userInteractionEnabled = NO;
    
    self.projectNumTextFile.userInteractionEnabled = NO;
    self.emphasisProjectButton.userInteractionEnabled = NO;
    [self.remarkTextView setEditable:NO];
    
}

- (void)loadDetailData {
    self.task = [[ZHLZHomeBuildProjectVM sharedInstance] loadHomeBuildProjectDataId:self.detailId WithBlock:^(ZHLZHomeBuildProjectModel * _Nonnull homeBuildProjectModel) {
        
        if (self.detailType == 2) {
            [self.brigadeButton setTitle:homeBuildProjectModel.bidName forState:UIControlStateNormal];
        }
        
        self.projectNameTextFile.text = homeBuildProjectModel.name;
        
        [self.projectTypeButton setTitle:homeBuildProjectModel.typeName forState:UIControlStateNormal];
        
        self.projectLocationTextFile.text = homeBuildProjectModel.position;
        
        [self.developmentUnitButton setTitle:homeBuildProjectModel.constructorName forState:UIControlStateNormal];
        
        [self.roadWorkButton setTitle:homeBuildProjectModel.builderName forState:UIControlStateNormal];
        
        [self.approvalAuthorityButton setTitle:homeBuildProjectModel.approverName forState:UIControlStateNormal];
        
        
        NSString *licenceTimeString  = homeBuildProjectModel.enddateNew;
        NSRange range = [licenceTimeString rangeOfString:@"至"];
        NSString *timeStart = [licenceTimeString substringToIndex:range.location];
        NSString *timeEnd = [licenceTimeString substringFromIndex:range.location + 1];
        
        [self.licenceStartButton setTitle:timeStart forState:UIControlStateNormal];
        [self.licenceEndButton setTitle:timeEnd forState:UIControlStateNormal];
        
        
        [self.demandTimeButton setTitle:homeBuildProjectModel.frequencyName forState:UIControlStateNormal];
        
        
        [self.roadWorkTypeButton setTitle:homeBuildProjectModel.statusName forState:UIControlStateNormal];
        
        [self.brigadeButton setTitle:homeBuildProjectModel.bidName forState:UIControlStateNormal];
        
        //片区名称
        NSString *orgnameString = [ZHLZUserManager sharedInstance].user.orgname;
        NSInteger areaid = [homeBuildProjectModel.areaid integerValue];
        
        NSString *areaString = @"";
        if ([orgnameString isEqualToString:@"一大队"]) {
            if (areaid == 1) {
                areaString = @"北片";
            } else if (areaid == 2) {
                areaString = @"南片";
            }
        } else if ([orgnameString isEqualToString:@"二大队"]) {
            if (areaid == 3) {
                areaString = @"南北片";
            } else if (areaid == 4) {
                areaString = @"芳村片";
            }
        } else if ([orgnameString isEqualToString:@"三大队"]) {
            if (areaid == 5) {
                areaString = @"北片";
            } else if (areaid == 6) {
                areaString = @"南片";
            }
        } else if ([orgnameString isEqualToString:@"四大队"]) {
            if (areaid == 7) {
                areaString = @"北片";
            } else if (areaid == 8) {
                areaString = @"西南片";
            }
        } else if ([orgnameString isEqualToString:@"五大队"]) {
            areaString = @"广圆快速路";
        }
        [self.areaButton setTitle:areaString forState:UIControlStateNormal];
        
        [self.dutyAreaButton setTitle:homeBuildProjectModel.belongname forState:UIControlStateNormal];
        
        self.acreageTextFile.text = homeBuildProjectModel.area;
        self.licenceNumTextFile.text = homeBuildProjectModel.licenseId;
        self.projectNumTextFile.text = homeBuildProjectModel.projectno;
        
        if ([homeBuildProjectModel.focuson integerValue] == 1) {
            [self.emphasisProjectButton setTitle:@"重点" forState:UIControlStateNormal];
        } else {
            [self.emphasisProjectButton setTitle:@"非重点 " forState:UIControlStateNormal];
        }
        
        if (self.detailType == 2) {
            self.locationXLabel.text = [NSString stringWithFormat:@"经度：%@",homeBuildProjectModel.coordinatesX];
            self.locationYLabel.text = [NSString stringWithFormat:@"纬度：%@",homeBuildProjectModel.coordinatesY];
        }
        
        self.remarkTextView.text = homeBuildProjectModel.remark;
        
        
        ///修改初始默认值
        if (self.detailType == 3) {
            self.projectSubmitModel.projecttypeId = homeBuildProjectModel.projecttypeId;
            self.projectSubmitModel.constructorId = homeBuildProjectModel.constructorId;
            self.projectSubmitModel.builderId = homeBuildProjectModel.builderId;
            self.projectSubmitModel.createdate = self.licenceStartButton.titleLabel.text;
            self.projectSubmitModel.finishdate = self.licenceEndButton.titleLabel.text;
            self.projectSubmitModel.frequency = homeBuildProjectModel.frequency;
            self.projectSubmitModel.projectstatusId = homeBuildProjectModel.projectstatusId;
            self.projectSubmitModel.areaid = homeBuildProjectModel.areaid;
            self.projectSubmitModel.belong = homeBuildProjectModel.belong;
            self.projectSubmitModel.focuson = homeBuildProjectModel.focuson;
            self.projectSubmitModel.id = homeBuildProjectModel.objectID;
        }
        
        
    }];
}

///工程类型
- (IBAction)projectTypeAction:(UIButton *)sender {
    ZHLZListPickerViewVC *projectTypePickerViewVC = [ZHLZListPickerViewVC new];
            projectTypePickerViewVC.type = 4;
            @weakify(self)
            projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
                @strongify(self);
                
                self.projectSubmitModel.projecttypeId = code;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.projectTypeButton setTitle:name forState:UIControlStateNormal];
                });
            };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
}

///建设单位
- (IBAction)dutyUnitAction:(UIButton *)sender {
    ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
    chooseListVC.selectIndex = 2;
    chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        self.projectSubmitModel.constructorId = code;
        [self.developmentUnitButton setTitle:name forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:chooseListVC animated:YES];
}

///施工单位
- (IBAction)roadWorkAction:(UIButton *)sender {
    ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
    chooseListVC.selectIndex = 0;
    chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        self.projectSubmitModel.builderId = code;
        [self.roadWorkButton setTitle:name forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:chooseListVC animated:YES];
}
///审批单位
- (IBAction)approveUnitAction:(UIButton *)sender {
    ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
    chooseListVC.selectIndex = 1;
    chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        self.projectSubmitModel.approverId = code;
        [self.approvalAuthorityButton setTitle:name forState:UIControlStateNormal];
        
    };
    [self.navigationController pushViewController:chooseListVC animated:YES];
    
}

///许可证开始时间
- (IBAction)licenceSatrtAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            self.projectSubmitModel.createdate = date;
            [self.licenceStartButton setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}
///许可证结束时间
- (IBAction)licenceEndAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            self.projectSubmitModel.finishdate = date;
            [self.licenceEndButton setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}
///巡查x次数
- (IBAction)chenckTimeAction:(UIButton *)sender {
    ZHLZListPickerViewVC *projectTypePickerViewVC = [ZHLZListPickerViewVC new];
            projectTypePickerViewVC.type = 3;
            @weakify(self)
            projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
                @strongify(self);
                
                self.projectSubmitModel.frequency = code;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.demandTimeButton setTitle:name forState:UIControlStateNormal];
                });
            };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
    
}
///施工状态
- (IBAction)workStatusAction:(UIButton *)sender {
    ZHLZListPickerViewVC *projectTypePickerViewVC = [ZHLZListPickerViewVC new];
            projectTypePickerViewVC.type = 2;
            @weakify(self)
            projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
                @strongify(self);
                
                self.projectSubmitModel.projectstatusId = code;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.roadWorkTypeButton setTitle:name forState:UIControlStateNormal];
                });
            };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
    
}
///所属大队
- (IBAction)brigadeAction:(UIButton *)sender {
//    ZHLZBrigadePickerViewVC *brigadePickerViewVC = [ZHLZBrigadePickerViewVC new];
//        @weakify(self)
//        brigadePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull brigadeType, NSString * _Nonnull brigadeName) {
//            @strongify(self);
//
////            self.safeSubmitModel.orgName = brigadeName;
//            dispatch_async(dispatch_get_main_queue(), ^{
////                [self.bigGrouponButton setTitle:brigadeName forState:UIControlStateNormal];
//            });
//        };
//    [self presentViewController:brigadePickerViewVC animated:NO completion:nil];
}
///片区名称
- (IBAction)areaNmeAction:(UIButton *)sender {
    
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
        [self.areaButton setTitle:name forState:UIControlStateNormal];
        
        if ([orgnameString isEqualToString:@"五大队"]) {
            if (index == 0) {
                self.projectSubmitModel.areaid = @"4";
            }
        } else {
            if (index == 0) {
                self.projectSubmitModel.areaid = @"3";
            } else if (index == 1) {
                self.projectSubmitModel.areaid = @"4";
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
            
            self.projectSubmitModel.belong = code;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dutyAreaButton setTitle:name forState:UIControlStateNormal];
            });
        };
        [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
}

///重点项目
- (IBAction)emphasisProjectAction:(UIButton *)sender {
        ZHLZListPickerViewVC *projectTypePickerViewVC = [ZHLZListPickerViewVC new];
        projectTypePickerViewVC.type = 1;
        @weakify(self)
        projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
            @strongify(self);
            
            self.projectSubmitModel.focuson = code;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.emphasisProjectButton setTitle:name forState:UIControlStateNormal];
            });
        };
        [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
}


- (IBAction)submitAction:(id)sender {

    self.projectSubmitModel.name = self.projectNameTextFile.text;
    self.projectSubmitModel.position = self.projectLocationTextFile.text;
    self.projectSubmitModel.area = self.acreageTextFile.text;
    self.projectSubmitModel.licenseId = self.licenceNumTextFile.text;
    self.projectSubmitModel.projectno = self.projectNumTextFile.text;
    
    NSDictionary *coordinate = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentLocationCoordinateConst];
    if (coordinate) {
        self.projectSubmitModel.coordinatesX = [coordinate objectForKey:@"longitude"];
        self.projectSubmitModel.coordinatesY = [coordinate objectForKey:@"latitude"];
    }
    self.projectSubmitModel.remark = self.remarkTextView.text;
    
    if (![self.projectSubmitModel.name isNotBlank]) {
        [GRToast makeText:@"请输入项目名称"];
        return;
    }
    if (![self.projectSubmitModel.projecttypeId isNotBlank]) {
        [GRToast makeText:@"请选择项目类型"];
        return;
    }
    if (![self.projectSubmitModel.position isNotBlank]) {
        [GRToast makeText:@"请输入工程地点"];
        return;
    }
    if (![self.projectSubmitModel.constructorId isNotBlank]) {
        [GRToast makeText:@"请选择建设单位"];
        return;
    }
    if (![self.projectSubmitModel.projectstatusId isNotBlank]) {
        [GRToast makeText:@"请选择施工单位"];
        return;
    }
    if (![self.projectSubmitModel.projectno isNotBlank]) {
        [GRToast makeText:@"请选择巡查频次"];
        return;
    }
    if (![self.projectSubmitModel.projectno isNotBlank]) {
        [GRToast makeText:@"请选择施工状态"];
        return;
    }
    if (![self.projectSubmitModel.areaid isNotBlank]) {
        [GRToast makeText:@"请选择片区"];
        return;
    }
    if (![self.projectSubmitModel.belong isNotBlank]) {
        [GRToast makeText:@"请选择责任区县"];
        return;
    }
    if (![self.projectSubmitModel.area isNotBlank]) {
        [GRToast makeText:@"请输入面积"];
        return;
    }
    if (![self.projectSubmitModel.projectno isNotBlank]) {
        [GRToast makeText:@"请输入项目编号"];
        return;
    }
    if (![self.projectSubmitModel.focuson isNotBlank]) {
        [GRToast makeText:@"请选择是否重点项目"];
        return;
    }
    
    
    @weakify(self)
    self.task = [[ZHLZHomeBuildProjectVM sharedInstance] submitHomeBuildProjectSubmitType:self.detailType andSubmitModel:self.projectSubmitModel withBlock:^{
        @strongify(self)
        
        if (self.detailType == 1) {
            [GRToast makeText:@"新增成功"];
        } else {
            [GRToast makeText:@"保存成功"];
        }
        if (self.reloadDataBlock) {
            self.reloadDataBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
