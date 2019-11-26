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
@property (nonatomic, strong) NSString *projectid;
// 项目名称
@property (nonatomic, strong) NSString *projectname;
// 问题描述
@property (nonatomic, strong) NSString *prodescription;
// 发现时间-开始
@property (nonatomic, strong) NSString *startDate;
// 发现时间-结束
@property (nonatomic, strong) NSString *endDate;
// 关闭时间-开始
@property (nonatomic, strong) NSString *cstartdate;
// 关闭时间-结束
@property (nonatomic, strong) NSString *cenddate;
// 地点位置
@property (nonatomic, strong) NSString *position;
// 问题类型
@property (nonatomic, strong) NSString *protype;
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
