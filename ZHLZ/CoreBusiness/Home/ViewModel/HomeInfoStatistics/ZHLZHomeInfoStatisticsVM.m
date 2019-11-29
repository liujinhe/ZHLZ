//
//  ZHLZHomeInfoStatisticsVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeInfoStatisticsVM.h"

@implementation ZHLZHomeInfoStatisticsVM

+ (instancetype)sharedInstance {
    static id homeInfoStatisticsVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeInfoStatisticsVM = [[self alloc] init];
    });
    return homeInfoStatisticsVM;
}

- (NSURLSessionTask *)loadHomeInfoStatisticsDataWithType:(NSInteger)type withBlock:(void (^)(NSArray<ZHLZHomeInfoStatisticsModel *> *array))block {
    NSMutableDictionary *requestArgument = @{}.mutableCopy;
    switch (type) {
        case 1: // 周
            [requestArgument setValue:@"1" forKey:@"week"];
            break;
        case 2: // 月
            [requestArgument setValue:@"1" forKey:@"month"];
            break;
        case 3: // 季度
            [requestArgument setValue:@"1" forKey:@"quarter"];
            break;
        default: // 日
            [requestArgument setValue:@"1" forKey:@"day"];
            break;
    }
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SummaryStatisticsAPIURLConst
                                              withRequestMethod:GRRequestMethodGET
                                            withRequestArgument:requestArgument];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZHomeInfoStatisticsModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZHomeInfoStatisticsModel class] json:response.data];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
