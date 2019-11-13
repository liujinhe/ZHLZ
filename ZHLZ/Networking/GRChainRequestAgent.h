//
//  GRChainRequestAgent.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GRChainRequest;

@interface GRChainRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (GRChainRequestAgent *)sharedInstance;

- (void)addChainRequest:(GRChainRequest *)request;

- (void)removeChainRequest:(GRChainRequest *)request;

@end

NS_ASSUME_NONNULL_END
