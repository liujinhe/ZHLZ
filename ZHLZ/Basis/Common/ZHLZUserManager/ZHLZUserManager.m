//
//  ZHLZUserManager.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZUserManager.h"
#import "ZHLZStoreUtility.h"
#import "ZHLZUserModel.h"

static NSString * const kZHLZUserManagerKey = @"ZHLZUserManagerKey";

static ZHLZUserManager *_userManager = nil;

@implementation ZHLZUserManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userManager = [[self alloc] init];
        NSString *apns = [[NSUserDefaults standardUserDefaults] objectForKey:@"apns"];
        if (apns && apns.length > 0) {
            _userManager.apns_clientID = apns;
        } else {
            _userManager.apns_clientID = @"";
        }
    });
    return _userManager;
}

- (BOOL)saveUserWithJson:(id)userJson {
    ZHLZUserModel *currentUser = [self getCurrentUserModel];
    if (currentUser) {
        NSDictionary *userJsonDic = (NSDictionary *)userJson;
        NSDictionary *currentUserDic = (NSDictionary *)[currentUser modelToJSONObject];
        for (NSString *key in userJsonDic) {
            id value = [userJsonDic objectForKey:key];
            if ([value isNotBlank]) {
                [currentUserDic setValue:value forKey:key];
            }
        }
        currentUser = [ZHLZUserModel modelWithDictionary:currentUserDic.copy];
    } else {
        currentUser = [ZHLZUserModel modelWithJSON:userJson];
    }
    
    return [ZHLZStoreUtility storeToRootDirectory:[currentUser modelToJSONObject]
                                              key:kZHLZUserManagerKey];
}

/// 持久化数据
- (BOOL)synchronousUserDataToStore {
    if (_user) {
        return [ZHLZStoreUtility storeToRootDirectory:[_user modelToJSONObject]
                                                  key:kZHLZUserManagerKey];
    }
    return NO;
}

- (ZHLZUserModel *)getCurrentUserModel {
    id user = [ZHLZStoreUtility fetchByRootDirectory:kZHLZUserManagerKey];
    _user = [ZHLZUserModel modelWithJSON:user];
    return _user;
}

- (BOOL)isLogin {
    id user = [ZHLZStoreUtility fetchByRootDirectory:kZHLZUserManagerKey];
    ZHLZUserModel *userModel = [ZHLZUserModel modelWithJSON:user];
    return userModel && [userModel.encryptionKey isNotBlank];
}

- (BOOL)isLoginPresentLogin {
    BOOL isLogin = [self isLogin];
    if (!isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotificationConst object:nil];
        return YES;
    }
    return NO;
}

- (void)logout {
    [self deleteAction];
}

- (void)logoutWithBlock:(LogoutBlock)block {
    [self deleteAction];
    if (block) {
        block();
    }
}

- (void)deleteAction {
    BOOL result = [ZHLZStoreUtility deleteRootPatByKey:kZHLZUserManagerKey];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    // 清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    if (result) {
        _user = nil;
    }
}

@end
