//
//  ZHLZConstructionModel.h
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
             "changer": "陈辉煌",
             "createdate": "2019-11-13 14:33:09",
             "creater": "134",
             "id": "10285",
             "name": "中国电信股份有限公司广东分公司",
             "phone": "18922168006",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "范星星",
             "createdate": "2019-11-07 16:27:12",
             "creater": "134",
             "id": "10284",
             "name": "广州环城地下管廊建设投资有限公司",
             "phone": "18820029723",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "袁恒海",
             "createdate": "2019-11-06 14:49:49",
             "creater": "118",
             "id": "10283",
             "name": "广州新中轴建设有限公司",
             "phone": "15920131123",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "梁伯棠",
             "createdate": "2019-11-05 15:00:53",
             "creater": "118",
             "id": "10282",
             "name": "广州环龙高速公路有限公司",
             "phone": "13416156014",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "潘敏哲",
             "createdate": "2019-11-01 11:36:00",
             "creater": "107",
             "id": "10281",
             "name": "广州市中心区交通项目小组办公室",
             "phone": "13662459407",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "黎东文",
             "createdate": "2019-10-28 17:12:29",
             "creater": "127",
             "id": "10280",
             "name": "海珠区水务局给排水设施管理所",
             "phone": "15876784672",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "邱卓明",
             "createdate": "2019-10-25 14:16:18",
             "creater": "148",
             "id": "10279",
             "name": "广东番禺大桥有限公司",
             "phone": "13925060656",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "梁懋董",
             "createdate": "2019-10-23 16:22:43",
             "creater": "130",
             "id": "10278",
             "name": "广州燃气集团有限公司",
             "phone": "13632277928",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "冯家俊",
             "createdate": "2019-10-21 16:44:27",
             "creater": "106",
             "id": "10277",
             "name": "广州珠江实业开发股份有限公司",
             "phone": "13826130691",
             "reserve1": null,
             "reserve2": null
         }, {
             "changer": "周敏豪",
             "createdate": "2019-10-18 11:36:01",
             "creater": "107",
             "id": "10276",
             "name": "广州市城市管理机械化作业中心",
             "phone": "胡鹏飞13825056598",
             "reserve1": null,
             "reserve2": null
         }],
         "pageSize": 10,
         "totalCount": 263,
         "totalPage": 27
     }
 }
 */

@interface ConstructionList : ZHLZBaseModel

@property (nonatomic , strong) NSString *changer;

@property (nonatomic , strong) NSString *createdate;

@property (nonatomic , strong) NSString *creater;

@property (nonatomic , strong) NSString *isdelete;

@property (nonatomic , strong) NSString *phone;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *reserve1;

@property (nonatomic , strong) NSString *reserve2;

@end

@interface ZHLZConstructionModel : ZHLZBaseModel

@property (nonatomic , assign) NSInteger currPage;

@property (nonatomic , assign) NSInteger pageSize;

@property (nonatomic , assign) NSInteger totalCount;

@property (nonatomic , assign) NSInteger totalPage;

@property (nonatomic , strong) NSArray <ConstructionList *> *list;
@end

NS_ASSUME_NONNULL_END
