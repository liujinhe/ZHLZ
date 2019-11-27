//
//  ZHLZHomeRoadPatrolVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeRoadPatrolVM.h"

@implementation ZHLZHomeRoadPatrolVM

+ (instancetype)sharedInstance {
    static id homeRoadPatrolVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeRoadPatrolVM = [[self alloc] init];
    });
    return homeRoadPatrolVM;
}

- (NSURLSessionTask *)loadHomeRoadPatrolWithPageNo:(NSInteger)pageNo withStartDate:(NSString *)startDate withEndDate:(NSString *)endDate withBlock:(void (^)(NSArray<ZHLZHomeRoadPatrolModel *> *array))block {
    NSMutableDictionary *requestArgument = @{@"page": @(pageNo), @"expstartdate": startDate, @"expenddate": endDate}.mutableCopy;
    if (![ZHLZUserManager sharedInstance].isSuperAdmin) {
        [requestArgument setValue:[ZHLZUserManager sharedInstance].user.orgId forKey:@"orgid"];
    }
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:RoadPatrolSummaryAPIURLConst withRequestArgument:requestArgument];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZHomeRoadPatrolModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZHomeRoadPatrolModel class] json:[response.data objectForKey:@"list"]];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
