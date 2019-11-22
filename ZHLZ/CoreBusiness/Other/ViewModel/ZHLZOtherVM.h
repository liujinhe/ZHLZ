//
//  ZHLZOtherVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZBrigadeModel.h"
#import "ZHLZAreaModel.h"
#import "ZHLZCodeValuesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZOtherVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

/// 获取大队
/// @param block 回调
- (NSURLSessionTask *)getBrigadeWithBlock:(void(^)(NSArray<ZHLZBrigadeModel *> *array))block;

/// 获取片区
/// @param orgId 所属大队 ID
/// @param block 回调
- (NSURLSessionTask *)getAreaWithOrgId:(NSString *)orgId withBlock:(void(^)(NSArray<ZHLZAreaModel *> *array))block;

/// 获取对应下拉列表
/// @param type 获取类型（1-是否重点 2-施工状态 3-巡查频次 4-工程类型 5-责任所属区县 6-上级交办、舆情及应急处理）
/// @param block 回调
- (NSURLSessionTask *)getListWithType:(NSInteger)type
                            withBlock:(void(^)(NSArray<ZHLZCodeValuesModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
