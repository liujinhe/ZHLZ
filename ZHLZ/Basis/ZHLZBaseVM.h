//
//  ZHLZBaseVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRRequest.h"

#import "ZHLZAPIURLConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBaseVM : GRRequest

@property (nonatomic, assign) BOOL isIgnoreLoading;

/// 是否默认参数（列表加载）
@property (nonatomic, assign) BOOL isDefaultArgument;

/// 是否拼接请求参数（带?）
@property (nonatomic, assign) BOOL isRequestArgument;

/// 是否拼接请求参数（带/）
@property (nonatomic, assign) BOOL isRequestArgumentSlash;

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
