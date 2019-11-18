//
//  ZHLZHomeVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

#import "ZHLZHomeBannerModel.h"
#import "ZHLZHomeBulletinModel.h"
#import "ZHLZHomeRoadConstructionModel.h"
#import "ZHLZHomeMunicipalFacilityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadDataWithBlock:(void (^)(NSArray<ZHLZHomeBannerModel *> *homeBannerArray,
                                                  NSArray<ZHLZHomeBulletinModel *> *homeBulletinArray,
                                                  NSArray<ZHLZHomeRoadConstructionModel *> *homeRoadConstructionArray,
                                                  NSArray<ZHLZHomeMunicipalFacilityModel *> *homeMunicipalFacilityArray))block;

@end

NS_ASSUME_NONNULL_END
