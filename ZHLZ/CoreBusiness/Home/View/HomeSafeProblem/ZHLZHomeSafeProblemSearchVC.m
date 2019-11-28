//
//  ZHLZHomeSafeProblemSearchVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemSearchVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZBrigadePickerViewVC.h"
#import "ZHLZListPickerViewVC.h"

@interface ZHLZHomeSafeProblemSearchVC ()
{
    NSString *_startDateFind;
    NSString *_endDateFind;
    NSString *_startDateClosed;
    NSString *_endDateClosed;
    
    NSString *_brigadeType;
    NSString *_responsibilityDistrict;
    NSString *_problemStatus;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *filterTopView;
@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollView;
@property (weak, nonatomic) IBOutlet UIView *filterBottomView;

@property (weak, nonatomic) IBOutlet UITextField *problemIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *safeIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *problemDescTextField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
@property (weak, nonatomic) IBOutlet UITextField *throughHandlerTextField;

@property (weak, nonatomic) IBOutlet UIButton *startDateFindButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateFindButton;
@property (weak, nonatomic) IBOutlet UIButton *startDateClosedButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateClosedButton;

@property (weak, nonatomic) IBOutlet UIButton *brigadeTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *responsibilityDistrictButton;
@property (weak, nonatomic) IBOutlet UIButton *problemStatusButton;

@property (nonatomic, strong) ZHLZDatePickerVC *startDateFindDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDateFindDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *startDateClosedDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDateClosedDatePickerVC;

@property (nonatomic, strong) ZHLZBrigadePickerViewVC *brigadePickerViewVC;
@property (nonatomic, strong) ZHLZListPickerViewVC *responsibilityDistrictListPickerViewVC;
@property (nonatomic, strong) ZHLZListPickerViewVC *problemStatusPickerViewVC;

@end

@implementation ZHLZHomeSafeProblemSearchVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterScrollView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
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
    
    self.responsibilityDistrictListPickerViewVC = [ZHLZListPickerViewVC new];
    self.responsibilityDistrictListPickerViewVC.type = 5;
    self.responsibilityDistrictListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_responsibilityDistrict = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.responsibilityDistrictButton.selected = YES;
            [self.responsibilityDistrictButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.problemStatusPickerViewVC = [ZHLZListPickerViewVC new];
    self.problemStatusPickerViewVC.type = 7;
    self.problemStatusPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_problemStatus = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.problemStatusButton.selected = YES;
            [self.problemStatusButton setTitle:name forState:UIControlStateSelected];
        });
    };
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

- (IBAction)responsibilityDistrictAction {
    [self presentViewController:self.responsibilityDistrictListPickerViewVC animated:NO completion:nil];
}

- (IBAction)problemStatusAction {
    [self presentViewController:self.problemStatusPickerViewVC animated:NO completion:nil];
}

- (IBAction)resetAction {
    self.problemIdTextField.text = @"";
    self.safeIdTextField.text = @"";
    self.problemDescTextField.text = @"";
    self.remarkTextField.text = @"";
    self.throughHandlerTextField.text = @"";
    
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
    _responsibilityDistrict = nil;
    self.responsibilityDistrictButton.selected = NO;
    _problemStatus = nil;
    self.problemStatusButton.selected = NO;
}

- (IBAction)determineAction {
    ZHLZHomeSafeProblemSearchModel *model = [ZHLZHomeSafeProblemSearchModel new];
    model.objectID = [self.problemIdTextField.text isNotBlank] ? self.problemIdTextField.text : nil;
    model.risksid = [self.safeIdTextField.text isNotBlank] ? self.safeIdTextField.text : nil;
    model.prodescription = [self.problemDescTextField.text isNotBlank] ? self.problemDescTextField.text : nil;
    model.remark = [self.remarkTextField.text isNotBlank] ? self.remarkTextField.text : nil;
    model.promanager = [self.throughHandlerTextField.text isNotBlank] ? self.throughHandlerTextField.text : nil;
    model.orgid = _brigadeType;
    model.belong = _responsibilityDistrict;
    model.prostatus = _problemStatus;
    model.startDate = _startDateFind;
    model.endDate = _endDateFind;
    model.cstartdate = _startDateClosed;
    model.cenddate = _endDateClosed;

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
