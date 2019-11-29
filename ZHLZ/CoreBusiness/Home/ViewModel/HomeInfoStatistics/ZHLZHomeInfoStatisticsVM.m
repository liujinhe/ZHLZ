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

- (NSURLSessionTask *)loadHomeInfoStatisticsDataWithPageNo:(NSInteger)pageNo withType:(NSInteger)type {
    NSDictionary *requestArgument = @{@"page": @(pageNo)};
    switch (type) {
        case 1: // 周
            [requestArgument setValue:@"1" forKey:@"week"];
            break;
        case 2: // 月
            [requestArgument setValue:@"1" forKey:@"month"];
            break; // 季度
        case 3:
            [requestArgument setValue:@"1" forKey:@"quarter"];
            break;
        default: // 日
            [requestArgument setValue:@"1" forKey:@"day"];
            break;
    }
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SummaryStatisticsAPIURLConst withRequestArgument:requestArgument];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response && response.data) {
            
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

@end
