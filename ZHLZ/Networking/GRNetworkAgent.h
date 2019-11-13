//
//  GRNetworkAgent.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GRBaseRequest;

@interface GRNetworkAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (GRNetworkAgent *)sharedInstance;

- (void)addRequest:(GRBaseRequest *)request;

- (void)cancelRequest:(GRBaseRequest *)request;

- (void)cancelAllRequest;

- (NSString *)buildRequestUrl:(GRBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
