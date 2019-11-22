//
//  ZHLZHomeSafeProblemVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeSafeProblemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeProblemVM : ZHLZBaseVM

+ (instancetype)sharedInstance;
//列表
- (NSURLSessionTask *)loadHomeSafeProblemDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeSafeProblemModel *> *homeSafeProblemArray))block;

//详情
- (NSURLSessionTask *)loadHomeSafeProblemDetailWithId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeSafeProblemModel *homeSafeProblem))block;

//获取督导列表
- (NSURLSessionTask *)loadHomeSafeFloodPreventionProblemGetMeasuresWithBlock:(void (^)(ZHLZHomeSafeProblemModel *homeSafeProblem))block;

@end

NS_ASSUME_NONNULL_END
