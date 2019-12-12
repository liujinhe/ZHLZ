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

@property (nonatomic, strong) NSString *navTitle;

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

/// 弹出提示
/// @param title 提示标题
/// @param tip 提示信息
- (void)popPromptActionWithTitle:(NSString * _Nullable)title withTip:(NSString *)tip;

/// 添加导航栏右侧按钮
/// @param title 标题
/// @param action 触发事件
- (void)addRightBarButtonItemWithTitle:(NSString *)title action:(nullable SEL)action;


/// 添加导航栏右侧按钮
/// @param imageName 图标
/// @param action 触发事件
- (void)addRightBarButtonItemWithImageName:(NSString *)imageName action:(nullable SEL)action;

/// 空页面i提示语
- (NSMutableAttributedString *)emptyDataTip:(NSString *)tip;

@end

NS_ASSUME_NONNULL_END
