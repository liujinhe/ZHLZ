//
//  ZHLZAddCouncilorVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZAddCouncilorVC : ZHLZBaseVC

@property (nonatomic, copy) void (^addCouncilorBlock)(NSString *detailStr);

@end

NS_ASSUME_NONNULL_END
