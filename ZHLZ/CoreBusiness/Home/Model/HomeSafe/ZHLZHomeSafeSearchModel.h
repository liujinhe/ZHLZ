//
//  ZHLZHomeSafeSearchModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeSearchModel : ZHLZBaseModel

// 所在位置
@property (nonatomic, strong, nonnull) NSString *currentPlace;
// 问题描述
@property (nonatomic, strong, nonnull) NSString *prodescription;

@end

NS_ASSUME_NONNULL_END
