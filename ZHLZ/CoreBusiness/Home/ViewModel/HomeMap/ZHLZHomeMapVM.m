//
//  ZHLZHomeMapVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMapVM.h"
#import "ZHLZHomeMapModel.h"

@implementation ZHLZHomeMapVM

+ (instancetype)sharedInstance {
    static id homeMapVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeMapVM = [[self alloc] init];
    });
    return homeMapVM;
}

- (NSURLSessionTask *)loadHomeMapDataWithName:(NSString *)name withBid:(NSString *)bid withProjecttypeId:(NSString *)projecttypeId withBlock:(void (^)(NSArray<ZHLZHomeMapModel *> *homeMapArray))block {
    id requestArgument = @{@"name": name?:@"", @"bid": bid?:@"", @"projecttypeId": projecttypeId?:@""};
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:MapDisplayAPIURLConst withRequestArgument:requestArgument];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZHomeMapModel *> *homeMapArray = nil;
        if (response && response.data && [response.data objectForKey:@"list"]) {
            homeMapArray = [NSArray modelArrayWithClass:[ZHLZHomeMapModel class] json:[response.data objectForKey:@"list"]];
        }
        block(homeMapArray);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
