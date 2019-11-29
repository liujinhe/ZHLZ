//
//  ZHLZRoadMaintenancePickerViewModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/29.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZRoadMaintenancePickerViewThirdModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@end

@interface ZHLZRoadMaintenancePickerViewSecondModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, strong) NSArray<ZHLZRoadMaintenancePickerViewThirdModel *> *children;

@end

@interface ZHLZRoadMaintenancePickerViewModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, strong) NSArray<ZHLZRoadMaintenancePickerViewSecondModel *> *children;

@end

NS_ASSUME_NONNULL_END
