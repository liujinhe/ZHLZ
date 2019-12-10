//
//  ZHLZVehicleInfoModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/12/10.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZVehicleInfoDeviceModel : ZHLZBaseModel

// 设备 ID
// 设备所属公司
@property (nonatomic, assign) NSInteger pid;
// IO数目
@property (nonatomic, assign) NSInteger ic;
// IO名称（以','分隔）
@property (nonatomic, copy) NSString *io;
// 通道数目
@property (nonatomic, assign) NSInteger cc;
// 通道名称（以','分隔）
@property (nonatomic, copy) NSString *cn;
// 温度传感器数目
@property (nonatomic, assign) NSInteger tc;
// 温度传感器名称（以','分隔）
@property (nonatomic, copy) NSString *tn;
// 外设参数（按位表示，每位表示一种外设）
// 第一位为支持视频
// 第二位为油路控制
// 第三位为电路控制
// 第四位为 tts 语音
// 第五位为数字对讲
// 第六位为支持抓拍
// 第七位为支持监听
// 第八位为油量传感器
// 第九位为支持对讲
// 第十位为 ODB 外设
@property (nonatomic, assign) NSInteger md;
// SIM卡号
@property (nonatomic, copy) NSString *sim;

@end

@interface ZHLZVehicleInfoModel : ZHLZBaseModel

// 车辆 ID
// 车牌号
@property (nonatomic, copy) NSString *nm;
// 车辆图标
@property (nonatomic, assign) NSInteger ic;
// 所属公司或者车队
@property (nonatomic, assign) NSInteger pid;
// 设备列表
@property (nonatomic, strong) NSArray<ZHLZVehicleInfoDeviceModel *> *dl;

@end

NS_ASSUME_NONNULL_END
