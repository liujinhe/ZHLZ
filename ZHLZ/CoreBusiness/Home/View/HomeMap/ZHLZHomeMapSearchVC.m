//
//  ZHLZHomeMapSearchVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/20.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMapSearchVC.h"

CGFloat const FilterViewAnimationTimeConst = 0.35f;

@interface ZHLZHomeMapSearchVC ()

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *filterTopView;
@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UIView *filterBottomView;

@property (weak, nonatomic) IBOutlet UIButton *picLayerButton;
@property (weak, nonatomic) IBOutlet UIButton *colorButton;
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *bigTeamButton;
@property (weak, nonatomic) IBOutlet UIButton *projectTypeButton;

@end

@implementation ZHLZHomeMapSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideFilterView)]];
}

- (IBAction)picLayerAction {
    
}

- (IBAction)colorAction {
    
}

- (IBAction)bigTeamAction {
    
}

- (IBAction)projectTypeAction {
    
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
