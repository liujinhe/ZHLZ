//
//  NSString+DateFormatter.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "NSString+DateFormatter.h"

@implementation NSString (DateFormatter)

+ (NSString *)formatterWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatterBeforeOrAfterDateWithDate:(NSDate *)date withMonth:(NSInteger)month {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *beforeOrAfterDate = [calender dateByAddingComponents:dateComponents toDate:date options:0];
    return [self formatterWithDate:beforeOrAfterDate];
}

@end
