//
//  ZHLZSpecialVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZSpecialModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZSpecialVC : ZHLZBaseVC

@property(nonatomic , assign) NSInteger setType;//1增加 2编辑
@property (nonatomic , strong) SpecialList *specialModel;//特殊业主单位


@property(nonatomic,copy) void (^reloadDataBlock)(void);


@end

NS_ASSUME_NONNULL_END
