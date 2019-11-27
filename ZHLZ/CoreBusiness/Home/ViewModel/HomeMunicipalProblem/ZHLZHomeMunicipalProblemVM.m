//
//  ZHLZHomeMunicipalProblemVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMunicipalProblemVM.h"

@implementation ZHLZHomeMunicipalProblemVM

+ (instancetype)sharedInstance {
    static id homeMunicipalProblemVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeMunicipalProblemVM = [[self alloc] init];
    });
    return homeMunicipalProblemVM;
}

- (NSURLSessionTask *)loadHomeMunicipalProblemDataWithPageNo:(NSInteger)pageNo withModel:(ZHLZHomeMunicipalProblemSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeMunicipalProblemModel *> *array))block {
    NSDictionary *requestArgument = [model modelToJSONObject];
    [requestArgument setValue:@(pageNo) forKey:@"page"];
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:MunicipalProblemAPIURLConst withRequestArgument:requestArgument];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZHomeMunicipalProblemModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZHomeMunicipalProblemModel class] json:[response.data objectForKey:@"list"]];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
