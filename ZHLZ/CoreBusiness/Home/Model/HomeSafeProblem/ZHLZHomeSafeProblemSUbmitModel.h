//
//  ZHLZHomeSafeProblemSUbmitModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/24.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeProblemSUbmitModel : ZHLZBaseModel

@property (nonatomic , copy) NSString *risksid;///台账ID

//@property (nonatomic , copy) NSString *areaid;///片区名称

@property (nonatomic , copy) NSString *belong;///责任所属区县

@property (nonatomic , copy) NSString *finddate;///问题发现时间

@property (nonatomic , copy) NSString *promanager;///经办人id

@property (nonatomic , copy) NSString *orgid;///大队

@property (nonatomic , copy) NSString *ddssjtms;///督导措施导出具体描述

@property (nonatomic , copy) NSString *prodescription;///问题描述

@property (nonatomic , copy) NSString *remark;///备注

@property (nonatomic , copy) NSString *uploadid;///图片上传id

@property (nonatomic , copy) NSString *id;

@end

NS_ASSUME_NONNULL_END
