//
//  ZHLZTransactedPersonPickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/12/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZTransactedPersonPickerViewVC : ZHLZBaseVC

@property (nonatomic, copy) void (^selectPickerBlock)(NSString *code, NSString *name);

@end

NS_ASSUME_NONNULL_END
