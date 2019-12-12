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
#import "ZHLZSupervisorSubmitModel.h"

#import "GRUploadPhotoView.h"
#import "ZHLZUploadVM.h"

@interface ZHLZHomeSafeProblemDetailVC () <GRUploadPhotoViewDelegate>
{
    NSArray<UIImage *> *_photoArray;
    NSArray<NSString *> *_imgExtArray;
}

@property (weak, nonatomic) IBOutlet UIButton *homeSafeButton;
@property (weak, nonatomic) IBOutlet UIButton *areaNameButton;
@property (weak, nonatomic) IBOutlet UIButton *dutyAreaButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *workUserButton;

@property (weak, nonatomic) IBOutlet ZHLZTextView *problemDetailTextView;
@property (weak, nonatomic) IBOutlet ZHLZTextView *problemMarkTextView;

@property (weak, nonatomic) IBOutlet UIView *uploadPicView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadPicViewHeight;


@property (weak, nonatomic) IBOutlet ZHLZButton *problemSubmitButton;


///督导措施
@property (weak, nonatomic) IBOutlet UIButton *supervisorButton;
@property (weak, nonatomic) IBOutlet UIView *supervisorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *supervisorViewHeightConstraint;



@property (nonatomic , strong) ZHLZHomeSafeProblemModel *homeSafeProblemModel;

@property (nonatomic , strong) ZHLZHomeSafeProblemSUbmitModel *homeSafeProblemSUbmitModel;

///督导措施
@property (nonatomic , strong) NSMutableArray <ZHLZSupervisorSubmitModel *> *supervisorSubmitModelArray;

@end

@implementation ZHLZHomeSafeProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSafeProblemDetailView];
}

- (void)editAction {
    ZHLZHomeSafeProblemDetailVC *safeProblemDetailVC = [ZHLZHomeSafeProblemDetailVC new];
    safeProblemDetailVC.type = 3;
    safeProblemDetailVC.detailId = [NSString stringWithFormat:@"%@",self.homeSafeProblemModel.objectID];
    safeProblemDetailVC.reloadDataBlock = ^{
        
        [self.supervisorSubmitModelArray removeAllObjects];
        
        [self getProblemDetailData];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
        
    };
    [self.navigationController pushViewController:safeProblemDetailVC animated:YES];
}


- (void)loadHomeSafeFloodPreventionProblemGetMeasures {
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeFloodPreventionProblemGetMeasuresWithId:self.detailId withType:3 Block:^(NSArray<ZHLZSupervisorSubmitModel *> * _Nonnull supervisorSubmitModelArray) {
        [self.supervisorSubmitModelArray addObjectsFromArray:supervisorSubmitModelArray];
        
        [self safeProbleCreateSupervisorView];
    }];
}

- (void)getProblemDetailData{
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeSafeProblemModel * _Nonnull homeSafeProblem) {
        self.homeSafeProblemModel = homeSafeProblem;
        
        [self.homeSafeButton setTitle:homeSafeProblem.risksid forState:UIControlStateNormal];
        
        //片区名称
        NSString *orgnameString = [ZHLZUserManager sharedInstance].user.orgname;
        NSInteger areaid = [homeSafeProblem.areaid integerValue];
        
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
        [self.areaNameButton setTitle:areaString forState:UIControlStateNormal];
        
        [self.dutyAreaButton setTitle:homeSafeProblem.belongname forState:UIControlStateNormal];
        
        [self.problemTimeButton setTitle:homeSafeProblem.finddate forState:UIControlStateNormal];
        
        [self.workUserButton setTitle:homeSafeProblem.promanagername forState:UIControlStateNormal];
        
        self.problemDetailTextView.text = homeSafeProblem.remark;
        self.problemMarkTextView.text = homeSafeProblem.prodescription;
        
        ///编辑回选
        if (self.type == 3) {
            self.homeSafeProblemSUbmitModel.risksid = homeSafeProblem.risksid;
            self.homeSafeProblemSUbmitModel.areaid = homeSafeProblem.areaid;
            self.homeSafeProblemSUbmitModel.belong = homeSafeProblem.belong;
            self.homeSafeProblemSUbmitModel.finddate = homeSafeProblem.finddate;
            self.homeSafeProblemSUbmitModel.ddssjtms = homeSafeProblem.ddssjtms;
            self.homeSafeProblemSUbmitModel.uploadid = homeSafeProblem.uploadId;
            self.homeSafeProblemSUbmitModel.id = homeSafeProblem.objectID;
            
        }
        
        [self addUploadPicActionWithImgURL:homeSafeProblem.imgurl];
    }];
}

- (void)addUploadPicActionWithImgURL:(NSString *)imgURL {
//    @weakify(self);
    GRUploadPhotoView *uploadPhotoView = [[GRUploadPhotoView alloc] initWithParentView:self.uploadPicView
                                                                    withViewController:self
                                                                    withMaxImagesCount:9
                                                                            withImgURL:imgURL];
    uploadPhotoView.optionType = self.type;
    uploadPhotoView.delegate = self;
//    uploadPhotoView.delegateDataBlock = ^(NSString * _Nonnull imgURL) {
//        @strongify(self);
//    };
    [self.uploadPicView addSubview:uploadPhotoView];

    NSArray *array = [imgURL componentsSeparatedByString:@","];
    if (array && array.count > 0) {
        CGFloat height = kAutoFitReal(105) * (array.count / 3 + (array.count % 3 > 0 ? 1 : 0)) + ItemMargin * array.count / 3;
        self.uploadPicViewHeight.constant = height;
    } else {
        self.uploadPicViewHeight.constant = kAutoFitReal(105);
    }
}

- (void)initSafeProblemDetailView {
    _photoArray = @[].mutableCopy;
    _imgExtArray = @[].mutableCopy;
    
    self.uploadPicView.backgroundColor = [UIColor clearColor];
    
    if (self.type == 1) {
        self.title = @"新增安全(三防)问题";
        [self.problemSubmitButton setTitle:@"确定添加" forState:UIControlStateNormal];
        
        [self addUploadPicActionWithImgURL:nil];
    } else if (self.type == 2) {
        self.title = @"查看安全(三防)问题";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        [self getProblemDetailData];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
        
        [self lookSetView];
    } else {
        self.title = @"编辑安全(三防)问题";
        [self.problemSubmitButton setTitle:@"确定修改" forState:UIControlStateNormal];
        
        [self getProblemDetailData];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
    }
    
    self.problemDetailTextView.placeholder = @"请输入问题描述";
    self.problemMarkTextView.placeholder = @"请输入备注";
    
    self.supervisorView.backgroundColor = [UIColor clearColor];
    self.supervisorViewHeightConstraint.constant = 0;
    
    self.supervisorSubmitModelArray = [NSMutableArray <ZHLZSupervisorSubmitModel *> new];
    
    self.homeSafeProblemSUbmitModel = [ZHLZHomeSafeProblemSUbmitModel new];
    [self.workUserButton setTitle:[ZHLZUserManager sharedInstance].user.fullname forState:UIControlStateNormal];
    
    self.homeSafeProblemSUbmitModel.promanager = [ZHLZUserManager sharedInstance].user.userId;
    self.homeSafeProblemSUbmitModel.orgid = [ZHLZUserManager sharedInstance].user.orgId;
    
}

- (void)lookSetView {
    self.homeSafeButton.userInteractionEnabled = NO;
    self.areaNameButton.userInteractionEnabled = NO;
    self.dutyAreaButton.userInteractionEnabled = NO;
    self.problemTimeButton.userInteractionEnabled = NO;
    self.workUserButton.userInteractionEnabled = NO;
    
    self.supervisorButton.userInteractionEnabled = NO;
    self.problemSubmitButton.hidden = YES;
    
    [self.problemDetailTextView setEditable:NO];
    [self.problemMarkTextView setEditable:NO];
}


///台账id
- (IBAction)homeSafeAction:(UIButton *)sender {
    ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
    chooseListVC.selectIndex = 7;
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
    @weakify(self)
    addCouncilorVC.addCouncilorBlock = ^(ZHLZSupervisorSubmitModel * _Nonnull supervisorSubmitModel) {
        @strongify(self)
        if (supervisorSubmitModel) {
            [self.supervisorSubmitModelArray addObject:supervisorSubmitModel];
            
            [self safeProbleCreateSupervisorView];
        }
    };
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}

- (IBAction)problemSubmitAction:(ZHLZButton *)sender {
    
    self.homeSafeProblemSUbmitModel.prodescription = self.problemDetailTextView.text;
    self.homeSafeProblemSUbmitModel.remark = self.problemMarkTextView.text;
    self.homeSafeProblemSUbmitModel.uploadid = @"";
    ///默认值回选
    if (self.type == 1) {
        self.homeSafeProblemSUbmitModel.ddssjtms = [self setddssjtms];
        self.homeSafeProblemSUbmitModel.id = @"";
    }
    
    if (![self.homeSafeProblemSUbmitModel.risksid isNotBlank]) {
        [GRToast makeText:@"请选择台账"];
        return;
    }
    if (![self.homeSafeProblemSUbmitModel.belong isNotBlank]) {
        [GRToast makeText:@"请选择所属区县"];
        return;
    }
    if (![self.homeSafeProblemSUbmitModel.areaid isNotBlank]) {
        [GRToast makeText:@"请选择片区"];
        return;
    }
    if (![self.homeSafeProblemSUbmitModel.finddate isNotBlank]) {
        [GRToast makeText:@"问题发现时间"];
        return;
    }
    
    
    if (_photoArray.count > 0) {
        @weakify(self);
        ZHLZUploadVM *uploadVM = [ZHLZUploadVM sharedInstance];
        NSString *uploadId = @"";
        if (self.type == 1) {
            uploadId = [uploadVM random:16];
        } else {
            if ([self.homeSafeProblemSUbmitModel.uploadid isNotBlank]) {
                uploadId = self.homeSafeProblemSUbmitModel.uploadid;
            } else {
                uploadId = [uploadVM random:16];
            }
        }
        [uploadVM uploadImageArray:_photoArray withUploadId:uploadId withBlock:^{
            self.homeSafeProblemSUbmitModel.uploadid = uploadId;
            @strongify(self)
            [self submitAction];
        }];
    } else {
        [self submitAction];
    }
}

- (void)submitAction {
    @weakify(self)
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] submitHomeSafeProblemWithSubmitType:self.type andSubmitArray:@[self.homeSafeProblemSUbmitModel, self.supervisorSubmitModelArray] withBlock:^{
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

- (void)safeProbleCreateSupervisorView {
    
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
        [self safeProbleCreateSupervisorView];
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

@end
