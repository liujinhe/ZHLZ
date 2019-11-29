//
//  ZHLZRoadMaintenancePickerViewModel.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/29.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZRoadMaintenancePickerViewModel.h"

@implementation ZHLZRoadMaintenancePickerViewThirdModel

@end

@implementation ZHLZRoadMaintenancePickerViewSecondModel

- (void)setChildren:(NSArray<ZHLZRoadMaintenancePickerViewThirdModel *> *)children {
    _children = [NSArray modelArrayWithClass:[ZHLZRoadMaintenancePickerViewThirdModel class] json:children];
}

@end

@implementation ZHLZRoadMaintenancePickerViewModel

- (void)setChildren:(NSArray<ZHLZRoadMaintenancePickerViewSecondModel *> *)children {
    _children = [NSArray modelArrayWithClass:[ZHLZRoadMaintenancePickerViewSecondModel class] json:children];
}

@end
