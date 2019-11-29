//
//  ZHLZListPickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZListPickerViewVC : ZHLZBaseVC

/// 获取类型（1-是否重点 2-施工状态 3-巡查频次 4-工程类型 5-责任所属区县 6-上级交办、舆情及应急处理 7-问题类型 8-市政问题类型）
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) void (^selectPickerBlock)(NSString *code, NSString *name);

@end

NS_ASSUME_NONNULL_END
