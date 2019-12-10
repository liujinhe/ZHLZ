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
// 所属大队
@property (nonatomic, strong) NSString *brigade;
// 通道
@property (nonatomic, assign) int channel;
// 码流
@property (nonatomic, assign) int codeStream;
// 设备名称
@property (nonatomic, strong) NSString *deviceName;
// 通道名称
@property (nonatomic, strong) NSString *channelName;

@end

NS_ASSUME_NONNULL_END
