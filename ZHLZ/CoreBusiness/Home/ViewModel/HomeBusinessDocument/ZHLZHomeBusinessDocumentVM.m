//
//  ZHLZHomeBusinessDocumentVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBusinessDocumentVM.h"

@implementation ZHLZHomeBusinessDocumentVM

+ (instancetype)sharedInstance {
    static id businessDocument = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        businessDocument = [[self alloc] init];
    });
    return businessDocument;
}


- (NSURLSessionTask *)loadHomeBusinessDocumentDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeBusinessDocumentModel *> *homeBusinessDocumentModel))block{
    
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:DocumentListAPIURLConst withRequestArgument:@{@"page":@(pageNum), @"limit":@(10), @"order":@"desc", @"sidx":@""}];
    baseVM.isDefaultArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        if (response.data) {
            NSArray *homeBusinessDocumentModel = [NSArray modelArrayWithClass:[ZHLZHomeBusinessDocumentModel class] json:[response.data objectForKey:@"list"]];
            block(homeBusinessDocumentModel);
        }
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

@end
