//
//  ZHLZDateSearchView.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZDateSearchView : UIView

@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) NSString *startDate;

@property (nonatomic, strong) NSString *endDate;

@property (nonatomic, copy) void (^searchWithDateBlock)(NSString *startDate, NSString *endDate);

@end

NS_ASSUME_NONNULL_END
