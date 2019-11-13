//
//  ZHLZBaseVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBaseVC : UIViewController

// 当前页码
@property (nonatomic, assign) NSInteger pageNo;

@property (nonatomic, strong) __kindof NSURLSessionTask * _Nullable task;

@property (nonatomic, strong) NSMutableArray<__kindof NSURLSessionTask *> * _Nullable tasks;

- (void)cancelAllTask;

/// 弹出确认选择提示窗口
/// @param tip 提示信息
/// @param block block description
- (void)popActionWithTip:(NSString *)tip withBlock:(dispatch_block_t)block;

/// 弹出确认选择提示窗口
/// @param title 提示标题
/// @param tip 提示信息
/// @param block block description
- (void)popActionWithTitle:(NSString * _Nullable)title withTip:(NSString *)tip withBlock:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
