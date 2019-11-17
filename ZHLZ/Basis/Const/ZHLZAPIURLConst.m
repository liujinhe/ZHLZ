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

NSString * const DepartmentAPIURLConst = @"/organize/select";

NSString * const DocumentListAPIURLConst = @"/maphome/listByFile";

NSString * const DocumentUploadAPIURLConst = @"/getData/upload";

#pragma mark - API URL for Home

NSString * const HomeBannerAPIURLConst = @"/homeList";
NSString * const HomeBulletinAPIURLConst = @"/maphome/list";
NSString * const HomeBulletinInfoAPIURLConst = @"/maphome/info";
NSString * const HomeOccupyProblemAPIURLConst = @"/mapproblem/listByMune";
NSString * const HomeMunicipalProblemAPIURLConst = @"/mapinspection/listByMune/toMune";

NSString * const MapDisplayAPIURLConst = @"/mapinspection/ByMune/toMap";

NSString * const MunicipalProblemAPIURLConst = @"/mapinspection/list";
NSString * const MunicipalProblemInfoAPIURLConst = @"/mapinspection/info";
NSString * const MunicipalProblemGetMeasuresAPIURLConst = @"/mapinspection/getMeasures";
NSString * const MunicipalProblemSaveAPIURLConst = @"/mapinspection/save";
NSString * const MunicipalProblemUpdateAPIURLConst = @"/mapinspection/update";
NSString * const MunicipalProblemDeleteAPIURLConst = @"/mapinspection/delete";
NSString * const MunicipalProblemCloseAPIURLConst = @"/mapinspection/closepro";
NSString * const MunicipalProblemOpenAPIURLConst = @"/mapinspection/openpro";

NSString * const SafeFloodPreventionProblemAPIURLConst = @"/mapflood/list";
NSString * const SafeFloodPreventionProblemInfoAPIURLConst = @"/mapflood/list";
NSString * const SafeFloodPreventionProblemGetMeasuresAPIURLConst = @"/mapflood/getMeasures";
NSString * const SafeFloodPreventionProblemSaveAPIURLConst = @"/mapflood/save";
NSString * const SafeFloodPreventionProblemUpdateAPIURLConst = @"/mapflood/update";
NSString * const SafeFloodPreventionProblemDeleteAPIURLConst = @"/mapflood/delete";
NSString * const SafeFloodPreventionProblemCloseAPIURLConst = @"/mapflood/closepro";
NSString * const SafeFloodPreventionProblemOpenAPIURLConst = @"/mapflood/openpro";

NSString * const SafeFloodPreventionAPIURLConst = @"/mapsecurityrisks/list";
NSString * const SafeFloodPreventionInfoAPIURLConst = @"/mapsecurityrisks/list";
NSString * const SafeFloodPreventionGetMeasuresAPIURLConst = @"/mapsecurityrisks/getMeasures";
NSString * const SafeFloodPreventionSaveAPIURLConst = @"/mapsecurityrisks/save";
NSString * const SafeFloodPreventionUpdateAPIURLConst = @"/mapsecurityrisks/update";
NSString * const SafeFloodPreventionDeleteAPIURLConst = @"/mapsecurityrisks/delete";

NSString * const OccupyProblemAPIURLConst = @"/mapproblem/list";
NSString * const OccupyProblemInfoAPIURLConst = @"/mapproblem/info";
NSString * const OccupyProblemSaveAPIURLConst = @"/mapproblem/save";
NSString * const OccupyProblemUpdateAPIURLConst = @"/mapproblem/updateByPro";
NSString * const OccupyProblemDeleteAPIURLConst = @"/mapproblem/delete";
NSString * const OccupyProblemCloseAPIURLConst = @"/mapproblem/closepro";
NSString * const OccupyProblemOpenAPIURLConst = @"/mapproblem/openpro";

NSString * const CheckInPunchAPIURLConst = @"/mappunch/save";

NSString * const RoadPatrolSummaryAPIURLConst = @"/mapprtrolentry/list";

NSString * const ScanCodeUseCarAPIURLConst = @"/app/wxcar/wx";

NSString * const SummaryStatisticsAPIURLConst = @"/mapprtrolentry/statisticsBydate";

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

NSString * const ChangeUserPwdAPIURLConst = @"/sys/user/password";

@end
