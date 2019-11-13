//
//  ZHLZNavigationController.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZNavigationController.h"

@interface ZHLZNavigationController ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation ZHLZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationBar.barTintColor = kThemeColor;
    self.navigationBar.shadowImage = [UIImage imageWithColor:UIColor.clearColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark - getter and settter

- (UIButton *)backButton {
    if (!_backButton) {
        CGFloat backButtonY = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat backButtonWH = self.navigationBar.frame.size.height;
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, backButtonY, backButtonWH, backButtonWH);
        _backButton.adjustsImageWhenHighlighted = NO;
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_backButton setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
