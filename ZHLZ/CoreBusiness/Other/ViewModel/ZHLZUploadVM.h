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

- (void)uploadImageArray:(NSArray<UIImage *> *)uploadImageArray withUploadId:(NSString *)uploadId withBlock:(dispatch_block_t)block;

- (void)deleteImageWithImageUrl:(NSString *)imageUrl withBlock:(dispatch_block_t)block;


- (NSString *)random:(int)len;

@end

NS_ASSUME_NONNULL_END
