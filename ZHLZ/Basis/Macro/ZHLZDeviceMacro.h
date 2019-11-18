//
//  ZHLZDeviceMacro.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#ifndef ZHLZDeviceMacro_h
#define ZHLZDeviceMacro_h

// 按屏幕宽度比例为标准（标准基数为375.f）
#define kProportion (kScreenWidth / 375.f)
// 自动适配
#define kAutoFitReal(r) ((r) * kProportion)

#define kCurrentDevice [UIDevice currentDevice]
// 当前设备型号
#define kCurrentDeviceModel kCurrentDevice.model
// 当前设备系统版本
#define kCurrentDeviceSystemVersion kCurrentDevice.systemVersion

#endif /* ZHLZDeviceMacro_h */
