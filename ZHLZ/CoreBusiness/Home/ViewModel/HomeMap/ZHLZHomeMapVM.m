//
//  ZHLZHomeMapVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMapVM.h"
#import "ZHLZHomeMapModel.h"
#import "ZHLZHomeMapProblemModel.h"

@implementation ZHLZHomeMapVM

+ (instancetype)sharedInstance {
    static id homeMapVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeMapVM = [[self alloc] init];
    });
    return homeMapVM;
}

- (NSURLSessionTask *)loadHomeMapDataWithpicLayer:(NSInteger)picLayer withName:(NSString *)name withBid:(NSString *)bid withProjecttypeId:(NSString *)projecttypeId withBlock:(void (^)(NSArray<ZHLZHomeMapModel *> *homeMapArray, NSArray<ZHLZHomeMapProblemModel *> *homeMapProblemArray))block {
    id requestArgument = @{@"name": name?:@"", @"bid": bid?:@"", @"projecttypeId": projecttypeId?:@""};
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:(picLayer == 1 ? MapDisplayMunicipalProblemAPIURLConst : MapDisplayAPIURLConst) withRequestArgument:requestArgument];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZHomeMapProblemModel *> *homeMapProblemArray = nil;
        NSArray<ZHLZHomeMapModel *> *homeMapArray = nil;
        if (response && response.data && [response.data objectForKey:@"list"]) {
            if (picLayer == 1) {
                homeMapProblemArray = [NSArray modelArrayWithClass:[ZHLZHomeMapProblemModel class] json:[response.data objectForKey:@"list"]];
            } else {
                homeMapArray = [NSArray modelArrayWithClass:[ZHLZHomeMapModel class] json:[response.data objectForKey:@"list"]];
            }
        }
        block(homeMapArray, homeMapProblemArray);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil, nil);
    }];
}

@end
