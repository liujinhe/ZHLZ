//
//  GRRequest.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const GRRequestCacheErrorDomain;

@interface GRRequest : GRBaseRequest

@property (nonatomic, assign) BOOL ignoreCache;

- (BOOL)isDataFromCache;

- (BOOL)loadCacheWithError:(NSError * __autoreleasing *)error;

- (void)startWithoutCache;

- (void)saveResponseDataToCacheFile:(NSData *)data;

#pragma mark - Subclass Override

- (NSInteger)cacheTimeInSeconds;

- (long long)cacheVersion;

- (nullable id)cacheSensitiveData;

- (BOOL)writeCacheAsynchronously;

@end

NS_ASSUME_NONNULL_END
