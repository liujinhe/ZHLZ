//
//  ZHLZBaseVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GRRequest.h"

#import "ZHLZAPIURLConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBaseVM : GRRequest

@property (nonatomic, assign) BOOL isIgnoreLoading;

@property (nonatomic, assign) BOOL isList;

- (instancetype)initWithRequestUrl:(NSString *)requestUrl;

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
               withRequestArgument:(id)requestArgument;

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                 withRequestMethod:(GRRequestMethod)requestMethod
               withRequestArgument:(nullable id)requestArgument;

- (NSURLSessionTask *)requestCompletionWithSuccess:(GRResponseCompletionBlock)success
                                       withFailure:(GRResponseCompletionBlock)failure;

@end

NS_ASSUME_NONNULL_END
