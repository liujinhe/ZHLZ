//
//  ZHLZHomeOccupyProblemVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeOccupyProblemSearchModel.h"
#import "ZHLZHomeOccupyProblemModel.h"
#import "ZHLZHomeOccupyProblemDetailModel.h"
#import "ZHLZHomeOccupyProblemSubmitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeOccupyProblemVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeOccupyProblemDataWithPageNo:(NSInteger)pageNo withModel:(ZHLZHomeOccupyProblemSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeOccupyProblemModel *> *array))block;


- (NSURLSessionTask *)loadHomeOccupyProblemDetailWithId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeOccupyProblemDetailModel *occupyProblemDetailModel))block;


- (NSURLSessionTask *)submitHomeSafeProblemWithSubmitModel:(ZHLZHomeOccupyProblemSubmitModel *)occupyProblemSubmitModel withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
