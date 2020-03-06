//
//  ZHLZHomeOccupyProblemSearchVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZHomeOccupyProblemSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeOccupyProblemSearchVC : ZHLZBaseVC

@property (nonatomic, strong) ZHLZHomeOccupyProblemSearchModel *model;

@property (nonatomic, copy) void (^selectSearchBlock)(ZHLZHomeOccupyProblemSearchModel *homeOccupyProblemSearchModel);

- (void)showFilterView;

- (void)hideFilterView;

@end

NS_ASSUME_NONNULL_END
