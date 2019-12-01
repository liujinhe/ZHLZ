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
#import "ZHLZSupervisorSubmitModel.h"
#import "ZHLZHomeOccupyProblemSubmitModel.h"
#import "ZHLZHomeSafeProblemVM.h"

#import "GRUploadPhotoView.h"

@interface ZHLZHomeOccupyProblemDetailVC () <GRUploadPhotoViewDelegate>
{
    NSArray<NSString *> *_photoArray;
    NSArray<NSString *> *_imgExtArray;
}

@property (weak, nonatomic) IBOutlet UIButton *projectNameButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTimeButtotn;
@property (weak, nonatomic) IBOutlet UIButton *workPoeopleButton;
@property (weak, nonatomic) IBOutlet UIButton *supervisorButton;

@property (weak, nonatomic) IBOutlet ZHLZTextView *problemTextView;
@property (weak, nonatomic) IBOutlet ZHLZTextView *markTextView;

@property (weak, nonatomic) IBOutlet UIView *uploadPicView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadPicViewHeight;

@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;

///督导列表
@property (weak, nonatomic) IBOutlet UIView *supervisorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *supervisorViewHeightConstraint;

@property (nonatomic , strong) NSMutableArray <ZHLZSupervisorSubmitModel *> *supervisorSubmitModelArray;///督导数组

@property (nonatomic , strong) ZHLZHomeOccupyProblemSubmitModel *homeOccupyProblemSubmitModel;

@end

@implementation ZHLZHomeOccupyProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self occupyProblemDetailView];
}

- (void)lookoccupyProblemDetail {
    self.projectNameButton.userInteractionEnabled = NO;
    self.problemTypeButton.userInteractionEnabled = NO;
    self.areaButton.userInteractionEnabled = NO;
    self.problemTimeButtotn.userInteractionEnabled = NO;
    self.workPoeopleButton.userInteractionEnabled = NO;
    self.supervisorButton.userInteractionEnabled = NO;
    
//    self.projectNameButton.backgroundColor = [UIColor whiteColor];
//    self.problemTypeButton.backgroundColor = [UIColor whiteColor];
//    self.areaButton.backgroundColor = [UIColor whiteColor];
//    self.problemTimeButtotn.backgroundColor = [UIColor whiteColor];
//    self.workPoeopleButton.backgroundColor = [UIColor whiteColor];
//    self.supervisorButton.backgroundColor = [UIColor whiteColor];
    
    [self.problemTextView setEditable:NO];
    [self.markTextView setEditable:NO];
    
}

- (void)occupyProblemDetailView {
    _photoArray = @[].mutableCopy;
    _imgExtArray = @[].mutableCopy;
    
    self.uploadPicViewHeight.constant = kAutoFitReal(105);
    
    GRUploadPhotoView *uploadPhotoView = [[GRUploadPhotoView alloc] initWithParentView:self.uploadPicView withViewController:self withMaxImagesCount:9];
    uploadPhotoView.delegate = self;
    [self.uploadPicView addSubview:uploadPhotoView];
    
    self.problemTextView.placeholder = @"请输入问题描述";
    self.markTextView.placeholder = @"请输入备注";
    
    self.supervisorView.backgroundColor = [UIColor clearColor];
    self.supervisorViewHeightConstraint.constant = 0;
    
    self.supervisorSubmitModelArray = [NSMutableArray <ZHLZSupervisorSubmitModel *> new];
    self.homeOccupyProblemSubmitModel = [ZHLZHomeOccupyProblemSubmitModel new];
    
    ///新增和编辑经办人
    if (self.type != 2) {
        [self.workPoeopleButton setTitle:[ZHLZUserManager sharedInstance].user.fullname forState:UIControlStateNormal];
        self.homeOccupyProblemSubmitModel.promanager = [ZHLZUserManager sharedInstance].user.userId;
        self.homeOccupyProblemSubmitModel.orgid = [ZHLZUserManager sharedInstance].user.orgId;
    }
    
    
    
    if (self.type == 1) {
        self.navTitle = @"新增占道施工";
        [self.submitButton setTitle:@"确认保存" forState:UIControlStateNormal];
    }
    
    else if (self.type == 2) {
        self.navTitle = @"占道施工详情";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        self.submitButton.hidden = YES;
        
        ///设置不可编辑
        [self lookoccupyProblemDetail];
        
        [self loadOccupyProblemDetail];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
    }
    
    else if (self.type == 3) {
        self.navTitle = @"编辑占道施工详情";
        [self.submitButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
        [self loadOccupyProblemDetail];
        
        [self loadHomeSafeFloodPreventionProblemGetMeasures];
    }
    
    
    
}

- (void)loadHomeSafeFloodPreventionProblemGetMeasures {
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeFloodPreventionProblemGetMeasuresWithId:self.detailId withType:1 Block:^(NSArray<ZHLZSupervisorSubmitModel *> * _Nonnull supervisorSubmitModelArray) {
        [self.supervisorSubmitModelArray addObjectsFromArray:supervisorSubmitModelArray];
        
        [self createSupervisorView];
    }];
}


- (void)loadOccupyProblemDetail {
    self.task = [[ZHLZHomeOccupyProblemVM sharedInstance] loadHomeOccupyProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeOccupyProblemDetailModel * _Nonnull occupyProblemDetailModel) {
        
        [self.projectNameButton setTitle:occupyProblemDetailModel.projectname forState:UIControlStateNormal];
        
        [self.problemTypeButton setTitle:occupyProblemDetailModel.protypename forState:UIControlStateNormal];
        
        [self.areaButton setTitle:occupyProblemDetailModel.belongname forState:UIControlStateNormal];
        
        [self.problemTimeButtotn setTitle:occupyProblemDetailModel.prodate forState:UIControlStateNormal];
        
        [self.workPoeopleButton setTitle:occupyProblemDetailModel.promanagername forState:UIControlStateNormal];
        
        self.problemTextView.text = occupyProblemDetailModel.prodescription;
        
        self.markTextView.text = occupyProblemDetailModel.responsibleUnit;
        
        //设置默认选中值
        if (self.type == 3) {
            self.homeOccupyProblemSubmitModel.projectid = occupyProblemDetailModel.projectid;
            self.homeOccupyProblemSubmitModel.projectname = occupyProblemDetailModel.protypename;
            
            self.homeOccupyProblemSubmitModel.protype = occupyProblemDetailModel.protype;
            self.homeOccupyProblemSubmitModel.proid = occupyProblemDetailModel.proid;
            
            self.homeOccupyProblemSubmitModel.belong = occupyProblemDetailModel.belong;
            
            self.homeOccupyProblemSubmitModel.areaid = occupyProblemDetailModel.areaid;
            
            self.homeOccupyProblemSubmitModel.prodate = occupyProblemDetailModel.prodate;
            
            self.homeOccupyProblemSubmitModel.promanager = [ZHLZUserManager sharedInstance].user.userId;
            
            self.homeOccupyProblemSubmitModel.ddssjtms = occupyProblemDetailModel.ddssjtms;
            
            self.homeOccupyProblemSubmitModel.label = occupyProblemDetailModel.label;
            
            self.homeOccupyProblemSubmitModel.uploadid = occupyProblemDetailModel.uploadId;
            
            self.homeOccupyProblemSubmitModel.prodescription = occupyProblemDetailModel.prodescription;
            self.homeOccupyProblemSubmitModel.responsibleUnit = occupyProblemDetailModel.responsibleUnit;
        }

        
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
    chooseListVC.selectBuildProjectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name, NSString * _Nonnull areaid) {
        
       @strongify(self)
        self.homeOccupyProblemSubmitModel.projectid = code;
        self.homeOccupyProblemSubmitModel.projectname = name;
        
        self.homeOccupyProblemSubmitModel.areaid = areaid;
        
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
        self.homeOccupyProblemSubmitModel.protype = code;

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.problemTypeButton setTitle:name forState:UIControlStateNormal];
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
        
        self.homeOccupyProblemSubmitModel.belong= code;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.areaButton setTitle:name forState:UIControlStateNormal];
        });
    };
    [self presentViewController:projectTypePickerViewVC animated:NO completion:nil];
}

///问题时间
- (IBAction)problemTimeAction:(UIButton *)sender {
    ZHLZDatePickerVC *datePickerVC = [ZHLZDatePickerVC new];
    datePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        if (date) {
            self.homeOccupyProblemSubmitModel.prodate= date;
            [self.problemTimeButtotn setTitle:date forState:UIControlStateNormal];
        }
    };
    [self presentViewController:datePickerVC animated:NO completion:nil];
}

///经办人
- (IBAction)workPeopleAction:(UIButton *)sender {
    ///不需更换
}

///督导
- (IBAction)supervisorAction:(UIButton *)sender {
    ZHLZAddCouncilorVC *addCouncilorVC = [ZHLZAddCouncilorVC new];
    @weakify(self)
    addCouncilorVC.addCouncilorBlock = ^(ZHLZSupervisorSubmitModel * _Nonnull supervisorSubmitModel) {
        @strongify(self)
        if (supervisorSubmitModel) {
            [self.supervisorSubmitModelArray addObject:supervisorSubmitModel];

            [self createSupervisorView];
        }
    };
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}

///修改提交
- (IBAction)submitAction:(ZHLZButton *)sender {
    
    self.homeOccupyProblemSubmitModel.prodescription = self.problemTextView.text;
    self.homeOccupyProblemSubmitModel.responsibleUnit = self.markTextView.text;
    self.homeOccupyProblemSubmitModel.uploadid = @"";
    self.homeOccupyProblemSubmitModel.label = @"";
    if (self.type == 1) {
        self.homeOccupyProblemSubmitModel.ddssjtms = [self setddssjtms];
        self.homeOccupyProblemSubmitModel.proid  = @"";
    }
    
    
    
    @weakify(self)
    self.task = [[ZHLZHomeOccupyProblemVM sharedInstance]submitHomeSafeProblemWithSubmitArray:@[self.homeOccupyProblemSubmitModel , self.supervisorSubmitModelArray] andSubmitType:self.type withBlock:^{
        @strongify(self)
        if (self.type == 1) {
            [GRToast makeText:@"新增成功"];
        } else {
            [GRToast makeText:@"修改成功"];
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

- (void)createSupervisorView {

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
        
        if (self.type == 3 || self.type == 1) {
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
        [self createSupervisorView];
    }];
}

#pragma mark - GRUploadPhotoViewDelegate

- (void)selectedWithPhotoArray:(NSArray<NSString *> *)photoArray withImgExtArray:(NSArray<NSString *> *)imgExtArray withParentView:(UIView *)parentView {
    _photoArray = photoArray;
    _imgExtArray = imgExtArray;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.uploadPicViewHeight.constant = CGRectGetHeight(parentView.frame);
        [self updateViewConstraints];
    });
}

@end
