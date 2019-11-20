//
//  ZHLZHomeBusinessDocumentModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
 "creatTime": "2019-01-16 11:56:16",
 "dateid": "92",
 "describe": null,
 "fileName": "关于启动市管设施安全监管“金色”路政专项行动的通知.docx",
 "fileSize": "16104",
 "fileTime": "2019-01-16 11:56:16",
 "fileType": ".docx",
 "fileid": "4772",
 "isdelete": "1",
 "title": null,
 "type": "2",
 "uploadId": "EFA9B6155C7910DF58273B26A2B291A4",
 "url": "/photo/20190116/3095321134535813.docx",
 "userId": "1"
 */
@interface ZHLZHomeBusinessDocumentModel : ZHLZBaseModel

@property (nonatomic , strong) NSString *creatTime;
@property (nonatomic , strong) NSString *dateid;
@property (nonatomic , strong) NSString *describe;
@property (nonatomic , strong) NSString *fileName;
@property (nonatomic , strong) NSString *fileSize;
@property (nonatomic , strong) NSString *fileTime;
@property (nonatomic , strong) NSString *fileType;
@property (nonatomic , strong) NSString *fileid;
@property (nonatomic , strong) NSString *isdelete;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *type;
@property (nonatomic , strong) NSString *uploadId;
@property (nonatomic , strong) NSString *url;
@property (nonatomic , strong) NSString *userId;

@end

NS_ASSUME_NONNULL_END
