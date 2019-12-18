//
//  ZHLZHomeMunicipalProblemSearchVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMunicipalProblemSearchVC.h"

#import "ZHLZDatePickerVC.h"
#import "ZHLZListPickerViewVC.h"
#import "ZHLZPickerViewVC.h"
#import "ZHLZBrigadePickerViewVC.h"
#import "ZHLZChooseListVC.h"
#import "ZHLZChosseStepVC.h"
#import "ZHLZTransactedPersonPickerViewVC.h"

@interface ZHLZHomeMunicipalProblemSearchVC ()
{
    NSString *_startDateFind;   // 发现开始时间
    NSString *_endDateFind;     // 发现结束时间
    NSString *_startDateClosed; // 关闭开始时间
    NSString *_endDateClosed;   // 关闭结束时间
    NSString *_brigadeType;     // 大队
    NSString *_problemType;     // 问题类型
    NSString *_searchRange;     // 搜索范围
    
    NSString *_responsibleDistrict;     // 责任区县
    NSString *_responsibleUnit;         // 责任单位
    NSString *_supervisoryMeasures;     // 督导措施
    NSString *_problemStatus;           // 问题状态
    NSString *_publicOpinion;           // 舆情
    NSString *_transactedPerson;        // 经办人
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *filterTopView;
@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollView;
@property (weak, nonatomic) IBOutlet UIView *filterBottomView;

@property (weak, nonatomic) IBOutlet UITextField *projectIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *projectDescTextField;
@property (weak, nonatomic) IBOutlet UITextField *roadSectionTextField;

@property (weak, nonatomic) IBOutlet UIButton *startDateFindButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateFindButton;
@property (weak, nonatomic) IBOutlet UIButton *startDateClosedButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateClosedButton;

@property (weak, nonatomic) IBOutlet UIButton *brigadeTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *problemTypeButton;

@property (weak, nonatomic) IBOutlet UIButton *responsibleDistrictButton;
@property (weak, nonatomic) IBOutlet UIButton *responsibleUnitButton;
@property (weak, nonatomic) IBOutlet UIButton *supervisoryMeasuresButton;
@property (weak, nonatomic) IBOutlet UIButton *problemStatusButton;
@property (weak, nonatomic) IBOutlet UIButton *publicOpinionButton;
@property (weak, nonatomic) IBOutlet UIButton *transactedPersonButton;

@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchRangeButton;

@property (nonatomic, strong) ZHLZDatePickerVC *startDateFindDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDateFindDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *startDateClosedDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDateClosedDatePickerVC;

@property (nonatomic, strong) ZHLZBrigadePickerViewVC *brigadePickerViewVC;
@property (nonatomic, strong) ZHLZListPickerViewVC *problemTypeListPickerViewVC;
@property (nonatomic, strong) ZHLZPickerViewVC *searchRangePickerViewVC;

@property (nonatomic, strong) ZHLZListPickerViewVC *responsibleDistrictListPickerViewVC;
@property (nonatomic, strong) ZHLZChooseListVC *responsibleUnitVC;
@property (nonatomic, strong) ZHLZChosseStepVC *supervisoryMeasuresVC;
@property (nonatomic, strong) ZHLZPickerViewVC *problemStatusPickerViewVC;
@property (nonatomic, strong) ZHLZPickerViewVC *publicOpinionPickerViewVC;
@property (nonatomic, strong) ZHLZTransactedPersonPickerViewVC *transactedPersonPickerViewVC;

@end

@implementation ZHLZHomeMunicipalProblemSearchVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterScrollView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
    if ([[ZHLZUserManager sharedInstance] isSuperAdmin]) {
        self.brigadeTypeButton.userInteractionEnabled = YES;
        
        self.brigadeTypeButton.selected = NO;
        
        [self.brigadeTypeButton setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    } else {
        ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
        
        self.brigadeTypeButton.userInteractionEnabled = NO;
        
        self.brigadeTypeButton.selected = YES;
        [self.brigadeTypeButton setTitle:userModel.orgname forState:UIControlStateSelected];
        
        [self.brigadeTypeButton setImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
        
        _brigadeType = userModel.orgId;
    }
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideFilterView)]];
    
    self.startDateFindDatePickerVC = [ZHLZDatePickerVC new];
    self.startDateFindDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_startDateFind = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.startDateFindButton.selected = YES;
            [self.startDateFindButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.endDateFindDatePickerVC = [ZHLZDatePickerVC new];
    self.endDateFindDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_endDateFind = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.endDateFindButton.selected = YES;
            [self.endDateFindButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.startDateClosedDatePickerVC = [ZHLZDatePickerVC new];
    self.startDateClosedDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_startDateClosed = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.startDateClosedButton.selected = YES;
            [self.startDateClosedButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.endDateClosedDatePickerVC = [ZHLZDatePickerVC new];
    self.endDateClosedDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_endDateClosed = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.endDateClosedButton.selected = YES;
            [self.endDateClosedButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.brigadePickerViewVC = [ZHLZBrigadePickerViewVC new];
    self.brigadePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull brigadeType, NSString * _Nonnull brigadeName) {
        @strongify(self);
        self->_brigadeType = brigadeType;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.brigadeTypeButton.selected = YES;
            [self.brigadeTypeButton setTitle:brigadeName forState:UIControlStateSelected];
        });
    };
    
    self.problemTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    self.problemTypeListPickerViewVC.type = 7;
    self.problemTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_problemType = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.problemTypeButton.selected = YES;
            [self.problemTypeButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.searchRangePickerViewVC = [ZHLZPickerViewVC new];
    NSArray *searchRangeArray = @[@"500", @"1000", @"1500", @"2000"];
    self.searchRangePickerViewVC.titleArray = @[@"500米", @"1000米", @"1500米", @"2000米"];
    self.searchRangePickerViewVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        @strongify(self);
        self->_searchRange = searchRangeArray[index];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchRangeButton.selected = YES;
            [self.searchRangeButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.responsibleDistrictListPickerViewVC = [ZHLZListPickerViewVC new];
    self.responsibleDistrictListPickerViewVC.type = 5;
    self.responsibleDistrictListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull areaType, NSString * _Nonnull areaName) {
        @strongify(self);
        self->_responsibleDistrict = areaType;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.responsibleDistrictButton.selected = YES;
            [self.responsibleDistrictButton setTitle:areaName forState:UIControlStateSelected];
        });
    };
    
    self.responsibleUnitVC = [ZHLZChooseListVC new];
    self.responsibleUnitVC.selectIndex = 6;
    self.responsibleUnitVC.selectListBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_responsibleUnit = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.responsibleUnitButton.selected = YES;
            [self.responsibleUnitButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.supervisoryMeasuresVC = [ZHLZChosseStepVC new];
    self.supervisoryMeasuresVC.chooseStepBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_supervisoryMeasures = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.supervisoryMeasuresButton.selected = YES;
            [self.supervisoryMeasuresButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.problemStatusPickerViewVC = [ZHLZPickerViewVC new];
    NSArray *problemStatusArray = @[@"1", @"0"];
    self.problemStatusPickerViewVC.titleArray = @[@"已解决", @"未解决"];
    self.problemStatusPickerViewVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        @strongify(self);
        self->_problemStatus = problemStatusArray[index];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.problemStatusButton.selected = YES;
            [self.problemStatusButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.publicOpinionPickerViewVC = [ZHLZPickerViewVC new];
    NSArray *publicOpinionArray = @[@"1", @"0"];
    self.publicOpinionPickerViewVC.titleArray = @[@"是", @"否"];
    self.publicOpinionPickerViewVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        @strongify(self);
        self->_publicOpinion = publicOpinionArray[index];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.publicOpinionButton.selected = YES;
            [self.publicOpinionButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.transactedPersonPickerViewVC = [ZHLZTransactedPersonPickerViewVC new];
    self.transactedPersonPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_transactedPerson = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.transactedPersonButton.selected = YES;
            [self.transactedPersonButton setTitle:name forState:UIControlStateSelected];
        });
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Action

- (IBAction)startDateFindAction {
    [self presentViewController:self.startDateFindDatePickerVC animated:NO completion:^{
        self.startDateFindDatePickerVC.isLimitMaxDate = YES;
    }];
}

- (IBAction)endDateFindAction {
    [self presentViewController:self.endDateFindDatePickerVC animated:NO completion:^{
        self.endDateFindDatePickerVC.isLimitMaxDate = YES;
    }];
}

- (IBAction)startDateClosedAction {
    [self presentViewController:self.startDateClosedDatePickerVC animated:NO completion:^{
        self.startDateClosedDatePickerVC.isLimitMaxDate = YES;
    }];
}

- (IBAction)endDateClosedAction {
    [self presentViewController:self.endDateClosedDatePickerVC animated:NO completion:^{
        self.endDateClosedDatePickerVC.isLimitMaxDate = YES;
    }];
}

- (IBAction)brigadeAction {
    [self presentViewController:self.brigadePickerViewVC animated:NO completion:nil];
}

- (IBAction)problemTypeAction {
    [self presentViewController:self.problemTypeListPickerViewVC animated:NO completion:nil];
}

- (IBAction)searchRangeAction {
    [self presentViewController:self.searchRangePickerViewVC animated:NO completion:nil];
}

- (IBAction)responsibleDistrictAction {
    [self presentViewController:self.responsibleDistrictListPickerViewVC animated:NO completion:nil];
}

- (IBAction)responsibleUnitAction {
    [self.navigationController pushViewController:self.responsibleUnitVC animated:YES];
}

- (IBAction)supervisoryMeasuresAction {
    [self.navigationController pushViewController:self.supervisoryMeasuresVC animated:YES];
}

- (IBAction)problemStatusAction {
    [self presentViewController:self.problemStatusPickerViewVC animated:NO completion:nil];
}

- (IBAction)publicOpinionAction {
    [self presentViewController:self.publicOpinionPickerViewVC animated:NO completion:nil];
}

- (IBAction)transactedPersonAction {
    [self presentViewController:self.transactedPersonPickerViewVC animated:NO completion:nil];
}

- (IBAction)resetAction {
    self.projectIdTextField.text = @"";
    self.projectDescTextField.text = @"";
    self.roadSectionTextField.text = @"";
    
    self.remarkTextField.text = @"";
    
    _startDateFind = nil;
    self.startDateFindButton.selected = NO;
    _endDateFind = nil;
    self.endDateFindButton.selected = NO;
    _startDateClosed = nil;
    self.startDateClosedButton.selected = NO;
    _endDateClosed = nil;
    self.brigadeTypeButton.selected = NO;
    _brigadeType = nil;
    self.endDateClosedButton.selected = NO;
    _problemType = nil;
    self.problemTypeButton.selected = NO;
    _searchRange = nil;
    self.searchRangeButton.selected = NO;
    
    _responsibleDistrict = nil;
    self.responsibleDistrictButton.selected = NO;
    _responsibleUnit = nil;
    self.responsibleUnitButton.selected = NO;
    _supervisoryMeasures = nil;
    self.supervisoryMeasuresButton.selected = NO;
    _problemStatus = nil;
    self.problemStatusButton.selected = NO;
    _publicOpinion = nil;
    self.publicOpinionButton.selected = NO;
    _transactedPerson = nil;
    self.transactedPersonButton.selected = NO;
}

- (IBAction)determineAction {
    ZHLZHomeMunicipalProblemSearchModel *model = [ZHLZHomeMunicipalProblemSearchModel new];
    model.objectID = [self.projectIdTextField.text isNotBlank] ? self.projectIdTextField.text : nil;
    model.problemDet = [self.projectDescTextField.text isNotBlank] ? self.projectDescTextField.text : nil;
    model.siteDet = [self.roadSectionTextField.text isNotBlank] ? self.roadSectionTextField.text : nil;
    model.problemType = _problemType;
    model.orgid = _brigadeType;
    model.rangeleg = _searchRange;
    model.startDate = _startDateFind;
    model.endDate = _endDateFind;
    model.cstartdate = _startDateClosed;
    model.cenddate = _endDateClosed;
    
    model.contentDet = [self.remarkTextField.text isNotBlank] ? self.remarkTextField.text : nil;
    
    model.belong = _responsibleDistrict;
    model.responsibleUnitName = _responsibleUnit;
    model.ddssjtms = _supervisoryMeasures;
    model.problemStatus = _problemStatus;
    model.islyrical = _publicOpinion;
    model.createuser = _transactedPerson;

    if (self.selectSearchBlock) {
        self.selectSearchBlock(model);
    }
    [self hideFilterView];
}

#pragma mark - Public

- (void)showFilterView {
    self.maskView.hidden = NO;
    
    [self filterAnimation:NO];
}

- (void)hideFilterView {
    [self filterAnimation:YES];
    
    [self performSelector:@selector(hideMaskView) withObject:nil afterDelay:PopAnimationDurationConst];
}

#pragma mark - Private

- (void)filterAnimation:(BOOL)isHidden {
    self.filterTopView.hidden = isHidden;
    self.filterScrollView.hidden = isHidden;
    self.filterBottomView.hidden = isHidden;
    
    CATransition *animation = [CATransition animation];
    // 设置动画的类型
    animation.type = kCATransitionPush;
    // 设置动画的方向
    animation.subtype = isHidden ? kCATransitionFromLeft : kCATransitionFromRight;
    animation.duration = PopAnimationDurationConst;
    [self.filterTopView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterScrollView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterBottomView.layer addAnimation:animation forKey:@"pushAnimation"];
}

- (void)hideMaskView {
    self.maskView.hidden = YES;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
