//
//  ZHLZSafeSubmitModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/23.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZSafeSubmitModel : ZHLZBaseModel

@property (nonatomic , copy) NSString *orgName;

@property (nonatomic , copy) NSString *currentPlace;

@property (nonatomic , copy) NSString *prodescription;

@property (nonatomic , copy) NSString *workRecord;

@property (nonatomic , copy) NSString *unitId;

@property (nonatomic , copy) NSString *photoNumber;

@property (nonatomic , copy) NSString *workMeasures;

@property (nonatomic , copy) NSString *uploadId;

@end

NS_ASSUME_NONNULL_END
