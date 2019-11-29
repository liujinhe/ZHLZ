//
//  ZHLZHomeScanCodeUseCarVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeScanCodeUseCarVM.h"

@implementation ZHLZHomeScanCodeUseCarVM

+ (instancetype)sharedInstance {
    static id scanCodeUseCarVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scanCodeUseCarVM = [[self alloc] init];
    });
    return scanCodeUseCarVM;
}

- (NSURLSessionTask *)scanCodeUseCarWithParms:(NSDictionary *)parms withBlock:(dispatch_block_t)block {
    
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ScanCodeUseCarAPIURLConst withRequestArgument:parms];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

- (NSURLSessionTask *)scanCodeRepayCarWithParms:(NSDictionary *)parms withBlock:(dispatch_block_t)block {

    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ScanCodeRepayCarAPIURLConst withRequestArgument:parms];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

@end
