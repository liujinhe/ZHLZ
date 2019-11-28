//
//  ZHLZHomeMunicipalProblemDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMunicipalProblemDetailVC.h"
#import "ZHLZHomeSafeProblemVM.h"
#import "ZHLZHomeMunicipalProblemVM.h"
#import "ZHLZAddCouncilorVC.h"
#import "ZHLZHomeMunicipalProblemSubmitModel.h"
#import "ZHLZPickerViewVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZListPickerViewVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZChooseListVC.h"


@interface ZHLZHomeMunicipalProblemDetailVC ()

@property (weak, nonatomic) IBOutlet UIButton *orgButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UIButton *dutyAreaButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *problemClassifyButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *dutyUnitButton;
@property (weak, nonatomic) IBOutlet UIButton *workPeopleButton;
@property (weak, nonatomic) IBOutlet UITextField *conentPhoneTextFile;
@property (weak, nonatomic) IBOutlet UITextField *fineMoneyTextFule;
@property (weak, nonatomic) IBOutlet UIButton *superiorButton;
@property (weak, nonatomic) IBOutlet UITextField *problemTagTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextView *problemDescTextView;





///督导
@property (weak, nonatomic) IBOutlet ZHLZTextView *supervisorView;
@property (weak, nonatomic) IBOutlet UIButton *supervisorButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *supervisorViewHeightConstraint;

@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;

///督导措施
@property (nonatomic , strong) NSMutableArray <ZHLZSupervisorSubmitModel *> *supervisorSubmitModelArray;

@property (nonatomic , strong) ZHLZHomeMunicipalProblemSubmitModel *municipalProblemSubmitModel;

@end

@implementation ZHLZHomeMunicipalProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMunicipalProblemDetailView];
}

- (void)editAction {
    ZHLZHomeMunicipalProblemDetailVC *municipalProblemDetailVC = [ZHLZHomeMunicipalProblemDetailVC new];
    municipalProblemDetailVC.type = 3;
    municipalProblemDetailVC.detailId = self.detailId;
    [self.navigationController pushViewController:municipalProblemDetailVC animated:YES];
}

- (void)initMunicipalProblemDetailView {
    
    self.supervisorSubmitModelArray = [NSMutableArray <ZHLZSupervisorSubmitModel *> new];
    self.municipalProblemSubmitModel = [ZHLZHomeMunicipalProblemSubmitModel new];
    
    if (self.type == 1) {
        self.navTitle = @"新增市政设施";
    }
    
    else if (self.type == 2) {
        self.navTitle = @"市政设施详情";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        [self loadMunicipalProblemDetailData];
    }
    
    else if (self.type == 3) {
        self.navTitle = @"编辑市政设施";
        
        [self loadMunicipalProblemDetailData];
    }
    
}

- (void)loadMunicipalProblemDetailData {
    @weakify(self)
    self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] loadHomeMunicipalProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeMunicipalProblemModel * _Nonnull municipalProblemModel) {
        
        @strongify(self)
        ///赋值
        
        
        
        
        ///初始值赋值
        
    }];
}

- (void)loadHomeSafeFloodPreventionProblemGetMeasures {
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeFloodPreventionProblemGetMeasuresWithId:self.detailId withType:2 Block:^(NSArray<ZHLZSupervisorSubmitModel *> * _Nonnull supervisorSubmitModelArray) {
        [self.supervisorSubmitModelArray addObjectsFromArray:supervisorSubmitModelArray];
        
        [self municipalProblemCreateSupervisorView];
    }];
}

///片区名称
- (IBAction)areaAction:(UIButton *)sender {
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
//        [self.areaNameButton setTitle:name forState:UIControlStateNormal];
        
        if ([orgnameString isEqualToString:@"五大队"]) {
            if (index == 0) {
//                self.homeSafeProblemSUbmitModel.areaid = @"4";
            }
        } else {
            if (index == 0) {
//                self.homeSafeProblemSUbmitModel.areaid = @"3";
            } else if (index == 1) {
//                self.homeSafeProblemSUbmitModel.areaid = @"4";
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
            
//            self.homeSafeProblemSUbmitModel.belong = code;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dutyAreaButton setTitle:name forState:UIControlStateNormal];
            });
        };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
}

///问题类型
- (IBAction)problemTypeAction:(UIButton *)sender {
    ZHLZListPickerViewVC *problemTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    problemTypeListPickerViewVC.type = 7;
    @weakify(self)
    problemTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
//        self.homeOccupyProblemSubmitModel.protype = code;

        dispatch_async(dispatch_get_main_queue(), ^{
//            self.problemTypeButton.selected = YES;
//            [self.problemTypeButton setTitle:name forState:UIControlStateSelected];
        });
    };
    [self presentViewController:problemTypeListPickerViewVC animated:NO completion:nil];
}

///问题分类内容
- (IBAction)problemClassifyAction:(UIButton *)sender {
    
}

///发现问题时间
- (IBAction)problemTimeAction:(id)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
//            self.homeSafeProblemSUbmitModel.finddate = date;
//            [self.problemTimeButton setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}

///责任单位
- (IBAction)dutyUnitAction:(UIButton *)sender {
    ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
    chooseListVC.selectIndex = 6;
    @weakify(self)
    chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self)
        
//        self.safeSubmitModel.unitId = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.dutyUnitButton setTitle:name forState:UIControlStateNormal];
        });
    };
    [self.navigationController pushViewController:chooseListVC animated:YES];
}

///上级交办
- (IBAction)superiorAction:(UIButton *)sender {
    ZHLZListPickerViewVC *problemTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    problemTypeListPickerViewVC.type = 6;
    @weakify(self)
    problemTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
    //        self.homeOccupyProblemSubmitModel.protype = code;

        dispatch_async(dispatch_get_main_queue(), ^{
    //            self.problemTypeButton.selected = YES;
    //            [self.problemTypeButton setTitle:name forState:UIControlStateSelected];
        });
    };
    [self presentViewController:problemTypeListPickerViewVC animated:NO completion:nil];
}


///新增督导
- (IBAction)supervisorAction:(UIButton *)sender {
    ZHLZAddCouncilorVC *addCouncilorVC = [ZHLZAddCouncilorVC new];
    @weakify(self)
    addCouncilorVC.addCouncilorBlock = ^(ZHLZSupervisorSubmitModel * _Nonnull supervisorSubmitModel) {
        @strongify(self)
        if (supervisorSubmitModel) {
            [self.supervisorSubmitModelArray addObject:supervisorSubmitModel];
            
            [self municipalProblemCreateSupervisorView];
        }
    };
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}


///提交
- (IBAction)submitAction:(ZHLZButton *)sender {
    @weakify(self)
    self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] submitHomeMunicipalProblemWithSubmitArray:@[] andSubmitType:self.type withBlock:^{
        
        @strongify(self)
        
        
        
    }];
    
}


- (void)municipalProblemCreateSupervisorView {

    for (UIView *view in [self.supervisorView subviews]) {
        [view removeFromSuperview];
    }
    self.supervisorViewHeightConstraint.constant = 0;
    
    CGFloat allHeight = 0;
    for (int i = 0 ; i < self.supervisorSubmitModelArray.count ; i ++) {
        
        ZHLZSupervisorSubmitModel *supervisorSubmitModel = self.supervisorSubmitModelArray[i];
        
        UIView *listView = [UIView new];
        listView.backgroundColor = [UIColor whiteColor];
        listView.layer.cornerRadius = 5.0f;
        [self.supervisorView addSubview:listView];
        
        CGFloat rightMargin = 0;
        if (self.type == 2) {
            rightMargin = 5;
        } else {
            rightMargin = 10 + 30 + 5;
        }
        
        CGFloat height = [self getString:supervisorSubmitModel.meCustomize lineSpacing:5 font:kFont(14) width:kScreenWidth - 20 - 5 - rightMargin];
        
        if (height < 50) {
            height = 60;
        } else {
            height = height + 10;
        }
        
        [listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.supervisorView).offset(allHeight);
            make.left.right.equalTo(self.supervisorView);
            make.height.offset(height);
        }];
        
        allHeight = allHeight + height + 10;
        
        if (self.type != 2 ) {
            UIButton *deteteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            deteteButton.backgroundColor = [UIColor clearColor];
            [deteteButton setImage:[UIImage imageNamed:@"icon_delete_black"] forState:UIControlStateNormal];
            deteteButton.tag = i;
            [deteteButton addTarget:self action:@selector(deteteAction:) forControlEvents:UIControlEventTouchUpInside];
            [listView addSubview:deteteButton];
            [deteteButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(listView.mas_right).offset(-10);
                make.centerY.offset(listView.centerY);
                make.height.width.offset(30);
            }];
        }
        
        UILabel *textLable = [UILabel new];
        textLable.font = kFont(14);
        textLable.lineBreakMode = NSLineBreakByWordWrapping;
        textLable.numberOfLines = 0;
        textLable.textColor = kHexRGB(0x999999);
        textLable.text = supervisorSubmitModel.meCustomize;
        [listView addSubview:textLable];
        [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(listView.mas_left).offset(5);
            make.top.equalTo(listView.mas_top).offset(5);
            make.bottom.equalTo(listView.mas_bottom).offset(-5);
            if (self.type == 2) {
                make.right.equalTo(listView.mas_right).offset(-5);
            } else {
                make.right.equalTo(listView.mas_right).offset(-45);
            }
        }];
    }
    
    self.supervisorViewHeightConstraint.constant = allHeight;
}

- (CGFloat)getString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.height);
}

- (void)deteteAction:(UIButton *)btn {
    NSInteger index = btn.tag;
    @weakify(self);
    [self popActionWithTip:@"是否删除此措施？" withBlock:^{
        @strongify(self);
        [self.supervisorSubmitModelArray removeObjectAtIndex:index];
        [self municipalProblemCreateSupervisorView];
    }];
}



@end
