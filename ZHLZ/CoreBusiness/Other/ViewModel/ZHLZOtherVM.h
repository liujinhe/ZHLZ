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
#import "ZHLZDistrictModel.h"
#import "ZHLZProjectTypeModel.h"
#import "ZHLZCodeValuesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZOtherVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

/// 获取大队（部门）
/// @param block 回调
- (NSURLSessionTask *)getBrigadeWithBlock:(void(^)(NSArray<ZHLZBrigadeModel *> *array))block;

/// 获取片区
/// @param orgId 所属大队（部门）
/// @param block 回调
- (NSURLSessionTask *)getAreaWithOrgId:(NSString *)orgId withBlock:(void(^)(NSArray<ZHLZAreaModel *> *array))block;

/// 获取区县
/// @param block 回调
- (NSURLSessionTask *)getDistrictWithBlock:(void(^)(NSArray<ZHLZDistrictModel *> *array))block;

/// 获取工程类型
/// @param block 回调
- (NSURLSessionTask *)getProjectTypeWithBlock:(void(^)(NSArray<ZHLZProjectTypeModel *> *array))block;

/// 获取施工状态
/// @param block 回调
- (NSURLSessionTask *)getProjectStatusWithBlock:(void(^)(NSArray<ZHLZCodeValuesModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
