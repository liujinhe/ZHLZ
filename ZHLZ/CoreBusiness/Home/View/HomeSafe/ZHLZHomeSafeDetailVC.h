//
//  ZHLZHomeSafeDetailVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeDetailVC : ZHLZBaseVC

@property (nonatomic , assign) NSInteger type; // 1新增 2查看 3编辑

@property (nonatomic ,strong) NSString *detailId;

@end

NS_ASSUME_NONNULL_END
