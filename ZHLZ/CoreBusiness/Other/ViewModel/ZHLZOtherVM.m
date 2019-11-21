//
//  ZHLZOtherVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZOtherVM.h"

static NSString * const SelectDefaultValue = @"---请选择---";

@implementation ZHLZOtherVM

+ (instancetype)sharedInstance {
    static id otherVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        otherVM = [[self alloc] init];
    });
    return otherVM;
}

- (NSURLSessionTask *)getBrigadeWithBlock:(void(^)(NSArray<ZHLZBrigadeModel *> *array))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:BrigadeAPIURLConst];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZBrigadeModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZBrigadeModel class] json:response.data];
            
            ZHLZBrigadeModel *model = [ZHLZBrigadeModel new];
            model.name = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)getAreaWithOrgId:(NSString *)orgId withBlock:(void(^)(NSArray<ZHLZAreaModel *> *array))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:[BrigadeAPIURLConst stringByAppendingFormat:@"?orgid=%@", orgId]];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZAreaModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZAreaModel class] json:response.data];
            
            ZHLZAreaModel *model = [ZHLZAreaModel new];
            model.name = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)getDistrictWithBlock:(void(^)(NSArray<ZHLZDistrictModel *> *array))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:BrigadeAPIURLConst];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZDistrictModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZDistrictModel class] json:response.data];
            
            ZHLZDistrictModel *model = [ZHLZDistrictModel new];
            model.name = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)getProjectTypeWithBlock:(void(^)(NSArray<ZHLZProjectTypeModel *> *array))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ProjectTypeAPIURLConst];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZProjectTypeModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZProjectTypeModel class] json:response.data];
            
            ZHLZProjectTypeModel *model = [ZHLZProjectTypeModel new];
            model.name = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
