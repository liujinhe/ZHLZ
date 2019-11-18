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
    if (self.isList) {
        if (_requestParam == nil) {
            _requestParam = @{}.mutableCopy;
        }
        if ([_requestParam objectForKey:@"page"] == nil) {
            [_requestParam setValue:@(1) forKey:@"page"];
        }
        if ([_requestParam objectForKey:@"limit"] == nil) {
            [_requestParam setValue:@(10) forKey:@"limit"];
        }
        if ([_requestParam objectForKey:@"order"] == nil) {
            [_requestParam setValue:@"desc" forKey:@"order"];
        }
        if ([_requestParam objectForKey:@"sidx"] == nil) {
            [_requestParam setValue:@"" forKey:@"sidx"];
        }
    }
    NSString *paramStr = @"";
    for (NSString *key in ((NSDictionary *)_requestParam).allKeys) {
        paramStr = [paramStr stringByAppendingFormat:@"%@=%@&", key, [_requestParam objectForKey:key]];
    }
    if ([paramStr isNotBlank]) {
        _url = [_url stringByAppendingFormat:@"?%@", [paramStr substringToIndex:(paramStr.length - 1)]];
    }
    return _requestParam;
}

- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
    if (userModel) {
        return @{@"token":userModel.encryptionKey};
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
