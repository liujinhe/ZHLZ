//
//  ZHLZHomeMapSearchVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/20.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMapSearchVC.h"
#import "ZHLZBrigadePickerViewVC.h"
#import "ZHLZProjectTypePickerViewVC.h"

CGFloat const FilterViewAnimationTimeConst = 0.35f;

@interface ZHLZHomeMapSearchVC ()
{
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

@property (nonatomic, strong) ZHLZBrigadePickerViewVC *brigadePickerViewVC;
@property (nonatomic, strong) ZHLZProjectTypePickerViewVC *projectTypePickerViewVC;

@end

@implementation ZHLZHomeMapSearchVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideFilterView)]];
    
    self.brigadePickerViewVC = [ZHLZBrigadePickerViewVC new];
    self.brigadePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull brigadeType, NSString * _Nonnull brigadeName) {
        @strongify(self);
        
        self->_bid = brigadeType;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bigTeamButton.selected = YES;
            [self.bigTeamButton setTitle:brigadeName forState:UIControlStateSelected];
        });
    };
    
    self.projectTypePickerViewVC = [ZHLZProjectTypePickerViewVC new];
    self.projectTypePickerViewVC.selectPickerBlock = ^(NSString * _Nonnull projectType, NSString * _Nonnull projectName) {
        @strongify(self);
        
        self->_projecttypeId = projectType;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.projectTypeButton.selected = YES;
            [self.projectTypeButton setTitle:projectName forState:UIControlStateSelected];
        });
    };
}

- (IBAction)picLayerAction {
    
}

- (IBAction)colorAction {
    
}

- (IBAction)brigadeTeamAction {
    [self presentViewController:self.brigadePickerViewVC animated:NO completion:nil];
}

- (IBAction)projectTypeAction {
    [self presentViewController:self.projectTypePickerViewVC animated:NO completion:nil];
}

- (IBAction)resetAction:(id)sender {
    self.projectNameTextField.text = @"";
    
    _bid = @"";
    self.bigTeamButton.selected = NO;
    
    _projecttypeId = @"";
    self.projectTypeButton.selected = NO;
}

- (IBAction)determineAction {
    if (self.selectSearchBlock) {
        self.selectSearchBlock(self.projectNameTextField.text?:@"", _bid?:@"", _projecttypeId?:@"");
    }
}

- (void)filterAnimation:(BOOL)isHidden {
    self.filterTopView.hidden = isHidden;
    self.filterView.hidden = isHidden;
    self.filterBottomView.hidden = isHidden;
    
    CATransition *animation = [CATransition animation];
    // 设置动画的类型
    animation.type = kCATransitionPush;
    // 设置动画的方向
    animation.subtype = isHidden ? kCATransitionFromLeft : kCATransitionFromRight;
    animation.duration = FilterViewAnimationTimeConst;
    [self.filterTopView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterBottomView.layer addAnimation:animation forKey:@"pushAnimation"];
}

- (void)showFilterView {
    self.maskView.hidden = NO;
    
    [self filterAnimation:NO];
}

- (void)hideFilterView {
    [self filterAnimation:YES];
    
    [self performSelector:@selector(hideMaskView) withObject:nil afterDelay:FilterViewAnimationTimeConst];
}

- (void)hideMaskView {
    self.maskView.hidden = YES;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
