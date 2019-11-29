//
//  ZHLZRoadMaintenancePickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/29.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZRoadMaintenancePickerViewVC : ZHLZBaseVC

@property (nonatomic, copy) void (^selectPickerBlock)(NSArray *valueArray, NSArray *nameArray);

@end

NS_ASSUME_NONNULL_END
