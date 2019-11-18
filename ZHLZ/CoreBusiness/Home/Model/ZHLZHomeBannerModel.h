//
//  ZHLZHomeBannerModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeBannerCreatTimeModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *seconds;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, copy) NSString *timezoneOffset;

@end

@interface ZHLZHomeBannerModel : ZHLZBaseModel

@property (nonatomic, strong) ZHLZHomeBannerCreatTimeModel *creatTime;

@property (nonatomic, copy) NSString *dateid;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileSize;
@property (nonatomic, copy) NSString *fileTime;
@property (nonatomic, copy) NSString *fileType;
@property (nonatomic, copy) NSString *fileid;
@property (nonatomic, copy) NSString *isdelete;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uploadId;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
