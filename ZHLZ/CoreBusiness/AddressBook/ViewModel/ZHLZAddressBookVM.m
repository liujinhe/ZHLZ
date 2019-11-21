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

- (NSURLSessionTask *)loadListWithType:(NSInteger)type withPageNum:(NSInteger)page andSearchKeyString:(NSString *)searchString CallBack:(void (^)(NSDictionary *parms))block{
    
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
    
    NSMutableDictionary *parms = [NSMutableDictionary new];
    [parms setValue:@(page) forKey:@"page"];
    [parms setValue:@(10) forKey:@"limit"];
    [parms setValue:@"desc" forKey:@"order"];
    [parms setValue:@"" forKey:@"sidx"];
    if ([searchString isNotBlank]) {
        [parms setValue:searchString forKey:@"name"];
    }

    ZHLZBaseVM *baseVM = [[ZHLZBaseVM alloc] initWithRequestUrl:requestString withRequestArgument:parms];
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

@end
