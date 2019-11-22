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
    baseVM.isIgnoreLoading = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZBrigadeModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZBrigadeModel class] json:response.data];
        }
        if (array && array.count > 0) {
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
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:BrigadeAPIURLConst withRequestArgument:@{@"orgid": orgId}];
    baseVM.isIgnoreLoading = YES;
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZAreaModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZAreaModel class] json:response.data];
        }
        if (array && array.count > 0) {
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
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:CodeValuesAPIURLConst withRequestArgument:@{@"codeName": @"blong"}];
    baseVM.isIgnoreLoading = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZDistrictModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZDistrictModel class] json:response.data];
        }
        if (array && array.count > 0) {
            ZHLZDistrictModel *model = [ZHLZDistrictModel new];
            model.value = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)getProjectTypeWithBlock:(void(^)(NSArray<ZHLZProjectTypeModel *> *array))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:CodeValuesAPIURLConst withRequestArgument:@{@"codeName": @"projecttype"}];
    baseVM.isIgnoreLoading = YES;
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZProjectTypeModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZProjectTypeModel class] json:response.data];
        }
        if (array && array.count > 0) {
            ZHLZProjectTypeModel *model = [ZHLZProjectTypeModel new];
            model.value = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

- (NSURLSessionTask *)getProjectStatusWithBlock:(void(^)(NSArray<ZHLZCodeValuesModel *> *array))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:CodeValuesAPIURLConst withRequestArgument:@{@"codeName": @"projectstatus"}];
    baseVM.isIgnoreLoading = YES;
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZCodeValuesModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZCodeValuesModel class] json:response.data];
        }
        if (array && array.count > 0) {
            ZHLZCodeValuesModel *model = [ZHLZCodeValuesModel new];
            model.value = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
