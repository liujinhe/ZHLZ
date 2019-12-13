//
//  ZHLZRoadWorkVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZRoadWorkModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHLZRoadWorkVC : ZHLZBaseVC
@property (nonatomic , strong) NSString *detailId;//详情id
@property (nonatomic , assign) NSInteger editType;



@property(nonatomic,copy) void (^reloadDataBlock)(void);

@end

NS_ASSUME_NONNULL_END
