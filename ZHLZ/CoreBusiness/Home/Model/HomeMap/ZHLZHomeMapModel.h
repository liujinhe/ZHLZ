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
