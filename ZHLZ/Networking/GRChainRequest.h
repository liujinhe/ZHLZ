//
//  GRChainRequest.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GRBaseRequest;
@class GRChainRequest;
@protocol GRRequestAccessory;

@protocol GRChainRequestDelegate <NSObject>

@optional

- (void)chainRequestFinished:(GRChainRequest *)chainRequest;

- (void)chainRequestFailed:(GRChainRequest *)chainRequest failedBaseRequest:(GRBaseRequest *)request;

@end

typedef void (^GRChainCallback)(GRChainRequest *chainRequest, GRBaseRequest *baseRequest);

@interface GRChainRequest : NSObject

@property (nonatomic, weak, nullable) id<GRChainRequestDelegate> delegate;

@property (nonatomic, strong, nullable) NSMutableArray<id<GRRequestAccessory>> *requestAccessories;

- (NSArray<GRBaseRequest *> *)requestArray;

- (void)addAccessory:(id<GRRequestAccessory>)accessory;

- (void)start;

- (void)stop;

- (void)addRequest:(GRBaseRequest *)request callback:(nullable GRChainCallback)callback;

@end

NS_ASSUME_NONNULL_END
