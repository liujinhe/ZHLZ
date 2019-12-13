//
//  ZHLZExamineVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZExamineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZExamineVC : ZHLZBaseVC
@property (nonatomic , strong) NSString *detailId;//详情id
@property(nonatomic , assign) NSInteger setType;//1增加 2编辑


@property(nonatomic,copy) void (^reloadDataBlock)(void);

@end

NS_ASSUME_NONNULL_END
