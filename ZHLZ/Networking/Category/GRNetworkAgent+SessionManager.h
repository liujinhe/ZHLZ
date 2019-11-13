//
//  GRNetworkAgent+SessionManager.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRNetworkAgent.h"

NS_ASSUME_NONNULL_BEGIN

@interface GRNetworkAgent (SessionManager)

- (AFHTTPSessionManager *)manager;

- (void)resetURLSessionManager;

- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *)configuration;

- (NSString *)incompleteDownloadTempCacheFolder;

@end

NS_ASSUME_NONNULL_END
