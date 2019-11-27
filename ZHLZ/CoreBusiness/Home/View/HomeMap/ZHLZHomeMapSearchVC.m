//
//  ZHLZHomeMapSearchVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/20.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMapSearchVC.h"
#import "ZHLZBrigadePickerViewVC.h"
#import "ZHLZListPickerViewVC.h"
#import "ZHLZPickerViewVC.h"

#import "ZHLZDatePickerVC.h"

@interface ZHLZHomeMapSearchVC ()
{
    NSInteger _picLayerIndex;
    NSInteger _colorIndex;
    NSString *_bid;
    NSString *_projecttypeId;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *filterTopView;
@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UIView *filterBottomView;

@property (weak, nonatomic) IBOutlet UIButton *picLayerButton;
@property (weak, nonatomic) IBOutlet UIButton *colorButton;
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *bigTeamButton;
@property (weak, nonatomic) IBOutlet UIButton *projectTypeButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorTopLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorHeightLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (nonatomic, strong) ZHLZPickerViewVC *picLayerPickerViewVC;
@property (nonatomic, strong) ZHLZPickerViewVC *colorPickerViewVC;
@property (nonatomic, strong) ZHLZBrigadePickerViewVC *brigadePickerViewVC;
@property (nonatomic, strong) ZHLZListPickerViewVC *projectTypePickerViewVC;

@end

@implementation ZHLZHomeMapSearchVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
    self.colorView.hidden = YES;
    self.colorTopLayoutConstraint.constant = 0;
    self.colorHeightLayoutConstraint.constant = 0;
    
    if ([[ZHLZUserManager sharedInstance] isSuperAdmin]) {
        self.bigTeamButton.userInteractionEnabled = YES;
        
        self.bigTeamButton.selected = NO;
        
        [self.bigTeamButton setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    } else {
        ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
        
        self.bigTeamButton.userInteractionEnabled = NO;
        
        self.bigTeamButton.selected = YES;
        [self.bigTeamButton setTitle:userModel.orgname forState:UIControlStateSelected];
        
        [self.bigTeamButton setImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
        
        _bid = userModel.orgId;
    }
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideFilterView)]];
    
    self.picLayerPickerViewVC = [ZHLZPickerViewVC new];
    self.picLayerPickerViewVC.isDisablePleaseSelected = YES;
    self.picLayerPickerViewVC.titleArray = @[@"原始图层", @"问题图层"];
    self.picLayerPickerViewVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        @strongify(self);
        
        self->_picLayerIndex = index;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self->_picLayerIndex == 1) {
                self.colorView.hidden = NO;
                self.colorTopLayoutConstraint.constant = 10;
                self.colorHeightLayoutConstraint.constant = 50;
            } else {
                self.colorView.hidden = YES;
                self.colorTopLayoutConstraint.constant = 0;
                self.colorHeightLayoutConstraint.constant = 0;
            }
            [self.picLayerButton setTitle:name forState:UIControlStateNormal];
        });
    };
    [self.picLayerButton setTitle:[self.picLayerPickerViewVC.titleArray firstObject] forState:UIControlStateNormal];
    
    self.colorPickerViewVC = [ZHLZPickerViewVC new];
    self.colorPickerViewVC.titleArray = @[@"红色", @"绿色", @"蓝色"];
    self.colorPickerViewVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        @strongify(self);
        
        self->_colorIndex = index + 1;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.colorButton setTitle:name forState:UIControlStateNormal];
        });
    };
    
    self.brigadePickerViewVC = [ZHLZBrigadePickerViewVC new];
    self.brigadePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull brigadeType, NSString * _Nonnull brigadeName) {
        @strongify(self);
        
        self->_bid = brigadeType;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.bigTeamButton setTitle:brigadeName forState:UIControlStateNormal];
        });
    };
    
    self.projectTypePickerViewVC = [ZHLZListPickerViewVC new];
    self.projectTypePickerViewVC.type = 4;
    self.projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        
        self->_projecttypeId = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.projectTypeButton setTitle:name forState:UIControlStateNormal];
        });
    };
}

- (IBAction)picLayerAction {
    [self presentViewController:self.picLayerPickerViewVC animated:NO completion:nil];
}

- (IBAction)colorAction {
    [self presentViewController:self.colorPickerViewVC animated:NO completion:nil];
}

- (IBAction)brigadeTeamAction {
    [self presentViewController:self.brigadePickerViewVC animated:NO completion:nil];
}

- (IBAction)projectTypeAction {
    [self presentViewController:self.projectTypePickerViewVC animated:NO completion:nil];
}

- (IBAction)resetAction:(id)sender {
    self.projectNameTextField.text = @"";
    
    if (self.bigTeamButton.isUserInteractionEnabled) {
        _bid = @"";
        self.bigTeamButton.selected = NO;
    }
    
    _projecttypeId = @"";
    self.projectTypeButton.selected = NO;
}

- (IBAction)determineAction {
    if (_picLayerIndex != 1) {
        _colorIndex = 0;
    }
    if (self.selectSearchBlock) {
        self.selectSearchBlock(self.projectNameTextField.text?:@"", _bid?:@"", _projecttypeId?:@"", _picLayerIndex, _colorIndex);
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
    self.filterView.hidden = isHidden;
    self.filterBottomView.hidden = isHidden;
    
    CATransition *animation = [CATransition animation];
    // 设置动画的类型
    animation.type = kCATransitionPush;
    // 设置动画的方向
    animation.subtype = isHidden ? kCATransitionFromLeft : kCATransitionFromRight;
    animation.duration = PopAnimationDurationConst;
    [self.filterTopView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterBottomView.layer addAnimation:animation forKey:@"pushAnimation"];
}

- (void)hideMaskView {
    self.maskView.hidden = YES;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
