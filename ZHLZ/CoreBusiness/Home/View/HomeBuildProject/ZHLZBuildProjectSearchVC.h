//
//  ZHLZBuildProjectSearchVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZBuildProjectSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBuildProjectSearchVC : ZHLZBaseVC

@property (nonatomic, copy) void (^selectSearchBlock)(ZHLZBuildProjectSearchModel *buildProjectSearchModel);

- (void)showFilterView;

- (void)hideFilterView;

@end

NS_ASSUME_NONNULL_END
