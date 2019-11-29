//
//  ZHLZHomeInfoStatisticsListVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/29.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeInfoStatisticsListVC : ZHLZBaseVC <JXCategoryListContentViewDelegate>

// 选择类型（0-日 1-周 2-月 3-季度）
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
