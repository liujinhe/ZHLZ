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
    
    self.navigationBar.translucent = NO;
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationBar.tintColor = kNavTitleColor;
    self.navigationBar.barTintColor = kThemeColor;
    self.navigationBar.shadowImage = [UIImage imageWithColor:UIColor.clearColor];
    self.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName: kNavTitleColor };
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
        CGFloat backButtonW = 96.f;
        CGFloat backButtonH = 40.f;
        CGFloat backButtonY = [UIApplication sharedApplication].statusBarFrame.size.height + (self.navigationBar.frame.size.height - backButtonH) / 2;
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, backButtonY, backButtonW, backButtonH);
        _backButton.adjustsImageWhenHighlighted = NO;
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
