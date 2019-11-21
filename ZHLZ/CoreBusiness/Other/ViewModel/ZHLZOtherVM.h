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

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZOtherVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)getBrigadeWithBlock:(void(^)(NSArray<ZHLZBrigadeModel *> *array))block;

- (NSURLSessionTask *)getAreaWithOrgId:(NSString *)orgId withBlock:(void(^)(NSArray<ZHLZAreaModel *> *array))block;

- (NSURLSessionTask *)getDistrictWithBlock:(void(^)(NSArray<ZHLZDistrictModel *> *array))block;

- (NSURLSessionTask *)getProjectTypeWithBlock:(void(^)(NSArray<ZHLZProjectTypeModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
