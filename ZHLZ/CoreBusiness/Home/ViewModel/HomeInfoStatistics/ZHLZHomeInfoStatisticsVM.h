//
//  ZHLZHomeInfoStatisticsVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeInfoStatisticsVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeInfoStatisticsDataWithPageNo:(NSInteger)pageNo withType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
