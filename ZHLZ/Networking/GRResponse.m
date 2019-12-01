//
//  GRResponse.m
//  GRNetworking
//
//  Created by liujinhe on 2019/10/15.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRResponse.h"
#import "GRBaseRequest.h"

@implementation GRResponse

- (void)setRequest:(GRBaseRequest *)request {
    if (request && request.responseObject) {
        _data = [request.responseObject objectForKey:@"data"]?:nil;
        _message = [request.responseObject objectForKey:@"msg"]?:@"";
        _status = [[request.responseObject objectForKey:@"code"] integerValue];
    }
    if (request.error) {
        _error = request.error;
    }
    
    if (_status != 0) {
        _error = [NSError errorWithDomain:BaseAPIURLConst code:_status userInfo:nil];
    }
}

@end
