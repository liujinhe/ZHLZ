//
//  ZHLZHomeCarVideoVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/12/10.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCarVideoVM.h"

#define kBaseUrl (BaseAPICarVideoPortConst > 0 ? [BaseAPICarVideoIPConst stringByAppendingString:[NSString stringWithFormat:@":%d", BaseAPICarVideoPortConst]] : BaseAPICarVideoIPConst)

@implementation ZHLZHomeCarVideoVM

+ (instancetype)sharedInstance {
    static id homeCarVideoVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeCarVideoVM = [[self alloc] init];
    });
    return homeCarVideoVM;
}

- (NSURLSessionTask *)sessionLoginWithAccount:(NSString *)account withPwd:(NSString *)pwd withBlock:(void (^)(NSString *session))block {
    NSString *requestUrl = [kBaseUrl stringByAppendingString:@"/StandardApiAction_login.action"];
    id requestArgument = @{@"account":account,
                           @"password":pwd};
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:requestUrl
                                            withRequestArgument:requestArgument];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSString *session = nil;
        if (response && response.resultStatus == 0 && response.result) {
            session = [response.result objectForKey:@"jsession"];
        }
        block(session);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)sessionLogoutWithSession:(NSString *)session {
    NSString *requestUrl = [kBaseUrl stringByAppendingString:@"/StandardApiAction_logout.action"];
    id requestArgument = @{@"jsession":session};
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:requestUrl
                                            withRequestArgument:requestArgument];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

- (NSURLSessionTask *)getVehicleInfoWithSession:(NSString *)session withBlock:(void (^)(NSArray<ZHLZVehicleInfoModel *> *array))block {
    NSString *requestUrl = [kBaseUrl stringByAppendingString:@"/StandardApiAction_queryUserVehicle.action"];
    id requestArgument = @{@"jsession":session};
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:requestUrl
                                            withRequestArgument:requestArgument];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZVehicleInfoModel *> *array = nil;
        if (response && response.resultStatus == 0 && response.result && [response.result objectForKey:@"vehicles"]) {
            array = [NSArray modelArrayWithClass:[ZHLZVehicleInfoModel class] json:[response.result objectForKey:@"vehicles"]];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)getDeviceStatusWithSession:(NSString *)session withDeviceId:(NSString *)deviceId withPlateNo:(nullable NSString *)plateNo withBlock:(void (^)(NSArray<ZHLZDeviceStatusModel *> *array))block {
    NSString *requestUrl = [kBaseUrl stringByAppendingString:@"/StandardApiAction_getDeviceOlStatus.action"];
    id requestArgument = @{@"jsession":session,
                           @"devIdno":deviceId,
                           @"vehiIdno":plateNo?:@""};
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:requestUrl
                                            withRequestArgument:requestArgument];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZDeviceStatusModel *> *array = nil;
        if (response && response.resultStatus == 0 && response.result && [response.result objectForKey:@"onlines"]) {
            array = [NSArray modelArrayWithClass:[ZHLZDeviceStatusModel class] json:[response.result objectForKey:@"onlines"]];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
