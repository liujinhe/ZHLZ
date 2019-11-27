//
//  ZHLZChooseListCell.h
//  ZHLZ
//
//  Created by apple on 2019/11/25.
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
#import "ZHLZHomeSafeModel.h"
#import "ZHLZHomeBuildProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZChooseListCell : UITableViewCell

@property (nonatomic , strong) MonadModelList *monadList;
@property (nonatomic , strong) SpecialList *specialList;
@property (nonatomic , strong) CityManagementList *cityManagementList;
@property (nonatomic , strong) AreaManagementList *areaManagementList;
@property (nonatomic , strong) ConstructionList *constructionList;
@property (nonatomic , strong) ExamineList *examineList;
@property (nonatomic , strong) RoadWorkList *roadWorkList;
@property (nonatomic , strong) ZHLZHomeSafeModel *homeSafeModel;
@property (nonatomic , strong) ZHLZHomeBuildProjectModel *homeBuildProjectModel;

@end

NS_ASSUME_NONNULL_END
