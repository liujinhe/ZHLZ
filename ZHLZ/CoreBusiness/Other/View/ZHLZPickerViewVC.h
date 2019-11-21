//
//  ZHLZPickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZPickerViewVC : ZHLZBaseVC

// 一级或多级联动（默认一级，最高支持三级）
@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) void (^selectPickerBlock)(NSInteger firstIndex);

@property (nonatomic, copy) void (^selectSecondPickerBlock)(NSInteger firstIndex, NSInteger secondIndex);

@property (nonatomic, copy) void (^selectThirdPickerBlock)(NSInteger firstIndex, NSInteger secondIndex, NSInteger thirdIndex);

@end

NS_ASSUME_NONNULL_END
