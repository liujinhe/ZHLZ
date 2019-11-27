//
//  NSDate+StringFormatter.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "NSDate+StringFormatter.h"

@implementation NSDate (StringFormatter)

+ (NSDate *)formatterDateWithDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    return [dateFormatter dateFromString:dateString];
}

@end
