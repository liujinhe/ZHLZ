//
//  ZHLZHomeMunicipalProblemSearchModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMunicipalProblemSearchModel : ZHLZBaseModel

// 当前问题ID
// 问题描述
@property (nonatomic, strong, nullable) NSString *problemDet;
// 路段
@property (nonatomic, strong, nullable) NSString *siteDet;
// 发现时间-开始
@property (nonatomic, strong, nullable) NSString *startDate;
// 发现时间-结束
@property (nonatomic, strong, nullable) NSString *endDate;
// 关闭时间-开始
@property (nonatomic, strong, nullable) NSString *cstartdate;
// 关闭时间-结束
@property (nonatomic, strong, nullable) NSString *cenddate;
// 所属大队
@property (nonatomic, strong, nullable) NSString *orgid;
// 问题类型
@property (nonatomic, strong, nullable) NSString *problemType;
// 搜索范围
@property (nonatomic, strong, nullable) NSString *rangeleg;
// 当前经度
@property (nonatomic, strong, nullable) NSString *lng;
// 当前维度
@property (nonatomic, strong, nullable) NSString *lat;
// 是否开启范围扫描（1-开启 其他-关闭）
@property (nonatomic, assign, nullable) NSString *isrange;

@end

NS_ASSUME_NONNULL_END
