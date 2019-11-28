//
//  ZHLZHomeSafeVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeSafeModel.h"
#import "ZHLZSafeSubmitModel.h"
#import "ZHLZHomeSafeSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeSafeDataWithPageNum:(NSInteger)pageNum withModel:(nullable ZHLZHomeSafeSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeSafeModel *> *homeSafeModelArray))block;

- (NSURLSessionTask *)loadHomeSafeDataId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeSafeModel *homeSafeModel))block;

- (NSURLSessionTask *)submitHomeSafeWithSubmitType:(NSInteger)submitType andSubmitModel:(ZHLZSafeSubmitModel *)submitModel withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
