//
//  ZHLZHomeSafeProblemVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeSafeProblemModel.h"
#import "ZHLZHomeSafeProblemSUbmitModel.h"
#import "ZHLZSupervisorSubmitModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeProblemVM : ZHLZBaseVM

+ (instancetype)sharedInstance;
///列表
- (NSURLSessionTask *)loadHomeSafeProblemDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeSafeProblemModel *> *homeSafeProblemArray))block;

///详情
- (NSURLSessionTask *)loadHomeSafeProblemDetailWithId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeSafeProblemModel *homeSafeProblem))block;

///保存/修改
- (NSURLSessionTask *)submitHomeSafeProblemWithSubmitType:(NSInteger)submitType andSubmitArray:(NSArray *)submitArray withBlock:(dispatch_block_t)block;


//获取督导列表
- (NSURLSessionTask *)loadHomeSafeFloodPreventionProblemGetMeasuresWithId:(NSString *)Id withType:(NSInteger)type Block:(void (^)(NSArray <ZHLZSupervisorSubmitModel *> *supervisorSubmitModelArray))block;

@end

NS_ASSUME_NONNULL_END
