//
//  ZHLZStoreUtility.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZStoreUtility <T> : NSObject

#pragma mark - 存储相关
+ (BOOL)storeToRootDirectory:(T)data key:(NSString *)key;

#pragma mark - 提取相关
+ (T)fetchByRootDirectory:(NSString *)key;

#pragma mark - 删除相关
+ (BOOL)deleteRootPatByKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
