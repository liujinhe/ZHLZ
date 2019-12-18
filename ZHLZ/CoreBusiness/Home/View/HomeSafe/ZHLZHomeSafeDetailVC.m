//
//  ZHLZHomeSafeDetailVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeDetailVC.h"
#import "ZHLZHomeSafeVM.h"
#import "ZHLZBrigadePickerViewVC.h"
#import "ZHLZSafeSubmitModel.h"
#import "ZHLZChooseListVC.h"

#import "GRUploadPhotoView.h"
#import "ZHLZUploadVM.h"
#import "ZHLZMonadVC.h"

@interface ZHLZHomeSafeDetailVC () <GRUploadPhotoViewDelegate>
{
    NSArray<UIImage *> *_photoArray;
    NSArray<NSString *> *_imgExtArray;
}

@property (weak, nonatomic) IBOutlet UIButton *bigGrouponButton;
@property (weak, nonatomic) IBOutlet UITextField *locationTextFile;

@property (weak, nonatomic) IBOutlet UIButton *dutyUnitButton;

@property (weak, nonatomic) IBOutlet ZHLZTextView *problemTextView;
@property (weak, nonatomic) IBOutlet ZHLZTextView *lookHistoryTextView;

@property (weak, nonatomic) IBOutlet ZHLZTextView *workTypeTextView;

@property (weak, nonatomic) IBOutlet UITextField *photoNumTextFile;

@property (weak, nonatomic) IBOutlet UIView *uploadPicView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uploadPicViewHeight;

@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;

@property (weak, nonatomic) IBOutlet UIButton *dutyContentButton;


@property (nonatomic , strong) ZHLZHomeSafeModel *safeDetailModel;

@property (nonatomic , strong) ZHLZSafeSubmitModel *safeSubmitModel;



@end

@implementation ZHLZHomeSafeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHomeSafeDetailView];
}

- (void)loadDetailData{
    self.task = [[ZHLZHomeSafeVM sharedInstance] loadHomeSafeDataId:self.detailId WithBlock:^(ZHLZHomeSafeModel * _Nonnull homeSafeModel) {
        
        self.safeDetailModel = homeSafeModel;
        
        //查看显示数据的大队
        if (self.type == 2) {
            [self.bigGrouponButton setTitle:self.safeDetailModel.orgName forState:UIControlStateNormal];
        }
        
        self.locationTextFile.text = self.safeDetailModel.currentPlace;
        [self.dutyUnitButton setTitle:self.safeDetailModel.unitName forState:UIControlStateNormal];
        
        self.problemTextView.text = self.safeDetailModel.prodescription;
        self.lookHistoryTextView.text = self.safeDetailModel.workRecord;
        self.workTypeTextView.text = self.safeDetailModel.workMeasures;
        self.photoNumTextFile.text = self.safeDetailModel.photoNumber;
        
        ///回选值
        self.safeSubmitModel.unitId = self.safeDetailModel.unitId;
        self.safeSubmitModel.currentPlace = self.safeDetailModel.currentPlace;
        self.safeSubmitModel.prodescription = self.safeDetailModel.prodescription;
        self.safeSubmitModel.workRecord = self.safeDetailModel.workRecord;
        self.safeSubmitModel.photoNumber = self.safeDetailModel.photoNumber;
        self.safeSubmitModel.workMeasures = self.safeDetailModel.workMeasures;
        self.safeSubmitModel.id = self.safeDetailModel.objectID;
        self.safeSubmitModel.uploadId = self.safeDetailModel.uploadId;
        
        [self addUploadPicActionWithImgURL:self.safeDetailModel.imgurl];
    }];
}

- (void)addUploadPicActionWithImgURL:(NSString *)imgURL {
//    @weakify(self);
    [self.uploadPicView removeAllSubviews];
    
    GRUploadPhotoView *uploadPhotoView = [[GRUploadPhotoView alloc] initWithParentView:self.uploadPicView
                                                                    withViewController:self
                                                                    withMaxImagesCount:9
                                                                            withImgURL:imgURL withImgType:self.type];

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
        if (self.type == 2) {
            self.uploadPicViewHeight.constant = kAutoFitReal(0);
        } else {
            self.uploadPicViewHeight.constant = kAutoFitReal(105);
        }
    }
}

- (void)editAction {
    ZHLZHomeSafeDetailVC *safeDetailVC = [ZHLZHomeSafeDetailVC new];
    safeDetailVC.type = 3;
    safeDetailVC.detailId = [NSString stringWithFormat:@"%@",self.safeDetailModel.objectID];
    safeDetailVC.reloadDataBlock = ^{
        [self loadDetailData];
    };
    [self.navigationController pushViewController:safeDetailVC animated:YES];
}

- (void)initHomeSafeDetailView {
    _photoArray = @[].mutableCopy;
    _imgExtArray = @[].mutableCopy;
    
    self.dutyContentButton.hidden = YES;
    
    if (self.type == 1) {
        self.title = @"新增安全(三防)台账";
        [self.submitButton setTitle:@"确认添加" forState:UIControlStateNormal];
        
        [self addUploadPicActionWithImgURL:nil];
    } else if (self.type == 2){
        self.title = @"查看安全(三防)台账";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        self.submitButton.hidden = YES;
        
        [self loadDetailData];
        
        [self isLookControl];
        
    } else {
        self.title = @"编辑安全(三防)台账";
        [self.submitButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [self loadDetailData];
    }
    
    self.problemTextView.placeholder = @"请输入问题描述";
    self.lookHistoryTextView.placeholder = @"请输入责任单位采取的工作措施";
    self.workTypeTextView.placeholder = @"请输入巡查监管工作记录";
    
    self.safeSubmitModel = [ZHLZSafeSubmitModel new];
    
    self.bigGrouponButton.userInteractionEnabled = NO;
    
    //编辑和新增默认选中当前用户所在大队
    if (self.type == 1 || self.type == 3) {
        ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
        [self.bigGrouponButton setTitle:userModel.orgname forState:UIControlStateNormal];
        //初始值
        self.safeSubmitModel.orgId  = userModel.orgId;
    }
}

- (void)isLookControl{
    
    self.dutyContentButton.hidden = NO;
    self.dutyUnitButton.backgroundColor = [UIColor whiteColor];
    
    
    self.locationTextFile.userInteractionEnabled = NO;
    
//    self.dutyUnitButton.userInteractionEnabled = NO;
    
    [self.problemTextView setEditable:NO];
    [self.lookHistoryTextView setEditable:NO];
    [self.workTypeTextView setEditable:NO];
    
    self.photoNumTextFile.userInteractionEnabled = NO;
    
}


- (IBAction)bigGrouponAction:(UIButton *)sender {
    ///大队不能选择
}

- (IBAction)dutyUnitAction:(UIButton *)sender {
    
    if (self.type == 2) {
        ZHLZMonadVC *monadVC = [ZHLZMonadVC new];
        monadVC.setType = 2;
        monadVC.detailId = self.safeSubmitModel.unitId;
        monadVC.reloadDataBlock = ^{
            
        };
        [self.navigationController pushViewController:monadVC animated:YES];
        
    } else {
        ZHLZChooseListVC *chooseListVC = [ZHLZChooseListVC new];
        chooseListVC.selectIndex = 6;
        @weakify(self)
        chooseListVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
            @strongify(self)
            
            self.safeSubmitModel.unitId = code;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dutyUnitButton setTitle:name forState:UIControlStateNormal];
            });
        };
        [self.navigationController pushViewController:chooseListVC animated:YES];
    }
}

- (IBAction)SubmitAction:(UIButton *)sender {
    self.safeSubmitModel.currentPlace = self.locationTextFile.text;
    self.safeSubmitModel.prodescription = self.problemTextView.text;
    self.safeSubmitModel.workRecord = self.lookHistoryTextView.text;
    self.safeSubmitModel.photoNumber = self.photoNumTextFile.text;
    self.safeSubmitModel.workMeasures = self.workTypeTextView.text;
    
        if (![self.safeSubmitModel.currentPlace isNotBlank]) {
            [GRToast makeText:@"请输入所在位置"];
            return;
        }
        if (![self.safeSubmitModel.unitId isNotBlank]) {
            [GRToast makeText:@"请选择责任单位"];
            return;
        }
        if (![self.safeSubmitModel.prodescription isNotBlank]) {
            [GRToast makeText:@"请输入问题描述"];
            return;
        }
        if (![self.safeSubmitModel.workRecord isNotBlank]) {
            [GRToast makeText:@"请输入巡查监管记录"];
            return;
        }
        if (![self.safeSubmitModel.workMeasures isNotBlank]) {
            [GRToast makeText:@"请输入工作措施"];
            return;
        }
    
    if (_photoArray.count > 0) {
        @weakify(self);
        ZHLZUploadVM *uploadVM = [ZHLZUploadVM sharedInstance];
        NSString *uploadId = @"";
        if (self.type == 1) {
            uploadId = [uploadVM random:16];
        } else {
            if ([self.safeSubmitModel.uploadId isNotBlank]) {
                 uploadId = self.safeSubmitModel.uploadId;
            } else {
                uploadId = [uploadVM random:16];
            }
        }
        [uploadVM uploadImageArray:_photoArray withUploadId:uploadId withBlock:^{
            self.safeSubmitModel.uploadId = uploadId;
            @strongify(self)
            [self submitAction];
        }];
    } else {
        [self submitAction];
    }
}

- (void)submitAction {
    @weakify(self)
    self.task = [[ZHLZHomeSafeVM sharedInstance] submitHomeSafeWithSubmitType:self.type andSubmitModel:self.safeSubmitModel withBlock:^{
        @strongify(self)
        if (self.type == 1) {
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
