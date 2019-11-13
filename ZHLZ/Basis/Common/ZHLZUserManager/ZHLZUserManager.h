//
//  ZHLZUserManager.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZHLZUserModel;

typedef void (^LogoutBlock)(void);

@interface ZHLZUserManager : NSObject

@property (nonatomic, copy) NSString *apns_clientID;

// 当前登录的用户，必须实现NSCoding协议
@property (nonatomic, strong, getter = getCurrentUserModel) ZHLZUserModel *user;

/// 网络请求前设置好相关配置
+ (instancetype)sharedInstance;

/// 是否登录
- (BOOL)isLogin;

/// 判断是否登录，如果未登录，则跳转登录
- (BOOL)isLoginPresentLogin;

/// 退出登录
- (void)logout;
- (void)logoutWithBlock:(LogoutBlock)block;

/// 保存用户信息
- (BOOL)saveUserWithJson:(id)userJson;

/// 获取用户信息
- (ZHLZUserModel *)getCurrentUserModel;

/// 持久化数据
- (BOOL)synchronousUserDataToStore;

@end

NS_ASSUME_NONNULL_END
