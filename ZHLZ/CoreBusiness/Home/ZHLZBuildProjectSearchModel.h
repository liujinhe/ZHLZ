//
//  ZHLZBuildProjectSearchModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBuildProjectSearchModel : ZHLZBaseModel

// 当前项目ID
// 项目名称
@property (nonatomic, strong, nullable) NSString *name;
// 工程地点
@property (nonatomic, strong, nullable) NSString *position;
// 备注
@property (nonatomic, strong, nullable) NSString *remark;
// 工程状态
@property (nonatomic, strong, nullable) NSString *projectstatusId;
// 巡查频次
@property (nonatomic, strong, nullable) NSString *frequency;
// 工程类型
@property (nonatomic, strong, nullable) NSString *projecttypeIdcenddate;

@end

NS_ASSUME_NONNULL_END
