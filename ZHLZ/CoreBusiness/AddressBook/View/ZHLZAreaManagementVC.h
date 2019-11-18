//
//  ZHLZAreaManagementVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZAreaManagementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZAreaManagementVC : ZHLZBaseVC

@property(nonatomic , assign) NSInteger setType;//1增加 2编辑
@property (nonatomic , strong) AreaManagementList *areaManagementModel;//区管单位

@property(nonatomic,copy) void (^reloadDataBlock)(void);

@end

NS_ASSUME_NONNULL_END
