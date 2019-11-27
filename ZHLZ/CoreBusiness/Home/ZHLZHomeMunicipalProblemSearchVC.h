//
//  ZHLZHomeMunicipalProblemSearchVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZHomeMunicipalProblemSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMunicipalProblemSearchVC : ZHLZBaseVC

@property (nonatomic, copy) void (^selectSearchBlock)(ZHLZHomeMunicipalProblemSearchModel *homeMunicipalProblemSearchModel);

- (void)showFilterView;

- (void)hideFilterView;

@end

NS_ASSUME_NONNULL_END
