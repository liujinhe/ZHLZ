//
//  ZHLZHomeOccupyProblemVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeOccupyProblemVM.h"

@implementation ZHLZHomeOccupyProblemVM

+ (instancetype)sharedInstance {
    static id homeOccupyProblemVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeOccupyProblemVM = [[self alloc] init];
    });
    return homeOccupyProblemVM;
}

- (NSURLSessionTask *)loadHomeOccupyProblemDataWithPageNo:(NSInteger)pageNo withModel:(ZHLZHomeOccupyProblemSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeOccupyProblemModel *> *array))block {
    NSDictionary *requestArgument = [model modelToJSONObject];
    [requestArgument setValue:@(pageNo) forKey:@"page"];
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:OccupyProblemAPIURLConst withRequestArgument:requestArgument];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZHomeOccupyProblemModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZHomeOccupyProblemModel class] json:[response.data objectForKey:@"list"]];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)loadHomeOccupyProblemDetailWithId:(NSString *)detailId WithBlock:(void (^)(ZHLZHomeOccupyProblemDetailModel *occupyProblemDetailModel))block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:OccupyProblemInfoAPIURLConst withRequestArgument:detailId];
    baseVM.isRequestArgumentSlash = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            ZHLZHomeOccupyProblemDetailModel *occupyProblemDetailModel = [ZHLZHomeOccupyProblemDetailModel modelWithJSON:response.data];
            block(occupyProblemDetailModel);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

- (NSURLSessionTask *)submitHomeSafeProblemWithSubmitArray:(NSArray *)submitArray andSubmitType:(NSInteger)type withBlock:(dispatch_block_t)block{
    
    NSString *urlString = OccupyProblemSaveAPIURLConst;
    if (type == 3) {
        urlString = OccupyProblemUpdateAPIURLConst;
    }
    
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:urlString withRequestArgument:[submitArray modelToJSONObject]];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

@end
