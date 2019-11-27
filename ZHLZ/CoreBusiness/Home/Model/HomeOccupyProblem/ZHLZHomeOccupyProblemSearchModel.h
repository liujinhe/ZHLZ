//
//  ZHLZHomeOccupyProblemSearchModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeOccupyProblemSearchModel : ZHLZBaseModel

// 项目 ID
@property (nonatomic, strong, nullable) NSString *projectid;
// 项目名称
@property (nonatomic, strong, nullable) NSString *projectname;
// 问题描述
@property (nonatomic, strong, nullable) NSString *prodescription;
// 发现时间-开始
@property (nonatomic, strong, nullable) NSString *startDate;
// 发现时间-结束
@property (nonatomic, strong, nullable) NSString *endDate;
// 关闭时间-开始
@property (nonatomic, strong, nullable) NSString *cstartdate;
// 关闭时间-结束
@property (nonatomic, strong, nullable) NSString *cenddate;
// 地点位置
@property (nonatomic, strong, nullable) NSString *position;
// 问题类型
@property (nonatomic, strong, nullable) NSString *protype;
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
