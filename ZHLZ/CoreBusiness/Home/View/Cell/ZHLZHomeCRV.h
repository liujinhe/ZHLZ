//
//  ZHLZHomeCRV.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 选择最新消息类型（0:占道施工问题 1:市政设施问题）
typedef void(^SelectedLatestMessageTypeBlock)(NSInteger type, NSIndexPath *currentIndexPath);

@interface ZHLZHomeCRV : UICollectionReusableView

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, copy) SelectedLatestMessageTypeBlock selectedLatestMessageTypeBlock;

@end

NS_ASSUME_NONNULL_END
