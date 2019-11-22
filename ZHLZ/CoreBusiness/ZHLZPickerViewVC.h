//
//  ZHLZPickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/22.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZPickerViewVC : ZHLZBaseVC

@property (nonatomic, strong) NSArray<NSString *> *titleArray;

@property (nonatomic, copy) void (^selectPickerBlock)(NSInteger index, NSString *name);

@end

NS_ASSUME_NONNULL_END
