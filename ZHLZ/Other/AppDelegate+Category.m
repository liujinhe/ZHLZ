//
//  AppDelegate+Category.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "AppDelegate+Category.h"

#import "ZHLZTabBarController.h"

#import "FPSDisplay.h"

#import <IQKeyboardManager/IQKeyboardManager.h>

#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation AppDelegate (Category)

- (void)initAppLaunch {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [ZHLZTabBarController new];
    
    if (@available(iOS 11.0, *)) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
    }
    
    [[UITextField appearance] setTintColor:kThemeColor];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [AMapServices sharedServices].apiKey = AMapKeyConst;
    [AMapServices sharedServices].enableHTTPS = YES;
    
#ifdef DEBUG
    [IQKeyboardManager sharedManager].enableDebugging = YES;
    
    [FPSDisplay sharedInstance];
#endif
}

/// 初始化遮罩层（毛玻璃效果）
- (void)initFrostedGlassMaskView {
    self.frostedGlassMaskView = [[UIView alloc] initWithFrame:self.window.frame];
    self.frostedGlassMaskView.alpha = 1.0;
    self.frostedGlassMaskView.hidden = YES;
    [self.window addSubview:self.frostedGlassMaskView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualView.frame = self.frostedGlassMaskView.frame;
    [self.frostedGlassMaskView addSubview:visualView];
}

@end
