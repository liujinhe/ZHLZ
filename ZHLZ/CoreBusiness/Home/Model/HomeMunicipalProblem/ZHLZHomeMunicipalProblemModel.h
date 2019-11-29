//
//  ZHLZHomeMunicipalProblemModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/*
 "data": {
     "areaid": "3",
     "areaname": "南北片",
     "belong": "3",
     "belongname": null,
     "contactNumber": "",
     "contentDet": "IMG_66571IMG_6609",
     "createdate": "2019-11-13 11:53:26",
     "createuser": "114",
     "ddssjtms": "于2019-11-13对该问题进行\"微信/电话督办\"的措施",
     "ddssjtmsNew": null,
     "deviceNo": null,
     "faxNumber": null,
     "finddate": "2019-11-13 00:00:00",
     "fine": "",
     "fullname": "苏茹",
     "id": "15779",
     "imgurl": "/photo/20191113/17167487914796154.jpg,/photo/20191113/17167543936847280.JPG",
     "isdelete": "1",
     "islyrical": "0",
     "islyricalname": "否",
     "ismail": null,
     "ismailname": null,
     "isnotice": null,
     "isnoticename": null,
     "isnoticesend": "0",
     "isnoticesendname": null,
     "jw": null,
     "latX": "",
     "licensingIssue": null,
     "licensingMatter": null,
     "lonY": "",
     "mailTime": null,
     "noticeType": null,
     "orgid": "b91d217f5f",
     "orgname": "二大队",
     "phonename": null,
     "problemAttr": null,
     "problemCon": null,
     "problemDet": "人行天桥工程围蔽警示桩折断",
     "problemStatus": "1",
     "problemType": "道路养护及附属设施维护",
     "problemattrname": null,
     "problemstatusname": null,
     "problemtypename": null,
     "profulfildate": null,
     "profulfiltype": null,
     "rectificationUnit": null,
     "responsibleUnit": "136",
     "responsibleUnitName": "广州市中心区交通项目管理中心",
     "rodeid": null,
     "rodename": null,
     "siteDet": "芳村大道西路东往西方向，广佛放射线桥底",
     "uploadId": "F91D1D6409EAA14081B474AE47B56E0B",
     "username": null
 }
 
 */

@interface ZHLZHomeMunicipalProblemModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *areaid;
@property (nonatomic, copy) NSString *areaname;
@property (nonatomic, copy) NSString *belong;
@property (nonatomic, copy) NSString *belongname;
@property (nonatomic, copy) NSString *contactNumber;
@property (nonatomic, copy) NSString *contentDet;
@property (nonatomic, copy) NSString *createdate;
@property (nonatomic, copy) NSString *createuser;
@property (nonatomic, copy) NSString *ddssjtms;
@property (nonatomic, copy) NSString *ddssjtmsNew;
@property (nonatomic, copy) NSString *deviceNo;
@property (nonatomic, copy) NSString *faxNumber;
@property (nonatomic, copy) NSString *finddate;
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
@property (nonatomic, copy) NSString *latX;
@property (nonatomic, copy) NSString *licensingIssue;
@property (nonatomic, copy) NSString *licensingMatter;
@property (nonatomic, copy) NSString *lonY;
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
@property (nonatomic, copy) NSString *profulfildate;
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
