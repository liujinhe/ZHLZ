//
//  ZHLZBaseBatchVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRBatchRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBaseBatchVM : GRBatchRequest

@property (nonatomic, assign) BOOL isIgnoreLoading;

- (instancetype)initWithRequestUrlArray:(nullable NSArray *)requestUrlArray
                    withIsLoadListArray:(nullable NSArray *)isLoadListArray;

- (void)requestCompletionWithSuccess:(nullable void (^)(NSMutableArray<GRResponse *> *responseArray))success
                         withFailure:(nullable void (^)(NSMutableArray<GRResponse *> *responseArray))failure;

@end

NS_ASSUME_NONNULL_END
