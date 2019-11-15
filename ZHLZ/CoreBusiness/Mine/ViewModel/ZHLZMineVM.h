//
//  ZHLZMineVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZMineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZMineVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)getUserInfoCallBack:(void (^)(ZHLZMineModel *mineModel))block;

- (NSURLSessionTask *)changePasswordWitParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
