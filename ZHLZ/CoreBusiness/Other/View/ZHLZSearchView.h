//
//  ZHLZSearchView.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZSearchView : UIView

@property (nonatomic, copy) void (^onOrOffBlock)(BOOL isOn);

@property (nonatomic, assign) BOOL isOnSwitch;

@property (nonatomic, copy) dispatch_block_t searchBlock;

// 是否存在范围搜索开关（默认不存在）
@property (nonatomic, assign) BOOL isExistRangeSearchSwitch;

@end

NS_ASSUME_NONNULL_END
