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
    NSArray *isLoadListArray = @[@(YES),
                                 @(YES),
                                 @(YES),
                                 @(YES)];
    ZHLZBaseBatchVM *baseBatchVM = [[ZHLZBaseBatchVM alloc] initWithRequestUrlArray:apiURLArray withIsLoadListArray:isLoadListArray];
    [baseBatchVM requestCompletionWithSuccess:^(NSMutableArray<GRResponse *> * _Nonnull responseArray) {
        block(responseArray);
    } withFailure:^(NSMutableArray<GRResponse *> * _Nonnull responseArray) {
        block(nil);
    }];
    return self.requestTask;
}

@end
