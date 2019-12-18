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

- (NSURLSessionTask *)getListWithType:(NSInteger)type withBlock:(void (^)(NSArray<ZHLZCodeValuesModel *> *array))block {
    NSString *codeName;
    switch (type) {
        case 1: // 是否重点
            codeName = @"focusproject";
            break;
        case 2: // 施工状态
            codeName = @"projectstatus";
            break;
        case 3: // 巡查频次
            codeName = @"frequency";
            break;
        case 4: // 工程类型
            codeName = @"projecttype";
            break;
        case 5: // 责任所属区县
            codeName = @"blong";
            break;
        case 6: // 上级交办、舆情及应急处理
            codeName = @"whether";
            break;
        case 7: // 问题类型
            codeName = @"protype";
            break;
        case 8: // 市政问题类型
            codeName = @"instype";
            break;
    }
    if (![codeName isNotBlank]) {
        return nil;
    }
    
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:CodeValuesAPIURLConst withRequestArgument:@{@"codeName": codeName}];
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

- (NSURLSessionTask *)getTransactedPersonWithBlock:(void(^)(NSArray<ZHLZTransactedPersonModel *> *array))block {
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:TransactedPersonAPIURLConst];
    baseVM.isIgnoreLoading = YES;
    baseVM.isRequestArgument = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        NSArray<ZHLZTransactedPersonModel *> *array = nil;
        if (response && response.data) {
            array = [NSArray modelArrayWithClass:[ZHLZTransactedPersonModel class] json:response.data];
        }
        if (array && array.count > 0) {
            ZHLZTransactedPersonModel *model = [ZHLZTransactedPersonModel new];
            model.fullname = SelectDefaultValue;
            array = [@[model] arrayByAddingObjectsFromArray:array];
        }
        block(array);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        block(nil);
    }];
}

@end
