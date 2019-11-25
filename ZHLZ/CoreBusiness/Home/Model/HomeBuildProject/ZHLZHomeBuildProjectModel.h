//
//  ZHLZHomeBuildProjectModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
 a = "<null>";
 approverId = 10043;
 approverName = "\U5e7f\U5dde\U5e02\U4ea4\U901a\U8fd0\U8f93\U5c40";
 area = "\U957f\Uff1a200\U7c73\Uff1b\U5bbd\U4e3a\Uff1a3.5\U7c73\Uff1b\U9762\U79ef\U4e3a\Uff1a700\U5e73\U65b9\U7c73\Uff1b";
 areaid = 2;
 b = "<null>";
 belong = 14;
 bid = c809027911;
 bidName = "\U4e00\U5927\U961f";
 builderCharger = "<null>";
 builderId = 10260;
 builderName = "\U5e7f\U5dde\U5e02\U4e2d\U5fc3\U533a\U4ea4\U901a\U9879\U76ee\U9886\U5bfc\U5c0f\U7ec4\U529e\U516c\U5ba4\U8054\U7cfb\U4eba\U65b9\U5f0f:(\U6f58\U654f\U54f2)13662459407";
 builderPhone = "<null>";
 c = "<null>";
 constructorChanger = "<null>";
 constructorId = 10281;
 constructorName = "\U5e7f\U5dde\U5e02\U4e2d\U5fc3\U533a\U4ea4\U901a\U9879\U76ee\U5c0f\U7ec4\U529e\U516c\U5ba4\U8054\U7cfb\U4eba\U65b9\U5f0f:(\U6f58\U654f\U54f2)13662459407";
 constructorPhone = "<null>";
 coordinatesX = "113.28179";
 coordinatesXs = "<null>";
 coordinatesY = "23.11238";
 coordinatesYs = "<null>";
 createdate = "2019-07-01 00:00:00";
 d = "<null>";
 e = "<null>";
 enddateNew = "2019-07-01\U81f32019-12-31";
 f = "<null>";
 finishdate = "2019-12-31 00:00:00";
 focuson = 2;
 frequency = 5;
 frequencyName = "\U534a\U6708\U4e00\U5de1";
 g = "<null>";
 h = "<null>";
 i = "<null>";
 id = 10230;
 imgurl = "<null>";
 j = "<null>";
 k = "<null>";
 l = "<null>";
 licenseId = Z20190600015;
 name = "\U201c\U56db\U6865\U4e00\U96a7\U201d\Uff08\U4eba\U6c11\U6865\U3001\U6d77\U73e0\U6865\U3001\U6d77\U5370\U6865\U3001\U5e7f\U5dde\U6865\U3001\U73e0\U6c5f\U96a7\U9053\Uff09\U7ef4\U62a4\U4fdd\U6d01\U670d\U52a1\U91c7\U8d2d\U9879\U76ee";
 noNew = "<null>";
 position = "\U5176\U4e2d\U4e00\U5927\U961f\U8d1f\U8d23\Uff08\U6d77\U5370\U6865K0+000-K1+131\U3001\U5e7f\U5dde\U6865K0+000-K1+330\Uff09\Uff09";
 practicaldate = "<null>";
 practicaldatetos = "<null>";
 projStatus = "<null>";
 projectno = "\U4e00\U5927\U961f[2019]029\U53f7";
 projectstatusId = 1;
 projecttypeId = 1;
 pronum = 0;
 remark = "";
 selVal = "<null>";
 statusName = "\U5728\U5efa\U65bd\U5de5";
 typeName = "\U517b\U62a4\U53ca\U5176\U4ed6";
 uploadId = ACF729AAA8BF6710C776D6D56049F397;
 uuid = "<null>";
 yq = "<null>";
 */
@interface ZHLZHomeBuildProjectModel : ZHLZBaseModel

@property (nonatomic , strong) NSString *a;
@property (nonatomic , strong) NSString *approverId;
@property (nonatomic , strong) NSString *approverName;
@property (nonatomic , strong) NSString *area;
@property (nonatomic , strong) NSString *areaid;
@property (nonatomic , strong) NSString *b;
@property (nonatomic , strong) NSString *belong;
@property (nonatomic , strong) NSString *bid;
@property (nonatomic , strong) NSString *bidName;
@property (nonatomic , strong) NSString *builderCharger;
@property (nonatomic , strong) NSString *builderId;
@property (nonatomic , strong) NSString *builderName;
@property (nonatomic , strong) NSString *builderPhone;
@property (nonatomic , strong) NSString *c;
@property (nonatomic , strong) NSString *constructorChanger;
@property (nonatomic , strong) NSString *constructorId;
@property (nonatomic , strong) NSString *constructorName;
@property (nonatomic , strong) NSString *constructorPhone;
@property (nonatomic , strong) NSString *coordinatesX;
@property (nonatomic , strong) NSString *coordinatesXs;
@property (nonatomic , strong) NSString *coordinatesY;
@property (nonatomic , strong) NSString *coordinatesYs;
@property (nonatomic , strong) NSString *createdate;
@property (nonatomic , strong) NSString *d;
@property (nonatomic , strong) NSString *e;
@property (nonatomic , strong) NSString *enddateNew;
@property (nonatomic , strong) NSString *f;
@property (nonatomic , strong) NSString *finishdate;
@property (nonatomic , strong) NSString *focuson;
@property (nonatomic , strong) NSString *frequency;
@property (nonatomic , strong) NSString *frequencyName;
@property (nonatomic , strong) NSString *g;
@property (nonatomic , strong) NSString *h;
@property (nonatomic , strong) NSString *i;
@property (nonatomic , strong) NSString *j;
@property (nonatomic , strong) NSString *k;
@property (nonatomic , strong) NSString *l;
@property (nonatomic , strong) NSString *licenseId;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *noNew;
@property (nonatomic , strong) NSString *position;
@property (nonatomic , strong) NSString *practicaldate;
@property (nonatomic , strong) NSString *practicaldatetos;
@property (nonatomic , strong) NSString *projStatus;
@property (nonatomic , strong) NSString *projectno;
@property (nonatomic , strong) NSString *projectstatusId;
@property (nonatomic , strong) NSString *projecttypeId;
@property (nonatomic , strong) NSString *pronum;
@property (nonatomic , strong) NSString *remark;
@property (nonatomic , strong) NSString *selVal;
@property (nonatomic , strong) NSString *statusName;
@property (nonatomic , strong) NSString *typeName;
@property (nonatomic , strong) NSString *uploadId;
@property (nonatomic , strong) NSString *uuid;
@property (nonatomic , strong) NSString *yq;
@property (nonatomic , strong) NSString *belongname;

@end

NS_ASSUME_NONNULL_END
