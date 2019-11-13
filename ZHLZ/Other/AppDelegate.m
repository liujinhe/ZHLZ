//
//  AppDelegate.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/11.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+Category.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initAppLaunch];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    self.frostedGlassMaskView.hidden = YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.frostedGlassMaskView.hidden = NO;
}

@end
