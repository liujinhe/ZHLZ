//
//  ZHLZHomeBuildProjectVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeBuildProjectModel.h"
#import "ZHLZHomeBuildProjectSubmitModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeBuildProjectVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeBuildProjectDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeBuildProjectModel *> *homeBuildProjectModelArray))block;

- (NSURLSessionTask *)loadHomeBuildProjectDataId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeBuildProjectModel *homeBuildProjectModel))block;

- (NSURLSessionTask *)submitHomeBuildProjectSubmitType:(NSInteger)submitType andSubmitModel:(ZHLZHomeBuildProjectSubmitModel *)projectSubmitModel withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
