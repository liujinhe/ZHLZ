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

- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
    if (userModel) {
        return @{@"Token":userModel.encryptionKey};
    } else {
        return nil;
    }
}

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

- (void)setIsList:(BOOL)isList {
    _isList = isList;
    
    NSMutableDictionary *param = _requestParam ? (NSMutableDictionary *)_requestParam : @{}.mutableCopy;
    if (_isList) {
        if ([param objectForKey:@"page"] == nil) {
            [param setValue:@(1) forKey:@"page"];
        }
        if ([param objectForKey:@"limit"] == nil) {
            [param setValue:@(10) forKey:@"limit"];
        }
        if ([param objectForKey:@"order"] == nil) {
            [param setValue:@"desc" forKey:@"order"];
        }
        if ([param objectForKey:@"sidx"] == nil) {
            [param setValue:@"" forKey:@"sidx"];
        }
    }
    NSString *paramStr = @"";
    for (NSString *key in param.allKeys) {
        paramStr = [paramStr stringByAppendingFormat:@"%@=%@&", key, [param objectForKey:key]];
    }
    if ([paramStr isNotBlank]) {
        _url = [_url stringByAppendingFormat:@"?%@", [paramStr substringToIndex:(paramStr.length - 1)]];
    }
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
        if (response.status != 0) {
            [GRToast makeText:response.message];
        }
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismissWithDelay:0.25f];
        }
    }];
    return self.requestTask;
}

@end
