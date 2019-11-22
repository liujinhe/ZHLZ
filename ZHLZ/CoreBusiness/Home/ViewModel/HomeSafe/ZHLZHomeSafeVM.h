//
//  ZHLZHomeSafeVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeSafeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeSafeDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeSafeModel *> *homeSafeModelArray))block;

- (NSURLSessionTask *)loadHomeSafeDataId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeSafeModel *homeSafeModel))block;

@end

NS_ASSUME_NONNULL_END
