//
//  GRBatchRequestAgent.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GRBatchRequest;

@interface GRBatchRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (GRBatchRequestAgent *)sharedInstance;

- (void)addBatchRequest:(GRBatchRequest *)request;

- (void)removeBatchRequest:(GRBatchRequest *)request;

@end

NS_ASSUME_NONNULL_END
