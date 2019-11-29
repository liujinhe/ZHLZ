//
//  ZHLZHomeScanCodeUseCarVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeScanCodeUseCarVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)scanCodeUseCarWithParms:(NSDictionary *)parms withBlock:(dispatch_block_t)block;

- (NSURLSessionTask *)scanCodeRepayCarWithParms:(NSDictionary *)parms withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
