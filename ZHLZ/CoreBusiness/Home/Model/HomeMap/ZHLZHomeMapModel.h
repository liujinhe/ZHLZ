//
//  ZHLZHomeMapModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"
#import "ZHLZHomeTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMapModel : ZHLZBaseModel

//@property (nonatomic, copy) NSString *areaid;
//@property (nonatomic, copy) NSString *areaname;
//@property (nonatomic, copy) NSString *belong;
//@property (nonatomic, copy) NSString *belongname;
//@property (nonatomic, copy) NSString *contactNumber;
//@property (nonatomic, copy) NSString *contentDet;
//@property (nonatomic, strong) ZHLZHomeTimeModel *createdate;
//@property (nonatomic, copy) NSString *createuser;
//@property (nonatomic, copy) NSString *ddssjtms;
//@property (nonatomic, copy) NSString *ddssjtmsNew;
//@property (nonatomic, copy) NSString *deviceNo;
//@property (nonatomic, copy) NSString *faxNumber;
//@property (nonatomic, strong) ZHLZHomeTimeModel *finddate;
//@property (nonatomic, copy) NSString *fine;
//@property (nonatomic, copy) NSString *fullname;
//@property (nonatomic, copy) NSString *imgurl;
//@property (nonatomic, copy) NSString *isdelete;
//@property (nonatomic, copy) NSString *islyrical;
//@property (nonatomic, copy) NSString *islyricalname;
//@property (nonatomic, copy) NSString *ismail;
//@property (nonatomic, copy) NSString *ismailname;
//@property (nonatomic, copy) NSString *isnotice;
//@property (nonatomic, copy) NSString *isnoticename;
//@property (nonatomic, copy) NSString *isnoticesend;
//@property (nonatomic, copy) NSString *isnoticesendname;
//@property (nonatomic, copy) NSString *jw;
//@property (nonatomic, assign) double latX; // 经度
//@property (nonatomic, copy) NSString *licensingIssue;
//@property (nonatomic, copy) NSString *licensingMatter;
//@property (nonatomic, assign) double lonY; // 纬度
//@property (nonatomic, copy) NSString *mailTime;
//@property (nonatomic, copy) NSString *noticeType;
//@property (nonatomic, copy) NSString *orgid;
//@property (nonatomic, copy) NSString *orgname;
//@property (nonatomic, copy) NSString *phonename;
//@property (nonatomic, copy) NSString *problemAttr;
//@property (nonatomic, copy) NSString *problemCon;
//@property (nonatomic, copy) NSString *problemDet;
//@property (nonatomic, copy) NSString *problemStatus;
//@property (nonatomic, copy) NSString *problemType;
//@property (nonatomic, copy) NSString *problemattrname;
//@property (nonatomic, copy) NSString *problemstatusname;
//@property (nonatomic, copy) NSString *problemtypename;
//@property (nonatomic, strong) ZHLZHomeTimeModel *profulfildate;
//@property (nonatomic, copy) NSString *profulfiltype;
//@property (nonatomic, copy) NSString *rectificationUnit;
//@property (nonatomic, copy) NSString *responsibleUnit;
//@property (nonatomic, copy) NSString *responsibleUnitName;
//@property (nonatomic, copy) NSString *rodeid;
//@property (nonatomic, copy) NSString *rodename;
//@property (nonatomic, copy) NSString *siteDet;
//@property (nonatomic, copy) NSString *uploadId;
//@property (nonatomic, copy) NSString *username;


@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, assign) NSInteger focuson;
@property (nonatomic, strong) ZHLZHomeTimeModel *finishdate;
@property (nonatomic, assign) NSInteger pronum;


@property (nonatomic, copy) NSString *a;
@property (nonatomic, copy) NSString *approverId;
@property (nonatomic, copy) NSString *approverName;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *areaid;
@property (nonatomic, copy) NSString *b;
@property (nonatomic, copy) NSString *belong;
@property (nonatomic, copy) NSString *bid;
@property (nonatomic, copy) NSString *bidName;
@property (nonatomic, copy) NSString *builderCharger;
@property (nonatomic, copy) NSString *builderId;
@property (nonatomic, copy) NSString *builderName;
@property (nonatomic, copy) NSString *builderPhone;
@property (nonatomic, copy) NSString *c;
@property (nonatomic, copy) NSString *constructorChanger;
@property (nonatomic, copy) NSString *constructorId;
@property (nonatomic, copy) NSString *constructorName;
@property (nonatomic, copy) NSString *constructorPhone;
@property (nonatomic, assign) double coordinatesX; // 经度
@property (nonatomic, assign) double coordinatesXs;
@property (nonatomic, assign) double coordinatesY; // 纬度
@property (nonatomic, assign) double coordinatesYs;
@property (nonatomic, strong) ZHLZHomeTimeModel *createdate;
@property (nonatomic, copy) NSString *d;
@property (nonatomic, copy) NSString *e;
@property (nonatomic, copy) NSString *enddateNew;
@property (nonatomic, copy) NSString *f;
@property (nonatomic, copy) NSString *frequency;
@property (nonatomic, copy) NSString *frequencyName;
@property (nonatomic, copy) NSString *g;
@property (nonatomic, copy) NSString *h;
@property (nonatomic, copy) NSString *i;
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *j;
@property (nonatomic, copy) NSString *k;
@property (nonatomic, copy) NSString *l;
@property (nonatomic, copy) NSString *licenseId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *noNew;
@property (nonatomic, copy) NSString *position;
//    "practicaldate": null,
//    "practicaldatetos": null,
@property (nonatomic, copy) NSString *projStatus;
@property (nonatomic, copy) NSString *projectno;
@property (nonatomic, copy) NSString *projectstatusId;
@property (nonatomic, assign) NSInteger projecttypeId;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *selVal;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *uploadId;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *yq;

@end

NS_ASSUME_NONNULL_END
