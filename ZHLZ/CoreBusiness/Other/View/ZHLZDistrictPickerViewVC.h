//
//  ZHLZDistrictPickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZDistrictPickerViewVC : ZHLZBaseVC

@property (nonatomic, copy) void (^selectPickerBlock)(NSString *districtType, NSString *districtName);

@end

NS_ASSUME_NONNULL_END
