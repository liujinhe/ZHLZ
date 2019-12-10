//
//  ZHLZHomeCarVideoVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/12/10.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZVehicleInfoModel.h"
#import "ZHLZDeviceStatusModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeCarVideoVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

/// 回话登录
/// @param account 账号
/// @param pwd 密码
/// @param block 回调（session）
- (NSURLSessionTask *)sessionLoginWithAccount:(NSString *)account withPwd:(NSString *)pwd withBlock:(void (^)(NSString *session))block;

/// 回话注销
/// @param session session description
- (NSURLSessionTask *)sessionLogoutWithSession:(NSString *)session;

/// 获取车辆信息
/// @param session session description
/// @param block 回调（返回车辆）
- (NSURLSessionTask *)getVehicleInfoWithSession:(NSString *)session withBlock:(void (^)(NSArray<ZHLZVehicleInfoModel *> *array))block;

/// 获取设备在线状态
/// @param deviceId 设备 ID（多个以逗号分割）
/// @param plateNo 车牌号（多个以逗号分割）
/// @param block 回调（设备在线状态：1-在线 其他-不在线）
- (NSURLSessionTask *)getDeviceStatusWithDeviceId:(NSString *)deviceId withPlateNo:(nullable NSString *)plateNo withBlock:(void (^)(NSArray<ZHLZDeviceStatusModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
