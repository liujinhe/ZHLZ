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

- (NSURLSessionTask *)loadHomeSafeDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeSafeModel *> *homeSafeModelArray))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SafeFloodPreventionInfoAPIURLConst withRequestArgument:@{@"page":@(pageNum)}];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray *homeSafeModelArray = nil;
        if (response.data) {
            homeSafeModelArray = [NSArray modelArrayWithClass:[ZHLZHomeSafeModel class] json:[response.data objectForKey:@"list"]];
        }
        block(homeSafeModelArray);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}


- (NSURLSessionTask *)loadHomeSafeDataId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeSafeModel *homeSafeModel))block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:SafeFloodPreventionDetailAPIURLConst withRequestArgument:detailId];
    baseVM.isRequestArgumentSlash = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            ZHLZHomeSafeModel *safeModel = [ZHLZHomeSafeModel modelWithJSON:response.data];
            block(safeModel);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}


- (NSURLSessionTask *)submitHomeSafeWithSubmitType:(NSInteger)submitType andSubmitModel:(ZHLZSafeSubmitModel *)submitModel withBlock:(dispatch_block_t)block {
    
    NSString *urlString  = SafeFloodPreventionSaveAPIURLConst;
    if (submitType == 3) {
        urlString  = SafeFloodPreventionUpdateAPIURLConst;
    }
    
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:urlString withRequestArgument:[submitModel modelToJSONObject]];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}



@end
