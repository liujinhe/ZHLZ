//
//  ZHLZChooseListVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZChooseListVC : ZHLZBaseVC
/*
 case 0:
@"选择施工单位";
 break;
 case 1:
@"选择审批部门";
 break;
 case 2:
@"选择建设单位";
 break;
 case 3:
@"选择市管管理单位";
 break;
 case 4:
@"选择区管管理单位";
 break;
 case 5:
@"选择特殊业主单位";
 break;
 case 6:
@"选择责任单位";
 break;
 case 7:
@"选择台账id";
  case 8:
 @"在建项目";
 */
@property (nonatomic , assign) NSInteger selectIndex;

@property (nonatomic, copy) void (^selectListBlock)(NSString *code, NSString *name);

@property (nonatomic, copy) void (^selectBuildProjectListBlock)(NSString *code, NSString *name ,NSString *areaid);

@end

NS_ASSUME_NONNULL_END
