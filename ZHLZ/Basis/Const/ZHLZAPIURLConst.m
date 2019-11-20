//
//  ZHLZAPIURLConst.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZAPIURLConst.h"

@implementation ZHLZAPIURLConst

#pragma mark - API Base URL

NSString * const BaseAPIURLConst = @"http://www.yusuisoft.com:8080";

#pragma mark - API URL for Other

NSString * const LoginAPIURLConst = @"/sys/applogin";

NSString * const UserInfoAPIURLConst = @"/app/sys/user/info";

NSString * const DepartmentAPIURLConst = @"/app/organize/select";

NSString * const DocumentListAPIURLConst = @"/app/maphome/listByFile";

NSString * const DocumentUploadAPIURLConst = @"/app/getData/upload";

#pragma mark - API URL for Home

NSString * const HomeBannerAPIURLConst = @"/app/homeList/4";
NSString * const HomeBulletinAPIURLConst = @"/app/maphome/list";
NSString * const HomeBulletinInfoAPIURLConst = @"/app/maphome/info";
NSString * const HomeOccupyProblemAPIURLConst = @"/app/mapproblem/listByMune";
NSString * const HomeMunicipalProblemAPIURLConst = @"/app/mapinspection/listByMune/toMune";

NSString * const MapDisplayAPIURLConst = @"/app/mapproject/ToMap";

NSString * const MunicipalProblemAPIURLConst = @"/app/mapinspection/list";
NSString * const MunicipalProblemInfoAPIURLConst = @"/app/mapinspection/info";
NSString * const MunicipalProblemGetMeasuresAPIURLConst = @"/app/mapinspection/getMeasures";
NSString * const MunicipalProblemSaveAPIURLConst = @"/app/mapinspection/save";
NSString * const MunicipalProblemUpdateAPIURLConst = @"/app/mapinspection/update";
NSString * const MunicipalProblemDeleteAPIURLConst = @"/app/mapinspection/delete";
NSString * const MunicipalProblemCloseAPIURLConst = @"/app/mapinspection/closepro";
NSString * const MunicipalProblemOpenAPIURLConst = @"/app/mapinspection/openpro";

// 在建项目
NSString * const ProjectBuildeListAPIURLConst = @"/app/mapproject/list";

NSString * const SafeFloodPreventionProblemAPIURLConst = @"/app/mapflood/list";
NSString * const SafeFloodPreventionProblemInfoAPIURLConst = @"/app/mapflood/list";
NSString * const SafeFloodPreventionProblemGetMeasuresAPIURLConst = @"/app/mapflood/getMeasures";
NSString * const SafeFloodPreventionProblemSaveAPIURLConst = @"/app/mapflood/save";
NSString * const SafeFloodPreventionProblemUpdateAPIURLConst = @"/app/mapflood/update";
NSString * const SafeFloodPreventionProblemDeleteAPIURLConst = @"/app/mapflood/delete";
NSString * const SafeFloodPreventionProblemCloseAPIURLConst = @"/app/mapflood/closepro";
NSString * const SafeFloodPreventionProblemOpenAPIURLConst = @"/app/mapflood/openpro";

NSString * const SafeFloodPreventionAPIURLConst = @"/app/mapsecurityrisks/list";
NSString * const SafeFloodPreventionInfoAPIURLConst = @"/app/mapsecurityrisks/list";
NSString * const SafeFloodPreventionGetMeasuresAPIURLConst = @"/app/mapsecurityrisks/getMeasures";
NSString * const SafeFloodPreventionSaveAPIURLConst = @"/app/mapsecurityrisks/save";
NSString * const SafeFloodPreventionUpdateAPIURLConst = @"/app/mapsecurityrisks/update";
NSString * const SafeFloodPreventionDeleteAPIURLConst = @"/app/mapsecurityrisks/delete";

NSString * const OccupyProblemAPIURLConst = @"/app/mapproblem/list";
NSString * const OccupyProblemInfoAPIURLConst = @"/app/mapproblem/info";
NSString * const OccupyProblemSaveAPIURLConst = @"/app/mapproblem/save";
NSString * const OccupyProblemUpdateAPIURLConst = @"/app/mapproblem/updateByPro";
NSString * const OccupyProblemDeleteAPIURLConst = @"/app/mapproblem/delete";
NSString * const OccupyProblemCloseAPIURLConst = @"/app/mapproblem/closepro";
NSString * const OccupyProblemOpenAPIURLConst = @"/app/mapproblem/openpro";

NSString * const CheckInPunchAPIURLConst = @"/app/mappunch/save";

NSString * const RoadPatrolSummaryAPIURLConst = @"/app/mapprtrolentry/list";

NSString * const ScanCodeUseCarAPIURLConst = @"/app/wxcar/wx";

NSString * const SummaryStatisticsAPIURLConst = @"/app/mapprtrolentry/statisticsBydate";

#pragma mark - API URL for AddressBook

NSString * const ResponsibleUnitAPIURLConst = @"/app/responsibleunit/list";
NSString * const ResponsibleUnitInfoAPIURLConst = @"/app/responsibleunit/info";
NSString * const ResponsibleUnitSaveAPIURLConst = @"/app/responsibleunit/save";
NSString * const ResponsibleUnitUpdateAPIURLConst = @"/app/responsibleunit/update";
NSString * const ResponsibleUnitDeleteAPIURLConst = @"/app/responsibleunit/delete";

NSString * const ConstructionUnitAPIURLConst = @"/app/mapbuilder/list";
NSString * const ConstructionUnitInfoAPIURLConst = @"/app/mapbuilder/info";
NSString * const ConstructionUnitSaveAPIURLConst = @"/app/mapbuilder/save";
NSString * const ConstructionUnitUpdateAPIURLConst = @"/app/mapbuilder/update";
NSString * const ConstructionUnitDeleteAPIURLConst = @"/app/mapbuilder/delete";

NSString * const ApprovalDepartmentAPIURLConst = @"/app/mapapprover/list";
NSString * const ApprovalDepartmentInfoAPIURLConst = @"/app/mapapprover/info";
NSString * const ApprovalDepartmentSaveAPIURLConst = @"/app/mapapprover/save";
NSString * const ApprovalDepartmentUpdateAPIURLConst = @"/app/mapapprover/update";
NSString * const ApprovalDepartmentDeleteAPIURLConst = @"/app/mapapprover/delete";

NSString * const BuildUnitAPIURLConst = @"/app/mapconstructor/list";
NSString * const BuildUnitInfoAPIURLConst = @"/app/mapconstructor/info";
NSString * const BuildUnitSaveAPIURLConst = @"/app/mapconstructor/save";
NSString * const BuildUnitUpdateAPIURLConst = @"/app/mapconstructor/update";
NSString * const BuildUnitDeleteAPIURLConst = @"/app/mapconstructor/delete";

NSString * const CityManagementUnitAPIURLConst = @"/app/addressbookcity/list";
NSString * const CityManagementUnitInfoAPIURLConst = @"/app/addressbookcity/info";
NSString * const CityManagementUnitSaveAPIURLConst = @"/app/addressbookcity/save";
NSString * const CityManagementUnitUpdateAPIURLConst = @"/app/addressbookcity/update";
NSString * const CityManagementUnitDeleteAPIURLConst = @"/app/addressbookcity/delete";

NSString * const DistrictManagementUnitAPIURLConst = @"/app/addressbookcounty/list";
NSString * const DistrictManagementUnitInfoAPIURLConst = @"/app/addressbookcounty/info";
NSString * const DistrictManagementUnitSaveAPIURLConst = @"/app/addressbookcounty/save";
NSString * const DistrictManagementUnitUpdateAPIURLConst = @"/app/addressbookcounty/update";
NSString * const DistrictManagementUnitDeleteAPIURLConst = @"/app/addressbookcounty/delete";

NSString * const SpecialOwnerUnitAPIURLConst = @"/app/addressbooksowner/list";
NSString * const SpecialOwnerUnitInfoAPIURLConst = @"/app/addressbooksowner/info";
NSString * const SpecialOwnerUnitSaveAPIURLConst = @"/app/addressbooksowner/save";
NSString * const SpecialOwnerUnitUpdateAPIURLConst = @"/app/addressbooksowner/update";
NSString * const SpecialOwnerUnitDeleteAPIURLConst = @"/app/addressbooksowner/delete";

#pragma mark - API URL for Mine

NSString * const ChangeUserPwdAPIURLConst = @"/app/sys/user/password";

@end
