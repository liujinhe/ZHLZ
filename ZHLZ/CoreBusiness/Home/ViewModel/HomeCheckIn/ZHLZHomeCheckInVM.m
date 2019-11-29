//
//  ZHLZHomeCheckInVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCheckInVM.h"

@implementation ZHLZHomeCheckInVM

+ (instancetype)sharedInstance {
    static id homeCheckInVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeCheckInVM = [[self alloc] init];
    });
    return homeCheckInVM;
}

- (NSURLSessionTask *)checkInDataWithType:(NSString *)type withAddress:(NSString *)address WithBlock:(void (^)(void))block {
    NSString *userId = [ZHLZUserManager sharedInstance].user.userId;
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:CheckInPunchAPIURLConst
                                            withRequestArgument:@{@"userid":userId, @"type":type, @"address":address}];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

@end
