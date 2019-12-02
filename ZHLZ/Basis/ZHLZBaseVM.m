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
    UIImage *_image;
    NSString *_imageName;
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

- (AFConstructingBlock)constructingBodyBlock {
    if (self->_image) {
        return ^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self->_image, 0.9)
                                        name:@"file"
                                    fileName:[self->_imageName stringByAppendingString:@".png"]
                                    mimeType:@"image/png"];
        };
    } else {
        return nil;
    }
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

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                   withUploadImage:(UIImage *)uploadImage
               withUploadImageName:(NSString *)uploadImageName
               withRequestArgument:(id)requestArgument {
    self = [self init];
    if (self) {
        _url = requestUrl;
        _method = GRRequestMethodPOST;
        _image = uploadImage;
        _imageName = uploadImageName;
        _requestParam = requestArgument;
    }
    return self;
}

- (void)setIsDefaultArgument:(BOOL)isDefaultArgument {
    _isDefaultArgument = isDefaultArgument;
    
    NSMutableDictionary *param = _requestParam ? ((NSDictionary *)_requestParam).mutableCopy : @{}.mutableCopy;
    if (_isDefaultArgument) {
        if ([param objectForKey:@"page"]) {
            [param setObject:[_requestParam objectForKey:@"page"] forKey:@"page"];
        } else {
            [param setObject:@(1) forKey:@"page"];
        }
        if ([param objectForKey:@"limit"]) {
            [param setObject:[_requestParam objectForKey:@"limit"] forKey:@"limit"];
        } else {
            [param setObject:@(10) forKey:@"limit"];
        }
        if ([param objectForKey:@"order"]) {
            [param setObject:[_requestParam objectForKey:@"order"] forKey:@"order"];
        } else {
            [param setObject:@"desc" forKey:@"order"];
        }
        if ([param objectForKey:@"sidx"]) {
            [param setObject:[_requestParam objectForKey:@"sidx"] forKey:@"sidx"];
        } else {
            [param setObject:@"" forKey:@"sidx"];
        }
    }
    NSString *paramStr = @"";
    for (NSString *key in param.allKeys) {
        paramStr = [paramStr stringByAppendingFormat:@"%@=%@&", key, [param objectForKey:key]];
    }
    if ([paramStr isNotBlank]) {
        paramStr = [paramStr substringToIndex:(paramStr.length - 1)];
        paramStr = [paramStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        _url = [_url stringByAppendingFormat:@"?%@", paramStr];
        _requestParam = nil;
    }
}

- (void)setIsRequestArgument:(BOOL)isRequestArgument {
    _isRequestArgument = isRequestArgument;
    
    if (_isRequestArgument && _requestParam) {
        NSString *paramStr = @"";
        for (NSString *key in ((NSDictionary *)_requestParam).allKeys) {
            paramStr = [paramStr stringByAppendingFormat:@"%@=%@&", key, [_requestParam objectForKey:key]];
        }
        if ([paramStr isNotBlank]) {
            paramStr = [paramStr substringToIndex:(paramStr.length - 1)];
            paramStr = [paramStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            _url = [_url stringByAppendingFormat:@"?%@", paramStr];
            _requestParam = nil;
        }
    }
}

- (void)setIsRequestArgumentSlash:(BOOL)isRequestArgumentSlash {
    _isRequestArgumentSlash = isRequestArgumentSlash;
    
    if (_isRequestArgumentSlash && [_requestParam isNotBlank]) {
        NSString *paramStr = [_requestParam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        _url = [_url stringByAppendingFormat:@"/%@", paramStr];
        _requestParam = nil;
    }
}

- (NSURLSessionTask *)requestCompletionWithSuccess:(GRResponseCompletionBlock)success
                                       withFailure:(GRResponseCompletionBlock)failure {
    if (!self.isIgnoreLoading) {
        [SVProgressHUD show];
    }
    [self startWithCompletionBlockWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismissWithDelay:0.25f];
        }
        if (response.status == 401) { // 请先登录
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotificationConst object:nil];
            return;
        } else {
            if (response.status != 0) {
                [GRToast makeText:response.message];
            }
        }
        success(response);
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
