//
//  ZHLZDeviceStatusModel.m
//  ZHLZ
//
//  Created by liujinhe on 2019/12/10.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZDeviceStatusModel.h"

@implementation ZHLZDeviceStatusModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _channel = 0;
        _codeStream = 0;
        _channelName = @"CH1";
    }
    return self;
}

@end
