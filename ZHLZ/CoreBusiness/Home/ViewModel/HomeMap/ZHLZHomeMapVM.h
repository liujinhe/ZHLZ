//
//  ZHLZHomeMapVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@class ZHLZHomeMapModel;

@interface ZHLZHomeMapVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeMapDataWithBlock:(void (^)(NSArray<ZHLZHomeMapModel *> *homeMapArray))block;

@end

NS_ASSUME_NONNULL_END
