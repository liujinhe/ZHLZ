//
//  ZHLZHomeSafeSearchVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeSearchVC.h"

@interface ZHLZHomeSafeSearchVC ()

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *filterTopView;
@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollView;
@property (weak, nonatomic) IBOutlet UIView *filterBottomView;


@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *problemDescTextField;

@end

@implementation ZHLZHomeSafeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterScrollView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideFilterView)]];
}

#pragma mark - Action

- (IBAction)resetAction {
    self.locationTextField.text = @"";
    self.problemDescTextField.text = @"";
}

- (IBAction)determineAction {
    ZHLZHomeSafeSearchModel *model = [ZHLZHomeSafeSearchModel new];
    model.currentPlace = [self.locationTextField.text isNotBlank] ? self.locationTextField.text : nil;
    model.prodescription = [self.problemDescTextField.text isNotBlank] ? self.problemDescTextField.text : nil;
    
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
