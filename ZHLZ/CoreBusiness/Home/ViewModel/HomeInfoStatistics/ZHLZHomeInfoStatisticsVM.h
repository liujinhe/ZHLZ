//
//  ZHLZHomeInfoStatisticsVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeInfoStatisticsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeInfoStatisticsVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeInfoStatisticsDataWithType:(NSInteger)type withBlock:(void (^)(NSArray<ZHLZHomeInfoStatisticsModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
