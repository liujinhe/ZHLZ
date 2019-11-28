//
//  ZHLZHomeSafeProblemSearchModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeProblemSearchModel : ZHLZBaseModel

// 问题ID
// 问题描述
@property (nonatomic, strong, nullable) NSString *prodescription;
// 防汛台账ID
@property (nonatomic, strong, nullable) NSString *risksid;
// 备注
@property (nonatomic, strong, nullable) NSString *remark;
// 经办人
@property (nonatomic, strong, nullable) NSString *promanager;
// 责任区县
@property (nonatomic, strong, nullable) NSString *belong;
// 大队
@property (nonatomic, strong, nullable) NSString *orgid;
// 问题状态（0-未解决 1-已解决）
@property (nonatomic, strong, nullable) NSString *prostatus;
// 发现时间-开始
@property (nonatomic, strong, nullable) NSString *startDate;
// 发现时间-结束
@property (nonatomic, strong, nullable) NSString *endDate;
// 关闭时间-开始
@property (nonatomic, strong, nullable) NSString *cstartdate;
// 关闭时间-结束
@property (nonatomic, strong, nullable) NSString *cenddate;

@end

NS_ASSUME_NONNULL_END
