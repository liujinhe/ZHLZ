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

- (NSURLSessionTask *)loadHomeBuildProjectDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeBuildProjectModel *> *homeBuildProjectModelArray))block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ProjectBuildeListAPIURLConst withRequestArgument:@{@"page":@(pageNum),@"limit":@(10),@"order":@"desc",@"sidx":@""}];
    baseVM.isList = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            NSArray *homeBuildProjectModelArray = [NSArray modelArrayWithClass:[ZHLZHomeBuildProjectModel class] json:[response.data objectForKey:@"list"]];
            block(homeBuildProjectModelArray);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}


@end
