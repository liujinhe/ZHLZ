//
//  ZHLZHomeVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeVM.h"
#import "GRBatchRequest.h"

@implementation ZHLZHomeVM

+ (instancetype)sharedInstance {
    static id homeVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeVM = [[self alloc] init];
    });
    return homeVM;
}

- (NSURLSessionTask *)loadDataWithBlock:(void (^)(NSMutableArray<GRResponse *> *responseArray))block {
    NSArray *apiURLArray = @[HomeBannerAPIURLConst,
                             HomeBulletinAPIURLConst,
                             HomeOccupyProblemAPIURLConst,
                             HomeMunicipalProblemAPIURLConst];
    NSMutableArray<GRRequest *> *requestArray = @[].mutableCopy;
    for (NSInteger i = 0; i < apiURLArray.count; i++) {
        ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:apiURLArray[i]];
        baseVM.isList = YES;
        [requestArray addObject:baseVM];
    }
    GRBatchRequest *batchRequest = [[GRBatchRequest alloc] initWithRequestArray:requestArray.copy];
    [batchRequest startWithCompletionBlockWithSuccess:^(GRBatchRequest * _Nonnull batchRequest) {
        NSMutableArray<GRResponse *> *responseArray = @[].mutableCopy;
        for (GRRequest *request in batchRequest.requestArray) {
            if (request && request.responseObject) {
                [responseArray addObject:[GRResponse modelWithJSON:request.responseObject]];
            }
        }
        block(responseArray);
    } failure:^(GRBatchRequest * _Nonnull batchRequest) {
        block(nil);
    }];
    return self.requestTask;
}

@end
