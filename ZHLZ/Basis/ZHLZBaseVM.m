//
//  ZHLZBaseVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

#import <SVProgressHUD/SVProgressHUD.h>

@implementation ZHLZBaseVM
{
    NSString *_url;
    GRRequestMethod _method;
    id _requestParam;
}

- (NSString *)baseUrl {
    return BaseAPIURLConst;
}

- (NSString *)requestUrl {
    return _url;
}

- (GRRequestMethod)requestMethod {
    return _method;
}

- (id)requestArgument {
    return _requestParam;
}

//- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
//    return @{@"Content-Type": @"application/json"};
//}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl {
    return [self initWithRequestUrl:requestUrl withRequestMethod:GRRequestMethodPOST withRequestArgument:nil];
}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
               withRequestArgument:(id)requestArgument {
    return [self initWithRequestUrl:requestUrl withRequestMethod:GRRequestMethodPOST withRequestArgument:requestArgument];
}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                 withRequestMethod:(GRRequestMethod)requestMethod
               withRequestArgument:(nullable id)requestArgument {
    self = [self init];
    if (self) {
        _url = requestUrl;
        _method = requestMethod;
        _requestParam = requestArgument;
    }
    return self;
}

- (NSURLSessionTask *)requestCompletionWithSuccess:(GRResponseCompletionBlock)success
                                       withFailure:(GRResponseCompletionBlock)failure {
    if (!self.isIgnoreLoading) {
        [SVProgressHUD show];
    }
    [self startWithCompletionBlockWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.status == 0) {
            success(response);
        } else {
            [GRToast makeText:response.message];
        }
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismissWithDelay:0.25f];
        }
    } failure:^(__kindof GRResponse * _Nonnull response) {
        failure(response);
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismissWithDelay:0.25f];
        }
    }];
    return self.requestTask;
}

@end
