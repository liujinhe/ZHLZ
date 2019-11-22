//
//  ZHLZHomeSafeVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeVM.h"

@implementation ZHLZHomeSafeVM

+ (instancetype)sharedInstance {
    static id homeSafe = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeSafe = [[self alloc] init];
    });
    return homeSafe;
}

- (NSURLSessionTask *)loadHomeSafeDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeSafeModel *> *homeSafeModelArray))block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SafeFloodPreventionInfoAPIURLConst withRequestArgument:@{@"page":@(pageNum), @"limit":@(10), @"order":@"desc", @"sidx":@""}];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            NSArray *homeSafeModelArray = [NSArray modelArrayWithClass:[ZHLZHomeSafeModel class] json:[response.data objectForKey:@"list"]];
            block(homeSafeModelArray);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}


@end
