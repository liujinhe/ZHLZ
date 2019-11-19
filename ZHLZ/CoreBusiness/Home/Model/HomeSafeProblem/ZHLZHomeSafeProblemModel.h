//
//  ZHLZHomeSafeProblemModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/*
 areaid = 9;
 belong = 2;
 belongname = "\U6d77\U73e0\U533a";
 currentPlace = "\U73e0\U6c5f\U8def2019\U53f7";
 ddssjtms = "\U4e8e2019-11-19\U5bf9\U8be5\U95ee\U9898\U8fdb\U884c\"\U8d23\U4ee4\U6539\U6b63\"\U7684\U63aa\U65bd";
 finddate = "2019-11-19 00:00:00";
 id = 10005;
 imgurl = "<null>";
 isdelete = 1;
 measure = "<null>";
 orgName = "\U4e94\U5927\U961f";
 orgid = d95ff7b9bb;
 phonename = "<null>";
 photoNo = "<null>";
 prodescription = "";
 profulfildate = "<null>";
 profulfiltype = "<null>";
 promanager = 1;
 promanagername = "\U8d85\U7ea7\U7ba1\U7406\U5458";
 prostatus = 0;
 remark = "";
 risksid = 10;
 uploadId = 4F97228DAEFCD8239A1020C4E4829975;
 */

@interface ZHLZHomeSafeProblemModel : ZHLZBaseModel

@property (nonatomic , assign) NSInteger areaid;

@property (nonatomic , assign) NSInteger belong;

@property (nonatomic , copy) NSString *belongname;

@property (nonatomic , copy) NSString *currentPlace;

@property (nonatomic , copy) NSString *ddssjtms;

@property (nonatomic , copy) NSString *finddate;

@property (nonatomic , copy) NSString *imgurl;

@property (nonatomic , assign) NSInteger isdelete;

@property (nonatomic , copy) NSString *measure;

@property (nonatomic , copy) NSString *orgName;

@property (nonatomic , copy) NSString *orgid;

@property (nonatomic , copy) NSString *phonename;

@property (nonatomic , copy) NSString *photoNo;

@property (nonatomic , copy) NSString *prodescription;

@property (nonatomic , copy) NSString *profulfildate;

@property (nonatomic , copy) NSString *profulfiltype;

@property (nonatomic , assign) NSInteger promanager;

@property (nonatomic , copy) NSString *promanagername;

@property (nonatomic , assign) NSInteger prostatus;

@property (nonatomic , copy) NSString *remark;

@property (nonatomic , assign) NSInteger risksid;

@property (nonatomic , copy) NSString *uploadId;


@end

NS_ASSUME_NONNULL_END
