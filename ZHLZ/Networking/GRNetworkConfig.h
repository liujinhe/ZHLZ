//
//  GRNetworkConfig.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GRBaseRequest;
@class AFSecurityPolicy;

/// GRUrlFilterProtocol
@protocol GRUrlFilterProtocol <NSObject>

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(GRBaseRequest *)request;

@end

/// GRCacheDirPathFilterProtocol
@protocol GRCacheDirPathFilterProtocol <NSObject>

- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(GRBaseRequest *)request;

@end

@interface GRNetworkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (GRNetworkConfig *)sharedInstance;

@property (nonatomic, strong) NSString *baseUrl;

@property (nonatomic, strong) NSString *cdnUrl;

@property (nonatomic, strong, readonly) NSArray<id<GRUrlFilterProtocol>> *urlFilters;

@property (nonatomic, strong, readonly) NSArray<id<GRCacheDirPathFilterProtocol>> *cacheDirPathFilters;

@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

@property (nonatomic, assign) BOOL debugLogEnabled;

@property (nonatomic, strong) NSURLSessionConfiguration* sessionConfiguration;

- (void)addUrlFilter:(id<GRUrlFilterProtocol>)filter;

- (void)clearUrlFilter;

- (void)addCacheDirPathFilter:(id<GRCacheDirPathFilterProtocol>)filter;

- (void)clearCacheDirPathFilter;

@end

NS_ASSUME_NONNULL_END
