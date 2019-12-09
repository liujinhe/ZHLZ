//
//  ZHLZHomeSafeProblemDetailVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeProblemDetailVC : ZHLZBaseVC

@property (nonatomic, assign) NSInteger type; // 1-新增 2-查看 3-编辑

@property (nonatomic, strong) NSString *detailId;

@end

NS_ASSUME_NONNULL_END
