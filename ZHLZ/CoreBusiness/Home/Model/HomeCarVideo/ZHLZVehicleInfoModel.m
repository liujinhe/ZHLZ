//
//  ZHLZVehicleInfoModel.m
//  ZHLZ
//
//  Created by liujinhe on 2019/12/10.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZVehicleInfoModel.h"

@implementation ZHLZVehicleInfoDeviceModel

@end

@implementation ZHLZVehicleInfoModel

- (void)setDl:(NSArray<ZHLZVehicleInfoDeviceModel *> *)dl {
    _dl = [NSArray modelArrayWithClass:[ZHLZVehicleInfoDeviceModel class] json:dl];
}

@end
