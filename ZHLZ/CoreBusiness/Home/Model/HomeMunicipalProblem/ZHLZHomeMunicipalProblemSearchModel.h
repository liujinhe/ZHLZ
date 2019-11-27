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
@property (nonatomic, strong) NSString *problemDet;
// 路段
@property (nonatomic, strong) NSString *siteDet;
// 发现时间-开始
@property (nonatomic, strong) NSString *startDate;
// 发现时间-结束
@property (nonatomic, strong) NSString *endDate;
// 关闭时间-开始
@property (nonatomic, strong) NSString *cstartdate;
// 关闭时间-结束
@property (nonatomic, strong) NSString *cenddate;
// 所属大队
@property (nonatomic, strong) NSString *orgid;
// 问题类型
@property (nonatomic, strong) NSString *problemType;
// 搜索范围
@property (nonatomic, strong) NSString *rangeleg;
// 当前经度
@property (nonatomic, strong) NSString *lng;
// 当前维度
@property (nonatomic, strong) NSString *lat;
// 是否开启范围扫描（1-开启 其他-关闭）
@property (nonatomic, strong) NSString *isrange;

@end

NS_ASSUME_NONNULL_END
