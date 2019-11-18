//
//  ZHLZSpecialModel.h
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
             "charger": "琳琳",
             "createdate": null,
             "creater": null,
             "id": "1",
             "isdelete": null,
             "name": "广州院",
             "phone": "13691770001"
         }],
         "pageSize": 10,
         "totalCount": 1,
         "totalPage": 1
     }
 }
 */
@interface SpecialList : ZHLZBaseModel

@property (nonatomic , strong) NSString *charger;

@property (nonatomic , strong) NSString *createdate;

@property (nonatomic , strong) NSString *creater;

@property (nonatomic , strong) NSString *isdelete;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *phone;

@end

@interface ZHLZSpecialModel : ZHLZBaseModel

@property (nonatomic , assign) NSInteger currPage;

@property (nonatomic , assign) NSInteger pageSize;

@property (nonatomic , assign) NSInteger totalCount;

@property (nonatomic , assign) NSInteger totalPage;

@property (nonatomic , strong) NSArray <SpecialList *> *list;

@end

NS_ASSUME_NONNULL_END
