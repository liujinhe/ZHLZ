//
//  ZHLZHomeRoadPatrolVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeRoadPatrolModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeRoadPatrolVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeRoadPatrolWithPageNo:(NSInteger)pageNo withStartDate:(NSString *)startDate withEndDate:(NSString *)endDate withBlock:(void (^)(NSArray<ZHLZHomeRoadPatrolModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
