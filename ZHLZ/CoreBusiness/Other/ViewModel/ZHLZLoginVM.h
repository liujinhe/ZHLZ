//
//  ZHLZLoginVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@class ZHLZLoginModel;

@interface ZHLZLoginVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loginWithModel:(ZHLZLoginModel *)model
                      withCompletionBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
