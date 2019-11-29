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

- (NSURLSessionTask *)loadHomeSafeProblemDataWithPageNum:(NSInteger)pageNum withModel:(ZHLZHomeSafeProblemSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeSafeProblemModel *> *homeSafeProblemArray))block {
    NSMutableDictionary *requestArgument = model ? [model modelToJSONObject] : @{}.mutableCopy;
    [requestArgument setValue:@(pageNum) forKey:@"page"];
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SafeFloodPreventionProblemInfoAPIURLConst withRequestArgument:requestArgument];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray *homeSafeProblemArray = nil;
        if (response && response.data) {
            homeSafeProblemArray = [NSArray modelArrayWithClass:[ZHLZHomeSafeProblemModel class] json:[response.data objectForKey:@"list"]];
        }
        block(homeSafeProblemArray);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
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

- (NSURLSessionTask *)submitHomeSafeProblemWithSubmitType:(NSInteger)submitType andSubmitArray:(NSArray *)submitArray withBlock:(dispatch_block_t)block {
    
    NSString *urlString  = SafeFloodPreventionProblemSaveAPIURLConst;
    if (submitType == 3) {
        urlString  = SafeFloodPreventionProblemUpdateAPIURLConst;
    }
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:urlString withRequestArgument:[submitArray modelToJSONObject]];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

- (NSURLSessionTask *)loadHomeSafeFloodPreventionProblemGetMeasuresWithId:(NSString *)Id withType:(NSInteger)type Block:(void (^)(NSArray <ZHLZSupervisorSubmitModel *> *supervisorSubmitModelArray))block{
    
    NSString *urlString = @"";
    if (type == 1) {
        urlString = OccupyProblemGetMeasuresAPIURLConst;
    }
    
    else if (type == 2){
        urlString = MunicipalProblemGetMeasuresAPIURLConst;
    }
    
    else if (type == 3) {
        urlString = SafeFloodPreventionProblemGetMeasuresAPIURLConst;
    }
    
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:urlString withRequestArgument:@{@"id":Id}];
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            NSArray *supervisorSubmitModelArray = [NSArray modelArrayWithClass:[ZHLZSupervisorSubmitModel class] json:response.data];
            block(supervisorSubmitModelArray);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}


@end
