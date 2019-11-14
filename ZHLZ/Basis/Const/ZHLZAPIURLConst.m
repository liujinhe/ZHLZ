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

NSString * const BaseAPIURLConst = @"http://2a3kf2.natappfree.cc";

#pragma mark - API URL for Other

NSString * const LoginAPIURLConst = @"/sys/applogin";

NSString * const UserInfoAPIURLConst = @"/app/sys/user/info";

NSString * const DepartmentAPIURLConst = @"/organize/select";

NSString * const DocumentListAPIURLConst = @"/maphome/listByFile";

NSString * const DocumentUploadAPIURLConst = @"/getData/upload";

#pragma mark - API URL for Home

NSString * const HomeBulletinAPIURLConst = @"/maphome/list";
NSString * const HomeBulletinInfoAPIURLConst = @"//maphome/info";

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

NSString * const ConstructionUnitAPIURLConst = @"/mapbuilder/list";
NSString * const ConstructionUnitInfoAPIURLConst = @"/mapbuilder/info";
NSString * const ConstructionUnitSaveAPIURLConst = @"/mapbuilder/save";
NSString * const ConstructionUnitUpdateAPIURLConst = @"/mapbuilder/update";
NSString * const ConstructionUnitDeleteAPIURLConst = @"/mapbuilder/delete";

NSString * const ApprovalDepartmentAPIURLConst = @"/mapapprover/list";
NSString * const ApprovalDepartmentInfoAPIURLConst = @"/mapapprover/info";
NSString * const ApprovalDepartmentSaveAPIURLConst = @"/mapapprover/save";
NSString * const ApprovalDepartmentUpdateAPIURLConst = @"/mapapprover/update";
NSString * const ApprovalDepartmentDeleteAPIURLConst = @"/mapapprover/delete";

NSString * const BuildUnitAPIURLConst = @"/mapconstructor/list";
NSString * const BuildUnitInfoAPIURLConst = @"/mapconstructor/info";
NSString * const BuildUnitSaveAPIURLConst = @"/mapconstructor/save";
NSString * const BuildUnitUpdateAPIURLConst = @"/mapconstructor/update";
NSString * const BuildUnitDeleteAPIURLConst = @"/mapconstructor/delete";

NSString * const CityManagementUnitAPIURLConst = @"/addressbookcity/list";
NSString * const CityManagementUnitInfoAPIURLConst = @"/addressbookcity/info";
NSString * const CityManagementUnitSaveAPIURLConst = @"/addressbookcity/save";
NSString * const CityManagementUnitUpdateAPIURLConst = @"/addressbookcity/update";
NSString * const CityManagementUnitDeleteAPIURLConst = @"/addressbookcity/delete";

NSString * const DistrictManagementUnitAPIURLConst = @"/addressbookcounty/list";
NSString * const DistrictManagementUnitInfoAPIURLConst = @"/addressbookcounty/info";
NSString * const DistrictManagementUnitSaveAPIURLConst = @"/addressbookcounty/save";
NSString * const DistrictManagementUnitUpdateAPIURLConst = @"/addressbookcounty/update";
NSString * const DistrictManagementUnitDeleteAPIURLConst = @"/addressbookcounty/delete";

NSString * const SpecialOwnerUnitAPIURLConst = @"/addressbooksowner/list";
NSString * const SpecialOwnerUnitInfoAPIURLConst = @"/addressbooksowner/info";
NSString * const SpecialOwnerUnitSaveAPIURLConst = @"/addressbooksowner/save";
NSString * const SpecialOwnerUnitUpdateAPIURLConst = @"/addressbooksowner/update";
NSString * const SpecialOwnerUnitDeleteAPIURLConst = @"/addressbooksowner/delete";

#pragma mark - API URL for Mine

NSString * const ChangeUserPwdAPIURLConst = @"/sys/user/password";

@end
