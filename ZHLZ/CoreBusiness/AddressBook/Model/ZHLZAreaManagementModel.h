//
//  ZHLZAreaManagementModel.h
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
             "charger": "星星",
             "createdate": null,
             "creater": null,
             "id": "1",
             "isdelete": null,
             "name": "广州动物园",
             "phone": "13691770002"
         }],
         "pageSize": 10,
         "totalCount": 1,
         "totalPage": 1
     }
 }
 */
@interface AreaManagementList : ZHLZBaseModel

@property (nonatomic , strong) NSString *charger;

@property (nonatomic , strong) NSString *createdate;

@property (nonatomic , strong) NSString *creater;

@property (nonatomic , strong) NSString *isdelete;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *phone;

@end

@interface ZHLZAreaManagementModel : ZHLZBaseModel

@property (nonatomic , assign) NSInteger currPage;

@property (nonatomic , assign) NSInteger pageSize;

@property (nonatomic , assign) NSInteger totalCount;

@property (nonatomic , assign) NSInteger totalPage;

@property (nonatomic , strong) NSArray <AreaManagementList *> *list;

@end

NS_ASSUME_NONNULL_END
