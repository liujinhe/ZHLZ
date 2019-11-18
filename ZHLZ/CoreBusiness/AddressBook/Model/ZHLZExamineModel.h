//
//  ZHLZExamineModel.h
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
             "createdate": "2019-08-16 15:58:33",
             "creater": "118",
             "id": "10045",
             "name": "广州市天河区住房建设和园林局",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-08-14 16:44:42",
             "creater": "130",
             "id": "10044",
             "name": "广州市海珠区住房和建设局",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-05-13 08:47:50",
             "creater": "137",
             "id": "10043",
             "name": "广州市交通运输局",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-04-18 16:15:10",
             "creater": "127",
             "id": "10042",
             "name": "广州市交通局",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-04-18 08:50:26",
             "creater": "114",
             "id": "10041",
             "name": "广州市住房和城乡建设委",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-04-01 14:16:40",
             "creater": "106",
             "id": "10040",
             "name": "白云区人民政府防汛防旱防风指挥所",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-03-25 16:33:35",
             "creater": "127",
             "id": "10039",
             "name": "海珠区人民政府防汛防旱防风指挥所",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-03-04 11:39:14",
             "creater": "108",
             "id": "10038",
             "name": "广州市防汛防旱防风总指挥部",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": "2019-03-04 11:38:12",
             "creater": "108",
             "id": "10037",
             "name": "广州市",
             "reserve1": null,
             "reserve2": null
         }, {
             "createdate": null,
             "creater": "86",
             "id": "10036",
             "name": "广州市白云区住房和建设局",
             "reserve1": null,
             "reserve2": null
         }],
         "pageSize": 10,
         "totalCount": 46,
         "totalPage": 5
     }
 }
 */

@interface ExamineList : ZHLZBaseModel

@property (nonatomic , strong) NSString *createdate;

@property (nonatomic , strong) NSString *creater;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *reserve1;

@property (nonatomic , strong) NSString *reserve2;

@end


@interface ZHLZExamineModel : ZHLZBaseModel

@property (nonatomic , assign) NSInteger currPage;

@property (nonatomic , assign) NSInteger pageSize;

@property (nonatomic , assign) NSInteger totalCount;

@property (nonatomic , assign) NSInteger totalPage;

@property (nonatomic , strong) NSArray <ExamineList *> *list;

@end

NS_ASSUME_NONNULL_END
