//
//  GRNetworkConfig.m
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRNetworkConfig.h"
#import "GRBaseRequest.h"

@implementation GRNetworkConfig {
    NSMutableArray <id<GRUrlFilterProtocol>> *_urlFilters;
    NSMutableArray <id<GRCacheDirPathFilterProtocol>> *_cacheDirPathFilters;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseUrl = @"";
        _cdnUrl = @"";
        _urlFilters = [NSMutableArray array];
        _cacheDirPathFilters = [NSMutableArray array];
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        _debugLogEnabled = NO;
    }
    return self;
}

+ (GRNetworkConfig *)sharedInstance {
    static id networkConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkConfig = [[self alloc] init];
    });
    return networkConfig;
}

- (void)addUrlFilter:(id<GRUrlFilterProtocol>)filter {
    [_urlFilters addObject:filter];
}

- (void)clearUrlFilter {
    [_urlFilters removeAllObjects];
}

- (void)addCacheDirPathFilter:(id<GRCacheDirPathFilterProtocol>)filter {
    [_cacheDirPathFilters addObject:filter];
}

- (void)clearCacheDirPathFilter {
    [_cacheDirPathFilters removeAllObjects];
}

- (NSArray<id<GRUrlFilterProtocol>> *)urlFilters {
    return [_urlFilters copy];
}

- (NSArray<id<GRCacheDirPathFilterProtocol>> *)cacheDirPathFilters {
    return [_cacheDirPathFilters copy];
}

#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>{ baseURL: %@ } { cdnURL: %@ }",
            NSStringFromClass([self class]),
            self,
            self.baseUrl,
            self.cdnUrl];
}

@end
