//
//  ZHLZHomeBuildProjectVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectVM.h"

@implementation ZHLZHomeBuildProjectVM

+ (instancetype)sharedInstance {
    static id homeBuildProject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeBuildProject = [[self alloc] init];
    });
    return homeBuildProject;
}

- (NSURLSessionTask *)loadHomeBuildProjectDataWithPageNum:(NSInteger)pageNum withModel:(nullable ZHLZBuildProjectSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeBuildProjectModel *> *homeBuildProjectModelArray))block {
    NSMutableDictionary *requestArgument = model ? [model modelToJSONObject] : @{}.mutableCopy;
    [requestArgument setValue:@(pageNum) forKey:@"page"];
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ProjectBuildeListAPIURLConst withRequestArgument:requestArgument];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray *homeBuildProjectModelArray = nil;
        if (response && response.data) {
            homeBuildProjectModelArray = [NSArray modelArrayWithClass:[ZHLZHomeBuildProjectModel class] json:[response.data objectForKey:@"list"]];
        }
        block(homeBuildProjectModelArray);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)loadHomeBuildProjectDataId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeBuildProjectModel *homeBuildProjectModel))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ProjectBuildeDetailAPIURLConst withRequestArgument:detailId];
    baseVM.isRequestArgumentSlash = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            ZHLZHomeBuildProjectModel *homeBuildProjectModel = [ZHLZHomeBuildProjectModel modelWithJSON:response.data];
            block(homeBuildProjectModel);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

- (NSURLSessionTask *)submitHomeBuildProjectSubmitType:(NSInteger)submitType andSubmitModel:(ZHLZHomeBuildProjectSubmitModel *)projectSubmitModel withBlock:(dispatch_block_t)block {
    
    NSString *urlString  = ProjectBuildeDetailSaveAPIURLConst;
    if (submitType == 3) {
        urlString  = ProjectBuildeDetailUpdateAPIURLConst;
    }
    
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:urlString withRequestArgument:[projectSubmitModel modelToJSONObject]];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

@end
