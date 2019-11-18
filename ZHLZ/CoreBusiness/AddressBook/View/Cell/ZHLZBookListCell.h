//
//  ZHLZBookListCell.h
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZHLZMonadModel.h"
#import "ZHLZSpecialModel.h"
#import "ZHLZCityManagementModel.h"
#import "ZHLZAreaManagementModel.h"
#import "ZHLZConstructionModel.h"
#import "ZHLZExamineModel.h"
#import "ZHLZRoadWorkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBookListCell : UITableViewCell

@property (nonatomic , strong) MonadModelList *monadList;
@property (nonatomic , strong) SpecialList *specialList;
@property (nonatomic , strong) CityManagementList *cityManagementList;
@property (nonatomic , strong) AreaManagementList *areaManagementList;
@property (nonatomic , strong) ConstructionList *constructionList;
@property (nonatomic , strong) ExamineList *examineList;
@property (nonatomic , strong) RoadWorkList *roadWorkList;

@end

NS_ASSUME_NONNULL_END
