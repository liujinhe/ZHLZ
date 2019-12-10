//
//  ZHLZDeviceStatusModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/12/10.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZDeviceStatusModel : ZHLZBaseModel

// 设备号
@property (nonatomic, copy) NSString *did;
// 车牌号
@property (nonatomic, copy) NSString *vid;
// 在线状态（1-在线 其他-不在线）
@property (nonatomic, assign) NSInteger online;

@end

NS_ASSUME_NONNULL_END
