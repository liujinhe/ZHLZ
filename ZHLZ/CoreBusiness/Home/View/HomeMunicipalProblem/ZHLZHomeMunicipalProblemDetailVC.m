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
#import "ZHLZRoadMaintenancePickerViewVC.h"
#import "ZHLZMonadVC.h"

#import "GRUploadPhotoView.h"
#import "ZHLZUploadVM.h"
#import <UShareUI/UShareUI.h>

@interface ZHLZHomeMunicipalProblemDetailVC () <GRUploadPhotoViewDelegate>
{
    NSArray<UIImage *> *_photoArray;
    NSArray<NSString *> *_imgExtArray;
    ZHLZHomeMunicipalProblemModel *_municipalProblemModel;
}

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

@property (weak, nonatomic) IBOutlet UILabel *locationX;
@property (weak, nonatomic) IBOutlet UILabel *locationY;

@property (weak, nonatomic) IBOutlet ZHLZTextView *locationTextView;
@property (weak, nonatomic) IBOutlet ZHLZTextView *markTextView;


@property (weak, nonatomic) IBOutlet UIView *classifyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *classifyViewHeightConstraint;

///问题分类
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *problemClassifyViewHeight;


///督导
@property (weak, nonatomic) IBOutlet UIButton *supervisorButton;
@property (weak, nonatomic) IBOutlet UIView *supervisorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *supervisorViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *uploadPicView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadPicViewHeight;

@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;

@property (weak, nonatomic) IBOutlet UIButton *dutyContentButton;


///描述分类
@property (nonatomic , strong) NSMutableArray  *problemClassifyArray;

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
    municipalProblemDetailVC.reloadDataBlock = ^{
        
        [self.supervisorSubmitModelArray removeAllObjects];
        
        [self loadMunicipalProblemDetailData];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
    };
    [self.navigationController pushViewController:municipalProblemDetailVC animated:YES];
}

- (void)municipalProblemLook {
    
    self.dutyContentButton.hidden = NO;
    self.dutyUnitButton.backgroundColor = [UIColor whiteColor];
    
    self.orgButton.userInteractionEnabled = NO;
    self.areaButton.userInteractionEnabled = NO;
    self.dutyAreaButton.userInteractionEnabled = NO;
    self.problemTypeButton.userInteractionEnabled = NO;
    self.problemClassifyButton.userInteractionEnabled = NO;
    self.problemTimeButton.userInteractionEnabled = NO;
    //    self.dutyUnitButton.userInteractionEnabled = NO;
    self.workPeopleButton.userInteractionEnabled = NO;
    self.conentPhoneTextFile.userInteractionEnabled = NO;
    self.superiorButton.userInteractionEnabled = NO;
    self.problemTagTextFile.userInteractionEnabled = NO;
    self.fineMoneyTextFule.userInteractionEnabled = NO;
    self.supervisorButton.userInteractionEnabled = NO;
    
    
    [self.problemDescTextView setEditable:NO];
    [self.locationTextView setEditable:NO];
    [self.markTextView setEditable:NO];
}

- (void)initMunicipalProblemDetailView {
    if (self.type == 2) {
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                                   @(UMSocialPlatformType_WechatTimeLine),
                                                   @(UMSocialPlatformType_WechatFavorite)]];
        [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatSession
                                         withPlatformIcon:[UIImage imageNamed:@"icon_wechat_friend"]
                                         withPlatformName:@"微信好友"];
        [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatTimeLine
                                         withPlatformIcon:[UIImage imageNamed:@"icon_wechat_friend_circle"]
                                         withPlatformName:@"微信朋友圈"];
        [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatFavorite
                                         withPlatformIcon:[UIImage imageNamed:@"icon_wechat_collection"]
                                         withPlatformName:@"微信收藏"];
    }
    
    _photoArray = @[].mutableCopy;
    _imgExtArray = @[].mutableCopy;
    
    self.uploadPicView.backgroundColor = [UIColor clearColor];
    
    self.problemClassifyArray = [NSMutableArray new];
    self.supervisorSubmitModelArray = [NSMutableArray <ZHLZSupervisorSubmitModel *> new];
    self.municipalProblemSubmitModel = [ZHLZHomeMunicipalProblemSubmitModel new];
    
    self.classifyView.backgroundColor = [UIColor clearColor];
    self.classifyViewHeightConstraint.constant = 0;
    
    self.supervisorView.backgroundColor = [UIColor clearColor];
    self.supervisorViewHeightConstraint.constant = 0;
    
    
    self.problemDescTextView.placeholder = @"请输入问题描述";
    self.locationTextView.placeholder = @"请输入地点描述";
    self.markTextView.placeholder = @"请输入备注";
    
    self.dutyContentButton.hidden = YES;
    
    if (self.type == 1) {
        self.navTitle = @"新增市政设施";
        [self.submitButton setTitle:@"确认新增" forState:UIControlStateNormal];
        
        [self addUploadPicActionWithImgURL:nil];
    }
    
    else if (self.type == 2) {
        self.navTitle = @"市政设施详情";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        [self.submitButton setTitle:@"分享" forState:UIControlStateNormal];
        
        [self municipalProblemLook];
        
        [self loadMunicipalProblemDetailData];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
    }
    
    else if (self.type == 3) {
        self.navTitle = @"编辑市政设施";
        [self.submitButton setTitle:@"确认保存" forState:UIControlStateNormal];
        
        [self loadMunicipalProblemDetailData];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
    }
    
    if (self.type != 2) {
        [self.orgButton setTitle:[ZHLZUserManager sharedInstance].user.orgname forState:UIControlStateNormal];
        self.municipalProblemSubmitModel.orgid = [ZHLZUserManager sharedInstance].user.orgId;
        
        self.municipalProblemSubmitModel.createuser = [ZHLZUserManager sharedInstance].user.userId;
        
        [self.workPeopleButton setTitle:[ZHLZUserManager sharedInstance].user.fullname forState:UIControlStateNormal];
        
        NSDictionary *coordinate = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentLocationCoordinateConst];
        
        if (coordinate) {
            self.locationX.text = [NSString stringWithFormat:@"经度：%@",[coordinate objectForKey:@"longitude"]];
            self.locationY.text = [NSString stringWithFormat:@"纬度：%@",[coordinate objectForKey:@"latitude"]];
        }
    }
    
}

- (void)loadMunicipalProblemDetailData {
    @weakify(self)
    self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] loadHomeMunicipalProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeMunicipalProblemModel * _Nonnull municipalProblemModel) {
        
        @strongify(self)
        self->_municipalProblemModel = municipalProblemModel;
        
        ///赋值
        [self.orgButton setTitle:municipalProblemModel.orgname forState:UIControlStateNormal];
        
        
        //片区名称
        [self.areaButton setTitle:municipalProblemModel.areaname forState:UIControlStateNormal];
        
        ///责任区县
        [self.dutyAreaButton setTitle:municipalProblemModel.belongname forState:UIControlStateNormal];
        
        ///选择问题类型
        [self.problemTypeButton setTitle:municipalProblemModel.problemType forState:UIControlStateNormal];
        
        ///问题时间
        [self.problemTimeButton setTitle:municipalProblemModel.finddate forState:UIControlStateNormal];
        
        ///责任单位
        [self.dutyUnitButton setTitle:municipalProblemModel.responsibleUnitName forState:UIControlStateNormal];
        
        ///经办人
        [self.workPeopleButton setTitle:municipalProblemModel.fullname forState:UIControlStateNormal];
        
        self.conentPhoneTextFile.text = municipalProblemModel.contactNumber;
        
        self.fineMoneyTextFule.text =municipalProblemModel.fine;
        
        ///舆情
        [self.superiorButton setTitle:municipalProblemModel.islyricalname forState:UIControlStateNormal];
        
        ///问题标签
        //        self.problemTagTextFile.text = municipalProblemModel.problemDet
        
        ///问题描述
        self.problemDescTextView.text = municipalProblemModel.problemDet;
        
        if (self.type == 2) {
            self.locationX.text = [NSString stringWithFormat:@"经度：%@",municipalProblemModel.latX];
            self.locationY.text = [NSString stringWithFormat:@"纬度：%@",municipalProblemModel.lonY];
        }
        
        self.locationTextView.text = municipalProblemModel.siteDet;
        self.markTextView.text = municipalProblemModel.contentDet;
        
        
        self.municipalProblemSubmitModel.areaid = municipalProblemModel.areaid;
        self.municipalProblemSubmitModel.belong = municipalProblemModel.belong;
        self.municipalProblemSubmitModel.problemType = municipalProblemModel.problemType;
        
        self.municipalProblemSubmitModel.finddate = municipalProblemModel.finddate;
        self.municipalProblemSubmitModel.responsibleUnit = municipalProblemModel.responsibleUnit;
        self.municipalProblemSubmitModel.islyrical = municipalProblemModel.islyrical;
        self.municipalProblemSubmitModel.id = municipalProblemModel.objectID;
        self.municipalProblemSubmitModel.ddssjtms = municipalProblemModel.ddssjtms;
        self.municipalProblemSubmitModel.uploadid = municipalProblemModel.uploadId;
        
        [self addUploadPicActionWithImgURL:municipalProblemModel.imgurl];
    }];
}

- (void)addUploadPicActionWithImgURL:(NSString *)imgURL {
    
    [self.uploadPicView removeAllSubviews];
    
    GRUploadPhotoView *uploadPhotoView = [[GRUploadPhotoView alloc] initWithParentView:self.uploadPicView
                                                                    withViewController:self
                                                                    withMaxImagesCount:9
                                                                            withImgURL:imgURL withImgType:self.type];
    uploadPhotoView.delegate = self;
    
    [self.uploadPicView addSubview:uploadPhotoView];
    
    NSArray *array = [imgURL componentsSeparatedByString:@","];
    if (array && array.count > 0) {
        CGFloat height = kAutoFitReal(105) * (array.count / 3 + (array.count % 3 > 0 ? 1 : 0)) + ItemMargin * array.count / 3;
        self.uploadPicViewHeight.constant = height;
    } else {
        if (self.type == 2) {
            self.uploadPicViewHeight.constant = kAutoFitReal(0);
        } else {
            self.uploadPicViewHeight.constant = kAutoFitReal(105);
        }
    }
}

- (void)loadHomeSafeFloodPreventionProblemGetMeasures {
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeFloodPreventionProblemGetMeasuresWithId:self.detailId withType:2 Block:^(NSArray<ZHLZSupervisorSubmitModel *> * _Nonnull supervisorSubmitModelArray) {
        [self.supervisorSubmitModelArray addObjectsFromArray:supervisorSubmitModelArray];
        [self.supervisorSubmitModelArray removeAllObjects];
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (ZHLZSupervisorSubmitModel *model in supervisorSubmitModelArray) {
            if (![dic objectForKey:model.uuid]) {
                [dic setValue:model.uuid forKey:model.uuid];
                [self.supervisorSubmitModelArray addObject:model];
            }
        }
        
        [self municipalProblemCreateSupervisorViewWithType:1];
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
        [self.areaButton setTitle:name forState:UIControlStateNormal];
        
        if ([orgnameString isEqualToString:@"五大队"]) {
            if (index == 0) {
                self.municipalProblemSubmitModel.areaid = @"4";
            }
        } else {
            if (index == 0) {
                self.municipalProblemSubmitModel.areaid = @"3";
            } else if (index == 1) {
                self.municipalProblemSubmitModel.areaid = @"4";
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
        
        self.municipalProblemSubmitModel.belong = code;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dutyAreaButton setTitle:name forState:UIControlStateNormal];
        });
    };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
}

///问题类型
- (IBAction)problemTypeAction:(UIButton *)sender {
    ZHLZListPickerViewVC *problemTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    problemTypeListPickerViewVC.type = 8;
    @weakify(self)
    problemTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self.municipalProblemSubmitModel.problemType = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.problemTypeButton setTitle:name forState:UIControlStateNormal];
        });
    };
    [self presentViewController:problemTypeListPickerViewVC animated:NO completion:nil];
}

///问题分类内容
- (IBAction)problemClassifyAction:(UIButton *)sender {
    
    if (![self.municipalProblemSubmitModel.problemType isNotBlank]) {
        [GRToast makeText:@"请先选择问题类型"];
        return;
    }
    
    if ([self.municipalProblemSubmitModel.problemType isEqualToString:@"道路养护及附属设施维护"]) {
        
        ZHLZRoadMaintenancePickerViewVC *roadMaintenancePickerViewVC = [ZHLZRoadMaintenancePickerViewVC new];
        roadMaintenancePickerViewVC.selectPickerBlock = ^(NSArray * _Nonnull valueArray, NSArray * _Nonnull nameArray) {
            
            NSMutableString *string = [NSMutableString new];
            for (int i = 0 ; i < nameArray.count ; i++) {
                [string appendFormat:@"%@/",nameArray[i]];
            }
            [self.problemClassifyArray addObject:string];
            
            NSMutableString *problemDescString = [NSMutableString new];
            for (int i = 0; i < self.problemClassifyArray.count; i++) {
                [problemDescString appendFormat:@"%@\n\n",self.problemClassifyArray[i]];
                if ([problemDescString isNotBlank]) {
                    NSRange itemStringRange = {[problemDescString length] - 1, 1};
                    [problemDescString deleteCharactersInRange:itemStringRange];
                }
            }
            self.problemDescTextView.text = problemDescString;
            
            
            [self municipalProblemCreateSupervisorViewWithType:2];
        };
        [self presentViewController:roadMaintenancePickerViewVC animated:NO completion:nil];
        
    } else {
        [GRToast makeText:@"没有选项"];
        return;
    }
}

///发现问题时间
- (IBAction)problemTimeAction:(id)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            self.municipalProblemSubmitModel.finddate = date;
            [self.problemTimeButton setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}

///责任单位
- (IBAction)dutyUnitAction:(UIButton *)sender {
    
    if (self.type == 2) {
        ZHLZMonadVC *monadVC = [ZHLZMonadVC new];
        monadVC.setType = 2;
        monadVC.detailId = self.municipalProblemSubmitModel.responsibleUnit;
        monadVC.reloadDataBlock = ^{
            
        };
        [self.navigationController pushViewController:monadVC animated:YES];
        
    } else {
        ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
        chooseListVC.selectIndex = 6;
        @weakify(self)
        chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
            @strongify(self)
            
            self.municipalProblemSubmitModel.responsibleUnit = code;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dutyUnitButton setTitle:name forState:UIControlStateNormal];
            });
        };
        [self.navigationController pushViewController:chooseListVC animated:YES];
    }
    
}

///上级交办
- (IBAction)superiorAction:(UIButton *)sender {
    ZHLZListPickerViewVC *problemTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    problemTypeListPickerViewVC.type = 6;
    @weakify(self)
    problemTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self.municipalProblemSubmitModel.islyrical = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.superiorButton setTitle:name forState:UIControlStateNormal];
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
            
            [self municipalProblemCreateSupervisorViewWithType:1];
        }
    };
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}


///提交
- (IBAction)submitAction:(ZHLZButton *)sender {
    @weakify(self);
    // 分享
    if (self.type == 2) {
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            @strongify(self)
            [self shareWebPageToPlatformType:platformType];
        }];
        return;
    }
    
    self.municipalProblemSubmitModel.problemDet = self.problemDescTextView.text;
    self.municipalProblemSubmitModel.siteDet = self.locationTextView.text;
    self.municipalProblemSubmitModel.contentDet = self.markTextView.text;
    
    self.municipalProblemSubmitModel.contactNumber = self.conentPhoneTextFile.text;
    self.municipalProblemSubmitModel.label = self.problemTagTextFile.text;
    
    self.municipalProblemSubmitModel.classAndContent = @"";
    self.municipalProblemSubmitModel.fine = self.fineMoneyTextFule.text;
    
    if (![self.municipalProblemSubmitModel.islyrical isNotBlank]) {
        self.municipalProblemSubmitModel.islyrical = @"0";
    }
    
    NSDictionary *coordinate = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentLocationCoordinateConst];
    if (coordinate) {
        self.municipalProblemSubmitModel.latX = [coordinate objectForKey:@"longitude"];
        self.municipalProblemSubmitModel.lonY = [coordinate objectForKey:@"latitude"];
    } else {
        self.municipalProblemSubmitModel.latX = @"";
        self.municipalProblemSubmitModel.lonY = @"";
    }
    
    if (self.type == 1) {
        self.municipalProblemSubmitModel.id = @"";
        self.municipalProblemSubmitModel.uploadid = @"";
        self.municipalProblemSubmitModel.ddssjtms = [self setddssjtms];
    }
    
    
    
    if (![self.municipalProblemSubmitModel.areaid isNotBlank]) {
        [GRToast makeText:@"请选择片区"];
        return;
    }
    if (![self.municipalProblemSubmitModel.belong isNotBlank]) {
        [GRToast makeText:@"请选择所属区县"];
        return;
    }
    if (![self.municipalProblemSubmitModel.problemType isNotBlank]) {
        [GRToast makeText:@"请选择问题类型"];
        return;
    }
    if (![self.municipalProblemSubmitModel.responsibleUnit isNotBlank]) {
        [GRToast makeText:@"请选择责任单位"];
        return;
    }
    if (![self.municipalProblemSubmitModel.finddate isNotBlank]) {
        [GRToast makeText:@"请选择问题发现时间"];
        return;
    }
    if (![self.municipalProblemSubmitModel.problemDet isNotBlank]) {
        [GRToast makeText:@"请输入问题描述"];
        return;
    }
    if (![self.municipalProblemSubmitModel.siteDet isNotBlank]) {
        [GRToast makeText:@"请输入地点描述"];
        return;
    }
    
    ZHLZUploadVM *uploadVM = [ZHLZUploadVM sharedInstance];
    NSString *uploadId = @"";
    if ([self.municipalProblemSubmitModel.uploadid isNotBlank]) {
        uploadId = self.municipalProblemSubmitModel.uploadid;
    } else {
        uploadId = [uploadVM random:16];
    }
    self.municipalProblemSubmitModel.uploadid = uploadId;
    
    if (_photoArray.count > 0) {
        [uploadVM uploadImageArray:_photoArray withUploadId:uploadId withBlock:^{
            @strongify(self)
            [self submitAction];
        }];
    } else {
        [self submitAction];
    }
}

- (void)submitAction {
    @weakify(self)
    self.task = [[ZHLZHomeMunicipalProblemVM sharedInstance] submitHomeMunicipalProblemWithSubmitArray:@[self.municipalProblemSubmitModel , self.supervisorSubmitModelArray] andSubmitType:self.type withBlock:^{
        @strongify(self)
        if (self.type == 1) {
            [GRToast makeText:@"新增成功"];
        } else {
            [GRToast makeText:@"修改成功"];
        }
        
        if (self.reloadDataBlock) {
            self.reloadDataBlock();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSString *)setddssjtms {
    
    NSMutableString *ddssjtmsString = [NSMutableString new];
    for (int i = 0 ; i < self.supervisorSubmitModelArray.count; i ++) {
        ZHLZSupervisorSubmitModel *supervisorSubmitModel = self.supervisorSubmitModelArray[i];
        [ddssjtmsString appendFormat:@"%@；",supervisorSubmitModel.meCustomize];
    }
    if ([ddssjtmsString isNotBlank]) {
        NSRange ddssjtmsStringRange = {[ddssjtmsString length] - 1, 1};
        [ddssjtmsString deleteCharactersInRange:ddssjtmsStringRange];
    }
    return ddssjtmsString;
}

- (void)municipalProblemCreateSupervisorViewWithType:(NSInteger)viewType {
    
    if (viewType == 1) {
        for (UIView *view in [self.supervisorView subviews]) {
            [view removeFromSuperview];
        }
        self.supervisorViewHeightConstraint.constant = 0;
    } else {
        for (UIView *view in [self.classifyView subviews]) {
            [view removeFromSuperview];
        }
        self.classifyViewHeightConstraint.constant = 0;
    }
    
    CGFloat allHeight = 0;
    NSInteger arrayCount = 0;
    if (viewType == 1) {
        arrayCount = self.supervisorSubmitModelArray.count;
    } else {
        arrayCount = self.problemClassifyArray.count;
    }
    for (int i = 0 ; i < arrayCount ; i ++) {
        ZHLZSupervisorSubmitModel *supervisorSubmitModel = [ZHLZSupervisorSubmitModel new];
        if (viewType == 1) {
            supervisorSubmitModel = self.supervisorSubmitModelArray[i];
        }
        
        
        UIView *listView = [UIView new];
        listView.backgroundColor = [UIColor whiteColor];
        listView.layer.cornerRadius = 5.0f;
        if (viewType == 1) {
            [self.supervisorView addSubview:listView];
        } else {
            [self.classifyView addSubview:listView];
        }
        
        
        CGFloat rightMargin = 0;
        if (self.type == 2) {
            rightMargin = 5;
        } else {
            rightMargin = 10 + 30 + 5;
        }
        
        NSString *contentString = @"";
        if (viewType == 1) {
            contentString = supervisorSubmitModel.meCustomize;
        } else {
            contentString = self.problemClassifyArray[i];
        }
        
        CGFloat height = [self getString:contentString lineSpacing:5 font:kFont(14) width:kScreenWidth - 40 - 5 - rightMargin];
        
        if (height < 50) {
            height = 60;
        } else {
            height = height + 10;
        }
        
        if (viewType == 1) {
            [listView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.supervisorView).offset(allHeight);
                make.left.right.equalTo(self.supervisorView);
                make.height.offset(height);
            }];
        } else {
            [listView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.classifyView).offset(allHeight);
                make.left.right.equalTo(self.classifyView);
                make.height.offset(height);
            }];
        }
        
        
        allHeight = allHeight + height + 10;
        
        if (self.type != 2 ) {
            UIButton *deteteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            deteteButton.backgroundColor = [UIColor clearColor];
            [deteteButton setImage:[UIImage imageNamed:@"icon_delete_black"] forState:UIControlStateNormal];
            deteteButton.tag = i;
            if (viewType == 1) {
                [deteteButton addTarget:self action:@selector(deteteAction:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [deteteButton addTarget:self action:@selector(deteteclassifyViewAction:) forControlEvents:UIControlEventTouchUpInside];
            }
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
        
        if (viewType == 1) {
            textLable.text = supervisorSubmitModel.meCustomize;
        } else {
            NSMutableString *itemString = [NSMutableString new];
            itemString = self.problemClassifyArray[i];
            if ([itemString isNotBlank]) {
                NSRange itemStringRange = {[itemString length] - 1, 1};
                [itemString deleteCharactersInRange:itemStringRange];
            }
            textLable.text = itemString;
        }
        
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
    if (viewType == 1) {
        self.supervisorViewHeightConstraint.constant = allHeight;
    } else {
        self.classifyViewHeightConstraint.constant = allHeight;
    }
    
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
        [self municipalProblemCreateSupervisorViewWithType:1];
    }];
}

- (void)deteteclassifyViewAction:(UIButton *)btn {
    NSInteger index = btn.tag;
    @weakify(self);
    [self popActionWithTip:@"是否删除此问题分类及内容？" withBlock:^{
        @strongify(self);
        [self.problemClassifyArray removeObjectAtIndex:index];
        [self municipalProblemCreateSupervisorViewWithType:2];
    }];
}

#pragma mark - GRUploadPhotoViewDelegate

- (void)selectedWithPhotoArray:(NSArray<UIImage *> *)photoArray withImgExtArray:(NSArray<NSString *> *)imgExtArray withParentView:(UIView *)parentView {
    _photoArray = photoArray;
    _imgExtArray = imgExtArray;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.uploadPicViewHeight.constant = CGRectGetHeight(parentView.frame);
        [self updateViewConstraints];
    });
}

#pragma mark - Share

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    if (!_municipalProblemModel) {
        return;
    }
    
    ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
    if (!userModel) {
        return;
    }
    
    NSString *title = _municipalProblemModel.problemType;
    NSString *descr = [NSString stringWithFormat:@"%@在%@发现%@，请%@跟进处理。",
                       [NSString formatterWithDate:[NSDate formatterDateWithTimeString:_municipalProblemModel.finddate]],
                       _municipalProblemModel.siteDet,
                       _municipalProblemModel.problemDet,
                       _municipalProblemModel.responsibleUnitName];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:[UIImage imageNamed:@"logo"]];
    shareObject.webpageUrl = kShareURL(BaseAPIURLConst, _municipalProblemModel.objectID, [NSString formatterWithDate:[NSDate date]], userModel.fullname);
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = title;
    messageObject.text = descr;
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            [GRToast makeText:@"分享失败"];
            return;
        }
        
        [GRToast makeText:@"分享成功"];
    }];
}

@end
