//
//  ZHLZCityManagementVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZCityManagementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZCityManagementVC : ZHLZBaseVC
@property (nonatomic , strong) NSString *detailId;//详情id
@property(nonatomic , assign) NSInteger setType;//1增加 2编辑
@property (nonatomic , strong) CityManagementList *cityManagementModel;//市管单位

@property(nonatomic,copy) void (^reloadDataBlock)(void);

@end

NS_ASSUME_NONNULL_END
