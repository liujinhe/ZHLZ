//
//  ZHLZHomeSafeProblemVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemVM.h"

@implementation ZHLZHomeSafeProblemVM

+ (instancetype)sharedInstance {
    static id homeSafeProblemVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeSafeProblemVM = [[self alloc] init];
    });
    return homeSafeProblemVM;
}

- (NSURLSessionTask *)loadHomeSafeProblemDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeSafeProblemModel *> *homeSafeProblemArray))block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SafeFloodPreventionProblemInfoAPIURLConst withRequestArgument:@{@"page":@(pageNum), @"limit":@(10), @"order":@"desc", @"sidx":@""}];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray *homeSafeProblemArray = nil;
        if (response.data) {
            homeSafeProblemArray = [NSArray modelArrayWithClass:[ZHLZHomeSafeProblemModel class] json:[response.data objectForKey:@"list"]];
        }
        block(homeSafeProblemArray);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

- (NSURLSessionTask *)loadHomeSafeProblemDetailWithId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeSafeProblemModel *homeSafeProblem))block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SafeFloodPreventionProblemDetailAPIURLConst withRequestArgument:detailId];
    baseVM.isRequestArgumentSlash = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            ZHLZHomeSafeProblemModel *detailModel = [ZHLZHomeSafeProblemModel modelWithJSON:response.data];
            block(detailModel);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

- (NSURLSessionTask *)loadHomeSafeFloodPreventionProblemGetMeasuresWithBlock:(void (^)(ZHLZHomeSafeProblemModel *homeSafeProblem))block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SafeFloodPreventionProblemGetMeasuresAPIURLConst];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            ZHLZHomeSafeProblemModel *detailModel = [ZHLZHomeSafeProblemModel modelWithJSON:response.data];
            block(detailModel);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

//

@end
