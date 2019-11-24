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

@interface ZHLZHomeSafeDetailVC ()

@property (weak, nonatomic) IBOutlet UIButton *bigGrouponButton;
@property (weak, nonatomic) IBOutlet UITextField *locationTextFile;

@property (weak, nonatomic) IBOutlet UIButton *dutyUnitButton;

@property (weak, nonatomic) IBOutlet ZHLZTextView *problemTextView;
@property (weak, nonatomic) IBOutlet ZHLZTextView *lookHistoryTextView;

@property (weak, nonatomic) IBOutlet ZHLZTextView *workTypeTextView;

@property (weak, nonatomic) IBOutlet UITextField *photoNumTextFile;


@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;

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
        
        [self.bigGrouponButton setTitle:self.safeDetailModel.orgName forState:UIControlStateNormal];
        self.locationTextFile.text = self.safeDetailModel.currentPlace;
        [self.dutyUnitButton setTitle:self.safeDetailModel.unitName forState:UIControlStateNormal];
       
        self.problemTextView.text = self.safeDetailModel.prodescription;
        self.lookHistoryTextView.text = self.safeDetailModel.workRecord;
        self.workTypeTextView.text = self.safeDetailModel.workMeasures;
        self.photoNumTextFile.text = self.safeDetailModel.photoNumber;
    }];
}

- (void)editAction {
    ZHLZHomeSafeDetailVC *safeDetailVC = [ZHLZHomeSafeDetailVC new];
    safeDetailVC.type = 3;
    safeDetailVC.detailId = [NSString stringWithFormat:@"%@",self.safeDetailModel.objectID];
    [self.navigationController pushViewController:safeDetailVC animated:YES];
}

- (void)initHomeSafeDetailView {
    if (self.type == 1) {
        self.title = @"新增安全(三防)台账";
        [self.submitButton setTitle:@"确认添加" forState:UIControlStateNormal];
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
    
    self.safeSubmitModel = [ZHLZSafeSubmitModel new];
    
}

- (void)isLookControl{
    self.bigGrouponButton.userInteractionEnabled = NO;
    self.locationTextFile.userInteractionEnabled = NO;
    self.dutyUnitButton.userInteractionEnabled = NO;
    
    self.bigGrouponButton.backgroundColor = [UIColor whiteColor];
    self.dutyUnitButton.backgroundColor = [UIColor whiteColor];
    
    [self.problemTextView setEditable:NO];
    [self.lookHistoryTextView setEditable:NO];
    [self.workTypeTextView setEditable:NO];
    self.photoNumTextFile.userInteractionEnabled = NO;
    
}


- (IBAction)bigGrouponAction:(UIButton *)sender {
    ZHLZBrigadePickerViewVC *brigadePickerViewVC = [ZHLZBrigadePickerViewVC new];
    @weakify(self)
    brigadePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull brigadeType, NSString * _Nonnull brigadeName) {
        @strongify(self);
        
//        self->_bid = brigadeType;
        self.safeSubmitModel.orgName = brigadeName;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.bigGrouponButton setTitle:brigadeName forState:UIControlStateNormal];
        });
    };
    [self presentViewController:brigadePickerViewVC animated:NO completion:nil];
}

- (IBAction)dutyUnitAction:(UIButton *)sender {
    
}

- (IBAction)SubmitAction:(UIButton *)sender {
    
    self.safeSubmitModel.currentPlace = self.locationTextFile.text;
    self.safeSubmitModel.prodescription = self.problemTextView.text;
    self.safeSubmitModel.workRecord = self.lookHistoryTextView.text;
    self.safeSubmitModel.unitId = @"123";
    self.safeSubmitModel.photoNumber = self.photoNumTextFile.text;
    self.safeSubmitModel.workMeasures = self.workTypeTextView.text;
    
    
    if (![self.safeSubmitModel.orgName isNotBlank]) {
        [GRToast makeText:@"请选择负责大队"];
        return;
    }

    if (![self.safeSubmitModel.currentPlace isNotBlank]) {
        [GRToast makeText:@"请输入所在位置"];
        return;
    }
    @weakify(self)
    self.task = [[ZHLZHomeSafeVM sharedInstance] submitHomeSafeWithSubmitType:self.type andSubmitModel:self.safeSubmitModel withBlock:^{
        @strongify(self)
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    

}

@end
