//
//  GRBatchRequest.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRResponse.h"

NS_ASSUME_NONNULL_BEGIN

@class GRRequest;
//@class GRResponse;
@class GRBatchRequest;
@protocol GRRequestAccessory;

/// GRRequestAccessory
@protocol GRBatchRequestDelegate <NSObject>

@optional

- (void)batchRequestFinished:(GRBatchRequest *)batchRequest;

- (void)batchRequestFailed:(GRBatchRequest *)batchRequest;

@end

@interface GRBatchRequest : NSObject

@property (nonatomic, strong, readonly) NSArray<GRRequest *> *requestArray;

@property (nonatomic, weak, nullable) id<GRBatchRequestDelegate> delegate;

@property (nonatomic, copy, nullable) void (^successCompletionBlock)(GRBatchRequest *);

@property (nonatomic, copy, nullable) void (^failureCompletionBlock)(GRBatchRequest *);

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong, nullable) NSMutableArray<id<GRRequestAccessory>> *requestAccessories;

//@property (nonatomic, strong, readonly, nullable) GRRequest *failedRequest;
@property (nonatomic, strong, readonly, nullable) GRResponse *failedRequest;

- (instancetype)initWithRequestArray:(NSArray<GRRequest *> *)requestArray;

- (void)setCompletionBlockWithSuccess:(nullable void (^)(GRBatchRequest *batchRequest))success
                              failure:(nullable void (^)(GRBatchRequest *batchRequest))failure;

- (void)clearCompletionBlock;

- (void)addAccessory:(id<GRRequestAccessory>)accessory;

- (void)start;

- (void)stop;

- (void)startWithCompletionBlockWithSuccess:(nullable void (^)(GRBatchRequest *batchRequest))success
                                    failure:(nullable void (^)(GRBatchRequest *batchRequest))failure;

- (BOOL)isDataFromCache;

@end

NS_ASSUME_NONNULL_END
