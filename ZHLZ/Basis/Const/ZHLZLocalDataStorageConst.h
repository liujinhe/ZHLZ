//
//  ZHLZLocalDataStorageConst.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZLocalDataStorageConst : NSObject

// 记住密码
extern NSString * const LoginRememberPwdConst;
// 人员签到
extern NSString * const PeopleCheckInDateConst;
// 车辆签到
extern NSString * const CarCheckInDateConst;
// 当前位置（地址）
extern NSString * const CurrentLocationAddressConst;
// 当前位置（坐标）
extern NSString * const CurrentLocationCoordinateConst;

@end

NS_ASSUME_NONNULL_END
