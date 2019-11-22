//
//  ZHLZBaseBatchVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseBatchVM.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation ZHLZBaseBatchVM

- (instancetype)initWithRequestUrlArray:(nullable NSArray *)requestUrlArray withIsLoadListArray:(nullable NSArray *)isLoadListArray {
    if (!requestUrlArray || requestUrlArray.count <= 0) {
        return nil;
    }
    NSMutableArray<GRRequest *> *requestArray = @[].mutableCopy;
    for (NSInteger i = 0; i < requestUrlArray.count; i++) {
        ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:requestUrlArray[i]];
        baseVM.isDefaultArgument = [isLoadListArray[i] boolValue];
        [requestArray addObject:baseVM];
    }
    return [self initWithRequestArray:requestArray.copy];
}

- (void)requestCompletionWithSuccess:(nullable void (^)(NSArray<GRResponse *> *responseArray))success
                         withFailure:(nullable void (^)(NSArray<GRResponse *> *responseArray))failure {
    if (!self.isIgnoreLoading) {
        [SVProgressHUD show];
    }
    [self startWithCompletionBlockWithSuccess:^(GRBatchRequest * _Nonnull batchRequest) {
        NSMutableArray<GRResponse *> *responseArray = @[].mutableCopy;
        for (GRRequest *request in batchRequest.requestArray) {
            GRResponse *response = [GRResponse new];
            response.request = request;
            if (response && response.status == 500) { // token 失效
                [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotificationConst object:nil];
                return;
            }
            [responseArray addObject:response];
        }
        success(responseArray.copy);
        
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismissWithDelay:0.25f];
        }
    } failure:^(GRBatchRequest * _Nonnull batchRequest) {
        failure(nil);
        
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismissWithDelay:0.25f];
        }
    }];
}

@end
