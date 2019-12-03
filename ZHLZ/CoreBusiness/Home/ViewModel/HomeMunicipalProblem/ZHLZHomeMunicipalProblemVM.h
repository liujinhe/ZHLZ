//
//  ZHLZHomeMunicipalProblemVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeMunicipalProblemSearchModel.h"
#import "ZHLZHomeMunicipalProblemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMunicipalProblemVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeMunicipalProblemDataWithPageNo:(NSInteger)pageNo withModel:(ZHLZHomeMunicipalProblemSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeMunicipalProblemModel *> *array, NSError *error))block;

///关闭问题
- (NSURLSessionTask *)closeMunicipalProblemWithParms:(NSDictionary *)parms withBlock:(dispatch_block_t)block;
///开启问题
- (NSURLSessionTask *)openMunicipalProblemWithId:(NSString *)problemId withBlock:(dispatch_block_t)block;

- (NSURLSessionTask *)loadHomeMunicipalProblemDetailWithId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeMunicipalProblemModel *municipalProblemModel))block;

- (NSURLSessionTask *)submitHomeMunicipalProblemWithSubmitArray:(NSArray *)submitArray andSubmitType:(NSInteger)type withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
