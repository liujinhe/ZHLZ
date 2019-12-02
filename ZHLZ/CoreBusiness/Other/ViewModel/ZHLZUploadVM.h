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

- (void)uploadImageArray:(NSArray<UIImage *> *)uploadImageArray withBlock:(void(^)(NSString *uploadIdStr))block;

@end

NS_ASSUME_NONNULL_END
