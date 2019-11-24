//
//  ZHLZTabBarController.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZTabBarController.h"
#import "ZHLZNavigationController.h"

#import "ZHLZHomeVC.h"
#import "ZHLZAddressBookVC.h"
#import "ZHLZMineVC.h"

#import "ZHLZUserManager.h"
#import "ZHLZLoginVC.h"

@interface ZHLZTabBarController ()

@end

@implementation ZHLZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAction) name:LoginNotificationConst object:nil];
    
    [self initUI];
    
    if (![ZHLZUserManager sharedInstance].isLogin) {
        [self loginAction];
    }
}

- (void)initUI {
    self.tabBar.tintColor = kThemeColor;
    self.tabBar.backgroundColor = UIColor.whiteColor;
    self.tabBar.backgroundImage = [UIImage imageWithColor:UIColor.whiteColor];
    self.tabBar.shadowImage = [UIImage imageWithColor:UIColor.whiteColor];
    
    NSMutableArray<UIViewController *> *viewControllers = @[].mutableCopy;
    
    [viewControllers addObject:[[ZHLZNavigationController alloc] initWithRootViewController:[ZHLZHomeVC new]]];
    
    [viewControllers addObject:[[ZHLZNavigationController alloc] initWithRootViewController:[ZHLZAddressBookVC new]]];
    
    [viewControllers addObject:[[ZHLZNavigationController alloc] initWithRootViewController:[ZHLZMineVC new]]];
    
    self.viewControllers = viewControllers;
    
    NSMutableArray *titleTabBarItemArray = @[].mutableCopy;
    NSMutableArray *imageTabBarItemArray = @[].mutableCopy;
    NSMutableArray *imageSelectedTabBarItemArray = @[].mutableCopy;
    
    [titleTabBarItemArray addObject:@"首页"];
    [imageTabBarItemArray addObject:@"icon_home_normal"];
    [imageSelectedTabBarItemArray addObject:@"icon_home_selected"];
    
    [titleTabBarItemArray addObject:@"通讯录"];
    [imageTabBarItemArray addObject:@"icon_address_book_normal"];
    [imageSelectedTabBarItemArray addObject:@"icon_address_book_selected"];
    
    [titleTabBarItemArray addObject:@"我的"];
    [imageTabBarItemArray addObject:@"icon_mine_normal"];
    [imageSelectedTabBarItemArray addObject:@"icon_mine_selected"];
    
    for (NSUInteger i = 0; i < self.viewControllers.count; i++) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:titleTabBarItemArray[i]
                                                                 image:[UIImage imageNamed:imageTabBarItemArray[i]]
                                                         selectedImage:[UIImage imageNamed:imageSelectedTabBarItemArray[i]]];
        tabBarItem.tag = i;
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3.f);
        self.viewControllers[i].tabBarItem = tabBarItem;
        
    }
}

- (void)loginAction {
    ZHLZNavigationController *nav = (ZHLZNavigationController *)self.selectedViewController;
    if (nav && nav.topViewController) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ZHLZLoginVC *loginVC = [ZHLZLoginVC new];
            loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [nav.topViewController presentViewController:loginVC animated:NO completion:nil];
        });
    }
}

@end
