//
//  ZHLZMineVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZMineVM.h"
#import "ZHLZUserManager.h"
#import "ZHLZUserModel.h"

@implementation ZHLZMineVM

+ (instancetype)sharedInstance {
    static id mineVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mineVM = [[self alloc] init];
    });
    return mineVM;
}



- (NSURLSessionTask *)getUserInfoCallBack:(void (^)(ZHLZMineModel *mineModel))block{
    ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
    if (!userModel || ![userModel.userId isNotBlank]) {
        return nil;
    }
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:UserInfoAPIURLConst withRequestArgument:userModel.userId];
    baseVM.isRequestArgumentSlash = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response && response.data) {
            ZHLZMineModel *mineModel = [ZHLZMineModel modelWithJSON:response.data];
            block(mineModel);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

- (NSURLSessionTask *)changePasswordWitParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ChangeUserPwdAPIURLConst];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}
@end
