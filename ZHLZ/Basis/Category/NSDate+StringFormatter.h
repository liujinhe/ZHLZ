//
//  NSDate+StringFormatter.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (StringFormatter)

+ (NSDate *)formatterDateWithDateString:(NSString *)dateString;

@end

NS_ASSUME_NONNULL_END
