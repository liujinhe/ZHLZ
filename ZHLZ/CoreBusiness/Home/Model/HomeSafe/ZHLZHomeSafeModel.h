//
//  ZHLZHomeSafeModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
 currentPlace = "\U73e0\U6c5f\U8def2019\U53f7";
 id = 10;
 imgurl = "<null>";
 orgId = d95ff7b9bb;
 orgName = "\U4e94\U5927\U961f";
 photoNumber = "";
 prodescription = "\U73e0\U6c5f\U8def\U7eff\U5316\U7ef4\U62a4";
 unitCharger = "\U8096\U6656";
 unitId = 144;
 unitName = "\U8354\U6e7e\U533a\U591a\U5b9d\U8857\U9053\U529e\U4e8b\U5904";
 unitPhone = "";
 uploadId = 14F14D9450C6B03DAB2391BD2F858434;
 workMeasures = "\U7eff\U5316\U7ef4\U62a4";
 workRecord = "\U7eff\U5316\U635f\U574f";
 */
@interface ZHLZHomeSafeModel : ZHLZBaseModel

@property (nonatomic , copy) NSString *currentPlace;
@property (nonatomic , copy) NSString *imgurl;
@property (nonatomic , copy) NSString *orgId;
@property (nonatomic , copy) NSString *orgName;
@property (nonatomic , copy) NSString *photoNumber;
@property (nonatomic , copy) NSString *prodescription;
@property (nonatomic , copy) NSString *unitCharger;
@property (nonatomic , assign) NSInteger unitId;
@property (nonatomic , copy) NSString *unitName;
@property (nonatomic , copy) NSString *unitPhone;
@property (nonatomic , copy) NSString *uploadId;
@property (nonatomic , copy) NSString *workMeasures;
@property (nonatomic , copy) NSString *workRecord;

@end

NS_ASSUME_NONNULL_END
