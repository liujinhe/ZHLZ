//
//  ZHLZHomeMapProblemModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"
#import "ZHLZHomeTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMapProblemModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *areaid;
@property (nonatomic, copy) NSString *areaname;
@property (nonatomic, copy) NSString *belong;
@property (nonatomic, copy) NSString *belongname;
@property (nonatomic, copy) NSString *contactNumber;
@property (nonatomic, copy) NSString *contentDet;
@property (nonatomic, strong) ZHLZHomeTimeModel *createdate;
@property (nonatomic, copy) NSString *createuser;
@property (nonatomic, copy) NSString *ddssjtms;
@property (nonatomic, copy) NSString *ddssjtmsNew;
@property (nonatomic, copy) NSString *deviceNo;
@property (nonatomic, copy) NSString *faxNumber;
@property (nonatomic, strong) ZHLZHomeTimeModel *finddate;
@property (nonatomic, copy) NSString *fine;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *isdelete;
@property (nonatomic, copy) NSString *islyrical;
@property (nonatomic, copy) NSString *islyricalname;
@property (nonatomic, copy) NSString *ismail;
@property (nonatomic, copy) NSString *ismailname;
@property (nonatomic, copy) NSString *isnotice;
@property (nonatomic, copy) NSString *isnoticename;
@property (nonatomic, copy) NSString *isnoticesend;
@property (nonatomic, copy) NSString *isnoticesendname;
@property (nonatomic, copy) NSString *jw;
@property (nonatomic, assign) double latX; // 经度
@property (nonatomic, copy) NSString *licensingIssue;
@property (nonatomic, copy) NSString *licensingMatter;
@property (nonatomic, assign) double lonY; // 纬度
@property (nonatomic, copy) NSString *mailTime;
@property (nonatomic, copy) NSString *noticeType;
@property (nonatomic, copy) NSString *orgid;
@property (nonatomic, copy) NSString *orgname;
@property (nonatomic, copy) NSString *phonename;
@property (nonatomic, copy) NSString *problemAttr;
@property (nonatomic, copy) NSString *problemCon;
@property (nonatomic, copy) NSString *problemDet;
@property (nonatomic, copy) NSString *problemStatus;
@property (nonatomic, copy) NSString *problemType;
@property (nonatomic, copy) NSString *problemattrname;
@property (nonatomic, copy) NSString *problemstatusname;
@property (nonatomic, copy) NSString *problemtypename;
@property (nonatomic, strong) ZHLZHomeTimeModel *profulfildate;
@property (nonatomic, copy) NSString *profulfiltype;
@property (nonatomic, copy) NSString *rectificationUnit;
@property (nonatomic, copy) NSString *responsibleUnit;
@property (nonatomic, copy) NSString *responsibleUnitName;
@property (nonatomic, copy) NSString *rodeid;
@property (nonatomic, copy) NSString *rodename;
@property (nonatomic, copy) NSString *siteDet;
@property (nonatomic, copy) NSString *uploadId;
@property (nonatomic, copy) NSString *username;

@end

NS_ASSUME_NONNULL_END
