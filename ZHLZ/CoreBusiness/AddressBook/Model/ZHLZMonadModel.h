//
//  ZHLZMonadModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface MonadModelList : ZHLZBaseModel

@property (nonatomic , strong) NSString *charger;

@property (nonatomic , strong) NSString *createdate;

@property (nonatomic , strong) NSString *creater;

@property (nonatomic , strong) NSString *fullname;

@property (nonatomic , strong) NSString *isdelete;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *orgid;

@property (nonatomic , strong) NSString *phone;

@property (nonatomic , strong) NSString *remark;

@property (nonatomic , strong) NSString *responsibleUnitName;

@end

@interface ZHLZMonadModel : ZHLZBaseModel

@property (nonatomic , assign) NSInteger currPage;

@property (nonatomic , assign) NSInteger pageSize;

@property (nonatomic , assign) NSInteger totalCount;

@property (nonatomic , assign) NSInteger totalPage;

@property (nonatomic , strong) NSArray <MonadModelList *> *list;

@end

NS_ASSUME_NONNULL_END
