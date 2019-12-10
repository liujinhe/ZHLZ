//
//  ZHLZHomeVM.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeVM.h"
#import "GRBatchRequest.h"

@implementation ZHLZHomeVM

+ (instancetype)sharedInstance {
    static id homeVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeVM = [[self alloc] init];
    });
    return homeVM;
}

- (NSURLSessionTask *)loadDataWithRefreshing:(BOOL)isRefreshing withBlock:(void (^)(NSArray<ZHLZHomeBannerModel *> *homeBannerArray,
                                                                                    NSArray<ZHLZHomeBulletinModel *> *homeBulletinArray,
                                                                                    NSArray<ZHLZHomeRoadConstructionModel *> *homeRoadConstructionArray,
                                                                                    NSArray<ZHLZHomeMunicipalFacilityModel *> *homeMunicipalFacilityArray))block {
    NSArray *apiURLArray = @[HomeBannerAPIURLConst,
                             HomeBulletinAPIURLConst,
                             HomeOccupyProblemAPIURLConst,
                             HomeMunicipalProblemAPIURLConst];
    NSArray *isLoadListArray = @[@(NO),
                                 @(YES),
                                 @(YES),
                                 @(YES)];
    ZHLZBaseBatchVM *baseBatchVM = [[ZHLZBaseBatchVM alloc] initWithRequestUrlArray:apiURLArray withIsLoadListArray:isLoadListArray];
    [baseBatchVM requestCompletionWithSuccess:^(NSArray<GRResponse *> * _Nonnull responseArray) {
        if (!responseArray || responseArray.count <= 0) {
            block(nil, nil, nil, nil);
            return;
        }
        
        NSArray<ZHLZHomeBannerModel *> *homeBannerArray;
        GRResponse *homeBannerResponse = responseArray[0];
        if (homeBannerResponse && homeBannerResponse.data) {
            homeBannerArray = [NSArray modelArrayWithClass:[ZHLZHomeBannerModel class]
                                                      json:[homeBannerResponse.data objectForKey:@"list"]];
        }
        
        NSArray<ZHLZHomeBulletinModel *> *homeBulletinArray;
        GRResponse *homeBulletinResponse = responseArray[1];
        if (homeBulletinResponse && homeBulletinResponse.data) {
            homeBulletinArray = [NSArray modelArrayWithClass:[ZHLZHomeBulletinModel class]
                                                        json:[homeBulletinResponse.data objectForKey:@"list"]];
        }
        
        NSArray<ZHLZHomeRoadConstructionModel *> *homeRoadConstructionArray;
        GRResponse *homeRoadConstructionResponse = responseArray[2];
        if (homeRoadConstructionResponse && homeRoadConstructionResponse.data) {
            homeRoadConstructionArray = [NSArray modelArrayWithClass:[ZHLZHomeRoadConstructionModel class]
                                                                json:[homeRoadConstructionResponse.data objectForKey:@"list"]];
        }
        
        NSArray<ZHLZHomeMunicipalFacilityModel *> *homeMunicipalFacilityArray;
        GRResponse *homeMunicipalFacilityResponse = responseArray[3];
        if (homeMunicipalFacilityResponse && homeMunicipalFacilityResponse.data) {
            homeMunicipalFacilityArray = [NSArray modelArrayWithClass:[ZHLZHomeMunicipalFacilityModel class]
                                                                 json:[homeMunicipalFacilityResponse.data objectForKey:@"list"]];
        }
        
        block(homeBannerArray, homeBulletinArray, homeRoadConstructionArray, homeMunicipalFacilityArray);
    } withFailure:^(NSArray<GRResponse *> * _Nonnull responseArray) {
        block(nil, nil, nil, nil);
    }];
    return self.requestTask;
}

@end
