//
//  ZHLZAreaPickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZAreaPickerViewVC : ZHLZBaseVC

// 所属大队 ID
@property (nonatomic, strong) NSString *orgId;

@property (nonatomic, copy) void (^selectPickerBlock)(NSString *areaType, NSString *areaName);

@end

NS_ASSUME_NONNULL_END
