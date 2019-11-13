//
//  ZHLZLoginVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZLoginVM.h"
#import "ZHLZLoginModel.h"

#import "ZHLZUserManager.h"

@implementation ZHLZLoginVM

+ (instancetype)sharedInstance {
    static id loginVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginVM = [[self alloc] init];
    });
    return loginVM;
}

- (NSURLSessionTask *)loginWithModel:(ZHLZLoginModel *)model
                 withCompletionBlock:(dispatch_block_t)block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:LoginAPIURLConst
                                            withRequestArgument:[model modelToJSONObject]];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response && response.data) {
            [[ZHLZUserManager sharedInstance] saveUserWithJson:response.data];
        }
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

@end
