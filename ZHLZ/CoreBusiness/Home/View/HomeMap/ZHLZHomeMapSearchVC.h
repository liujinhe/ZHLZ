//
//  ZHLZHomeMapSearchVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/20.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMapSearchVC : ZHLZBaseVC

@property (nonatomic, copy) void (^selectSearchBlock)(NSString *projectName, NSString *bid, NSString *projecttypeId);

- (void)showFilterView;

- (void)hideFilterView;

@end

NS_ASSUME_NONNULL_END
