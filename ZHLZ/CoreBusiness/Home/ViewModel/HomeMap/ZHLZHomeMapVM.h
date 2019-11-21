//
//  ZHLZHomeMapVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@class ZHLZHomeMapModel;

@interface ZHLZHomeMapVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

/// 加载地图信息
/// @param name 项目名称
/// @param bid 大队id
/// @param projecttypeId 项目类型
/// @param block 回调
- (NSURLSessionTask *)loadHomeMapDataWithName:(NSString *)name
                                      withBid:(NSString *)bid
                            withProjecttypeId:(NSString *)projecttypeId
                                    withBlock:(void (^)(NSArray<ZHLZHomeMapModel *> *homeMapArray))block;

@end

NS_ASSUME_NONNULL_END
