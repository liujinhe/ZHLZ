//
//  ZHLZHomeMunicipalProblemSubmitModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
[{"orgid":"b91d217f5f","areaid":"3","belong":"2","id":"","problemType":"道路养护及附属设施维护","classAndContent":"道路养护及附属设施维护\/道路路面\/人行道\/松动 ","finddate":"2019-11-29","responsibleUnit":"150","problemDet":"6666666","siteDet":"666666","createuser":"148","contactNumber":"12345678900","fine":"10","islyrical":"1","latX":"113.3194","lonY":"23.039527","label":"22222","contentDet":"666666","uploadid":"1c01514ca1e94f24bcdf17439c49fa06","ddssjtms":"于2019-11-29对该问题进行了\"执法建议书,责令停止违法行为通知书,责令（限期改正通知书）,\"的措施"},
 */

@interface ZHLZHomeMunicipalProblemSubmitModel : ZHLZBaseModel
@property (nonatomic, copy) NSString *orgid;
@property (nonatomic, copy) NSString *areaid;
@property (nonatomic, copy) NSString *belong;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *problemType;
@property (nonatomic, copy) NSString *classAndContent;
@property (nonatomic, copy) NSString *finddate;
@property (nonatomic, copy) NSString *responsibleUnit;
@property (nonatomic, copy) NSString *problemDet;
@property (nonatomic, copy) NSString *siteDet;
@property (nonatomic, copy) NSString *createuser;
@property (nonatomic, copy) NSString *contactNumber;
@property (nonatomic, copy) NSString *fine;
@property (nonatomic, copy) NSString *islyrical;
@property (nonatomic, copy) NSString *latX;
@property (nonatomic, copy) NSString *lonY;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *contentDet;
@property (nonatomic, copy) NSString *uploadid;
@property (nonatomic, copy) NSString *ddssjtms;

@end

NS_ASSUME_NONNULL_END
