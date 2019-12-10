//
//  GRResponse.h
//  GRNetworking
//
//  Created by liujinhe on 2019/10/15.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GRBaseRequest;

@interface GRResponse : NSObject

@property (nonatomic, strong) GRBaseRequest *request;

@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSError *error;

@property (nonatomic, assign) NSInteger resultStatus;
@property (nonatomic, strong) id result;

@end

NS_ASSUME_NONNULL_END
