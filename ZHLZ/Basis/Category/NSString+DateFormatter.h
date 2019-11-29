//
//  NSString+DateFormatter.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DateFormatter)

/// 格式化日期
/// @param date NSDate
+ (NSString *)formatterWithDate:(NSDate *)date;

/// 格式化时间
/// @param date NSDate
+ (NSString *)formatterWithTime:(NSDate *)date;

/// 格式化日期（获取前或后 month 个月的日期）
/// @param date NSDate
/// @param month 加减月份
+ (NSString *)formatterBeforeOrAfterDateWithDate:(NSDate *)date withMonth:(NSInteger)month;

@end

NS_ASSUME_NONNULL_END
