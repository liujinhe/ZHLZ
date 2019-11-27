//
//  ZHLZDatePickerVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/22.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZDatePickerVC : ZHLZBaseVC

@property (nonatomic, strong) NSString *currentDate;

@property (nonatomic, strong) NSString *minDate;

@property (nonatomic, strong) NSString *maxDate;

@property (nonatomic, copy) void (^selectDatePickerBlock)(NSString *date);

@end

NS_ASSUME_NONNULL_END
