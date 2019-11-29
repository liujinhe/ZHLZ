//
//  ZHLZHomeCheckInVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeCheckInVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

/// 签到打卡
/// @param type 打卡类型（1-车辆打卡 2-人员打卡）
/// @param address 打卡位置
/// @param block 回调
- (NSURLSessionTask *)checkInDataWithType:(NSInteger)type withAddress:(NSString *)address withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
