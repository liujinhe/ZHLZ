//
//  ZHLZHomeVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadDataWithBlock:(void (^)(NSMutableArray<GRResponse *> *responseArray))block;

@end

NS_ASSUME_NONNULL_END
