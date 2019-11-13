//
//  GRNetworkUtils.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface GRNetworkUtils : NSObject

+ (BOOL)validateJSON:(id)json withValidator:(id)jsonValidator;

+ (void)addDoNotBackupAttribute:(NSString *)path;

+ (NSString *)md5StringFromString:(NSString *)string;

+ (NSString *)appVersionString;

+ (NSStringEncoding)stringEncodingWithRequest:(GRBaseRequest *)request;

+ (BOOL)validateResumeData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
