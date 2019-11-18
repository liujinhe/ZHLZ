//
//  ZHLZAddressBookVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZAddressBookVM.h"

@implementation ZHLZAddressBookVM
+ (instancetype)sharedInstance {
    static id addressBookVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        addressBookVM = [[self alloc] init];
    });
    return addressBookVM;
}

- (NSURLSessionTask *)loadListWithType:(NSInteger)type CallBack:(void (^)(NSDictionary *parms))block{
    
    NSString *requestString = @"";
    switch (type) {
        case 0:
            requestString = ConstructionUnitAPIURLConst;
            break;
        case 1:
            requestString = ApprovalDepartmentAPIURLConst;
        break;
            
        case 2:
            requestString = BuildUnitAPIURLConst;
        break;
            
        case 3:
            requestString = CityManagementUnitAPIURLConst;
        break;
            
        case 4:
            requestString = DistrictManagementUnitAPIURLConst;
        break;
            
        case 5:
            requestString = SpecialOwnerUnitAPIURLConst;
        break;
            
        case 6:
            requestString = ResponsibleUnitAPIURLConst;
        break;

        default:
            break;
    }

    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:requestString withRequestArgument:@{@"page":@(1),@"limit":@(10),@"order":@"desc",@"sidx":@""}];
    baseVM.isList = YES;
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block(response.data);
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
        
    }];
}

- (NSURLSessionTask *)operationWithUrl:(NSString *)url andParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:url withRequestArgument:parms];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}


- (NSURLSessionTask *)saveResponsibleunitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ResponsibleUnitSaveAPIURLConst withRequestArgument:parms];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

- (NSURLSessionTask *)editResponsibleunitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ResponsibleUnitUpdateAPIURLConst withRequestArgument:parms];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}

- (NSURLSessionTask *)deleteResponsibleunitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ResponsibleUnitDeleteAPIURLConst withRequestArgument:parms];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}



#pragma mark 施工单位
//增加保存
- (NSURLSessionTask *)saveConstructionUnitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ConstructionUnitSaveAPIURLConst withRequestArgument:parms];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}
//修改
- (NSURLSessionTask *)editConstructionUnitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ConstructionUnitUpdateAPIURLConst withRequestArgument:parms];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}
//删除
- (NSURLSessionTask *)deleteConstructionUnitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block{
    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:ConstructionUnitDeleteAPIURLConst withRequestArgument:parms];
    return [baseVM requestCompletionWithSuccess:^(__kindof GRResponse * _Nonnull response) {
        block();
    } withFailure:^(__kindof GRResponse * _Nonnull response) {
    }];
}



@end
