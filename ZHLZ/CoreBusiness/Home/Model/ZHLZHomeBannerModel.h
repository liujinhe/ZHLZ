//
//  ZHLZHomeBannerModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"
#import "ZHLZHomeTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeBannerModel : ZHLZBaseModel

@property (nonatomic, strong) ZHLZHomeTimeModel *creatTime;

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
