//
//  ZHLZProjectTypePickerViewVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZProjectTypePickerViewVC : ZHLZBaseVC

@property (nonatomic, copy) void (^selectPickerBlock)(NSString *projectType, NSString *projectName);

- (void)showFilterViewWithVC:(UIViewController *)vc;

- (void)hideFilterView;

@end

NS_ASSUME_NONNULL_END
