//
//  ZHLZChosseStepVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZChosseStepVC : ZHLZBaseVC

@property (nonatomic, copy) void (^chooseStepBlock)(NSString *code, NSString *name);

@end

NS_ASSUME_NONNULL_END
