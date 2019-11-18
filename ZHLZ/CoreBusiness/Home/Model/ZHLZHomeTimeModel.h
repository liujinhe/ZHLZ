//
//  ZHLZHomeTimeModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeTimeModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *seconds;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, copy) NSString *timezoneOffset;

@end

NS_ASSUME_NONNULL_END
