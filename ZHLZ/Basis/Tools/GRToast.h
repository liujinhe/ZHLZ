//
//  GRToast.h
//  GR
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GRToast : NSObject

+ (void)makeText:(NSString *)text;

+ (void)makeText:(NSString *)text
  withIsDuration:(BOOL)isDuration;

+ (void)makeText:(NSString *)text
          offset:(CGFloat)offset;

+ (void)makeText:(NSString *)text
        duration:(CFTimeInterval)duration;

+ (void)makeText:(NSString *)text
        duration:(CFTimeInterval)duration
          offset:(CGFloat)offset
  withIsDuration:(BOOL)isDuration;

+ (void)hideToast;

@end

NS_ASSUME_NONNULL_END
