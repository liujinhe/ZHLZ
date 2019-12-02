//
//  ZHLZUploadVM.h
//  ZHLZ
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZUploadVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (void)uploadImageArray:(NSArray<NSData *> *)uploadImageArray withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
