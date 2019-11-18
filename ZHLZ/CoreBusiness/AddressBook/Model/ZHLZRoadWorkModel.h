//
//  ZHLZRoadWorkModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
 {
     "msg": "返回成功",
     "code": 0,
     "data": {
         "currPage": 1,
         "list": [{
             "charger": "曾庆生",
             "createdate": "2019-11-13 14:34:03",
             "creater": "134",
             "id": "10267",
             "name": "中国电信股份有限公司广东分公司",
             "phone": "13751700456",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "郑洪宏",
             "createdate": "2019-11-13 11:40:05",
             "creater": "106",
             "id": "10266",
             "name": "中铁隧道局集团有限公司",
             "phone": "13928778757",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "苏醒",
             "createdate": "2019-11-08 15:02:26",
             "creater": "134",
             "id": "10265",
             "name": "中铁五局集团有限公司",
             "phone": "17512029766",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "刘伟",
             "createdate": "2019-11-06 16:47:11",
             "creater": "107",
             "id": "10264",
             "name": "广州市芳村市政园林建设工程有限公司",
             "phone": "13632430606",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "黎子荣",
             "createdate": "2019-11-06 14:50:37",
             "creater": "118",
             "id": "10263",
             "name": "广州机施建设集团有限公司",
             "phone": "13826213389",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "黎巨华",
             "createdate": "2019-11-05 15:11:35",
             "creater": "118",
             "id": "10262",
             "name": "广东诚泰交通科技发展有限公司",
             "phone": "13432044037",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": " 梁工",
             "createdate": "2019-11-04 16:24:50",
             "creater": "107",
             "id": "10261",
             "name": "广东泰通建设有限公司",
             "phone": "185 7533 0092‬",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "潘敏哲",
             "createdate": "2019-11-01 11:37:33",
             "creater": "107",
             "id": "10260",
             "name": "广州市中心区交通项目领导小组办公室",
             "phone": "13662459407",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "关晓琳",
             "createdate": "2019-10-29 17:07:55",
             "creater": "127",
             "id": "10259",
             "name": "广东金辉华集团有限公司",
             "phone": "18073636707",
             "reserve1": null,
             "reserve2": null
         }, {
             "charger": "吴工",
             "createdate": "2019-10-28 17:14:21",
             "creater": "127",
             "id": "10258",
             "name": "广东水电二局股份有限公司",
             "phone": "17373384985",
             "reserve1": null,
             "reserve2": null
         }],
         "pageSize": 10,
         "totalCount": 264,
         "totalPage": 27
     }
 }
 */


@interface RoadWorkList : ZHLZBaseModel

@property (nonatomic , strong) NSString *charger;

@property (nonatomic , strong) NSString *createdate;

@property (nonatomic , strong) NSString *creater;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *phone;

@property (nonatomic , strong) NSString *reserve1;

@property (nonatomic , strong) NSString *reserve2;

@end

@interface ZHLZRoadWorkModel : ZHLZBaseModel

@property (nonatomic , assign) NSInteger currPage;

@property (nonatomic , assign) NSInteger pageSize;

@property (nonatomic , assign) NSInteger totalCount;

@property (nonatomic , assign) NSInteger totalPage;

@property (nonatomic , strong) NSArray <RoadWorkList *> *list;
@end

NS_ASSUME_NONNULL_END
