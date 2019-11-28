//
//  ZHLZBuildProjectSearchVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBuildProjectSearchVC.h"
#import "ZHLZListPickerViewVC.h"

@interface ZHLZBuildProjectSearchVC ()
{
    NSString *_projectStatus;
    NSString *_inspectionFrequency;
    NSString *_projectType;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *filterTopView;
@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollView;
@property (weak, nonatomic) IBOutlet UIView *filterBottomView;


@property (weak, nonatomic) IBOutlet UITextField *projectIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *projectLocationTextField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;

@property (weak, nonatomic) IBOutlet UIButton *projectStatusButton;
@property (weak, nonatomic) IBOutlet UIButton *inspectionFrequencyButton;
@property (weak, nonatomic) IBOutlet UIButton *projectTypeButton;

@property (nonatomic, strong) ZHLZListPickerViewVC *projectStatusListPickerViewVC;
@property (nonatomic, strong) ZHLZListPickerViewVC *inspectionFrequencyListPickerViewVC;
@property (nonatomic, strong) ZHLZListPickerViewVC *projectTypeListPickerViewVC;

@end

@implementation ZHLZBuildProjectSearchVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterScrollView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideFilterView)]];
    
    self.projectStatusListPickerViewVC = [ZHLZListPickerViewVC new];
    self.projectStatusListPickerViewVC.type = 2;
    self.projectStatusListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_projectStatus = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.projectStatusButton.selected = YES;
            [self.projectStatusButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.inspectionFrequencyListPickerViewVC = [ZHLZListPickerViewVC new];
    self.inspectionFrequencyListPickerViewVC.type = 3;
    self.inspectionFrequencyListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_inspectionFrequency = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.inspectionFrequencyButton.selected = YES;
            [self.inspectionFrequencyButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.projectTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    self.projectTypeListPickerViewVC.type = 4;
    self.projectTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_projectType = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.projectTypeButton.selected = YES;
            [self.projectTypeButton setTitle:name forState:UIControlStateSelected];
        });
    };
}

#pragma mark - Action

- (IBAction)projectStatusAction {
    [self presentViewController:self.projectStatusListPickerViewVC animated:NO completion:nil];
}

- (IBAction)inspectionFrequencyAction {
    [self presentViewController:self.inspectionFrequencyListPickerViewVC animated:NO completion:nil];
}

- (IBAction)projectTypeAction {
    [self presentViewController:self.projectTypeListPickerViewVC animated:NO completion:nil];
}

- (IBAction)resetAction {
    self.projectIdTextField.text = @"";
    self.projectNameTextField.text = @"";
    self.projectLocationTextField.text = @"";
    self.remarkTextField.text = @"";
    
    _projectStatus = nil;
    self.projectStatusButton.selected = NO;
    _inspectionFrequency = nil;
    self.inspectionFrequencyButton.selected = NO;
    _projectType = nil;
    self.projectTypeButton.selected = NO;
}

- (IBAction)determineAction {
    ZHLZBuildProjectSearchModel *model = [ZHLZBuildProjectSearchModel new];
    model.objectID = [self.projectIdTextField.text isNotBlank] ? self.projectIdTextField.text : nil;
    model.name = [self.projectNameTextField.text isNotBlank] ? self.projectNameTextField.text : nil;
    model.position = [self.projectLocationTextField.text isNotBlank] ? self.projectLocationTextField.text : nil;
    model.remark = [self.remarkTextField.text isNotBlank] ? self.remarkTextField.text : nil;
    model.projectstatusId = _projectStatus;
    model.frequency = _inspectionFrequency;
    model.projecttypeIdcenddate = _projectType;
    
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
