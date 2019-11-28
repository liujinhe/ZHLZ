//
//  ZHLZAPIURLConst.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZAPIURLConst : NSObject

#pragma mark - API Base URL

extern NSString * const BaseAPIURLConst;

#pragma mark - API URL for Other

// 登录
extern NSString * const LoginAPIURLConst;
// 获取用户信息
extern NSString * const UserInfoAPIURLConst;
// 部门列表
extern NSString * const DepartmentAPIURLConst;
// 文件列表
extern NSString * const DocumentListAPIURLConst;
// 文件上传
extern NSString * const DocumentUploadAPIURLConst;

#pragma mark - API URL for Home

// 首页-Banner
extern NSString * const HomeBannerAPIURLConst;
// 首页-公告
extern NSString * const HomeBulletinAPIURLConst;
extern NSString * const HomeBulletinInfoAPIURLConst;
// 首页-占道问题
extern NSString * const HomeOccupyProblemAPIURLConst;
// 首页-市政设施
extern NSString * const HomeMunicipalProblemAPIURLConst;
// 地图展示-工程信息
extern NSString * const MapDisplayAPIURLConst;
// 地图展示-市政设施问题
extern NSString * const MapDisplayMunicipalProblemAPIURLConst;
// 市政问题
extern NSString * const MunicipalProblemAPIURLConst;
extern NSString * const MunicipalProblemInfoAPIURLConst;
extern NSString * const MunicipalProblemGetMeasuresAPIURLConst;
extern NSString * const MunicipalProblemSaveAPIURLConst;
extern NSString * const MunicipalProblemUpdateAPIURLConst;
extern NSString * const MunicipalProblemDeleteAPIURLConst;
extern NSString * const MunicipalProblemCloseAPIURLConst;
extern NSString * const MunicipalProblemOpenAPIURLConst;

// 在建项目
extern NSString * const ProjectBuildeListAPIURLConst;
extern NSString * const ProjectBuildeDetailAPIURLConst;
extern NSString * const ProjectBuildeDetailSaveAPIURLConst;
extern NSString * const ProjectBuildeDetailUpdateAPIURLConst;

// 安全防汛问题
extern NSString * const SafeFloodPreventionProblemAPIURLConst;
extern NSString * const SafeFloodPreventionProblemInfoAPIURLConst;
extern NSString * const SafeFloodPreventionProblemGetMeasuresAPIURLConst;
extern NSString * const SafeFloodPreventionProblemSaveAPIURLConst;
extern NSString * const SafeFloodPreventionProblemDetailAPIURLConst;
extern NSString * const SafeFloodPreventionProblemUpdateAPIURLConst;
extern NSString * const SafeFloodPreventionProblemDeleteAPIURLConst;
extern NSString * const SafeFloodPreventionProblemCloseAPIURLConst;
extern NSString * const SafeFloodPreventionProblemOpenAPIURLConst;
// 安全防汛台账
extern NSString * const SafeFloodPreventionInfoAPIURLConst;
extern NSString * const SafeFloodPreventionGetMeasuresAPIURLConst;
extern NSString * const SafeFloodPreventionDetailAPIURLConst;
extern NSString * const SafeFloodPreventionDetailAPIURLConst;
extern NSString * const SafeFloodPreventionSaveAPIURLConst;
extern NSString * const SafeFloodPreventionUpdateAPIURLConst;
extern NSString * const SafeFloodPreventionDeleteAPIURLConst;
// 占道问题
extern NSString * const OccupyProblemAPIURLConst;
extern NSString * const OccupyProblemInfoAPIURLConst;
extern NSString * const OccupyProblemSaveAPIURLConst;
extern NSString * const OccupyProblemUpdateAPIURLConst;
extern NSString * const OccupyProblemGetMeasuresAPIURLConst;
extern NSString * const OccupyProblemDeleteAPIURLConst;
extern NSString * const OccupyProblemCloseAPIURLConst;
extern NSString * const OccupyProblemOpenAPIURLConst;
// 签到打卡
extern NSString * const CheckInPunchAPIURLConst;
// 路巡小结
extern NSString * const RoadPatrolSummaryAPIURLConst;
// 扫码用车
extern NSString * const ScanCodeUseCarAPIURLConst;
// 小结统计
extern NSString * const SummaryStatisticsAPIURLConst;

#pragma mark - API URL for AddressBook

// 责任单位
extern NSString * const ResponsibleUnitAPIURLConst;
extern NSString * const ResponsibleUnitInfoAPIURLConst;
extern NSString * const ResponsibleUnitSaveAPIURLConst;
extern NSString * const ResponsibleUnitUpdateAPIURLConst;
extern NSString * const ResponsibleUnitDeleteAPIURLConst;
// 施工单位
extern NSString * const ConstructionUnitAPIURLConst;
extern NSString * const ConstructionUnitInfoAPIURLConst;
extern NSString * const ConstructionUnitSaveAPIURLConst;
extern NSString * const ConstructionUnitUpdateAPIURLConst;
extern NSString * const ConstructionUnitDeleteAPIURLConst;
// 审批部门
extern NSString * const ApprovalDepartmentAPIURLConst;
extern NSString * const ApprovalDepartmentInfoAPIURLConst;
extern NSString * const ApprovalDepartmentSaveAPIURLConst;
extern NSString * const ApprovalDepartmentUpdateAPIURLConst;
extern NSString * const ApprovalDepartmentDeleteAPIURLConst;
// 建设单位
extern NSString * const BuildUnitAPIURLConst;
extern NSString * const BuildUnitInfoAPIURLConst;
extern NSString * const BuildUnitSaveAPIURLConst;
extern NSString * const BuildUnitUpdateAPIURLConst;
extern NSString * const BuildUnitDeleteAPIURLConst;
// 市管管理单位
extern NSString * const CityManagementUnitAPIURLConst;
extern NSString * const CityManagementUnitInfoAPIURLConst;
extern NSString * const CityManagementUnitSaveAPIURLConst;
extern NSString * const CityManagementUnitUpdateAPIURLConst;
extern NSString * const CityManagementUnitDeleteAPIURLConst;
// 区管管理单位
extern NSString * const DistrictManagementUnitAPIURLConst;
extern NSString * const DistrictManagementUnitInfoAPIURLConst;
extern NSString * const DistrictManagementUnitSaveAPIURLConst;
extern NSString * const DistrictManagementUnitUpdateAPIURLConst;
extern NSString * const DistrictManagementUnitDeleteAPIURLConst;
// 特殊业主单位
extern NSString * const SpecialOwnerUnitAPIURLConst;
extern NSString * const SpecialOwnerUnitInfoAPIURLConst;
extern NSString * const SpecialOwnerUnitSaveAPIURLConst;
extern NSString * const SpecialOwnerUnitUpdateAPIURLConst;
extern NSString * const SpecialOwnerUnitDeleteAPIURLConst;

#pragma mark - API URL for Mine

// 修改用户密码
extern NSString * const ChangeUserPwdAPIURLConst;

#pragma mark - API URL for Other

// 所有大队
extern NSString * const BrigadeAPIURLConst;
// 公共字典下拉列表
extern NSString * const CodeValuesAPIURLConst;

@end

NS_ASSUME_NONNULL_END
