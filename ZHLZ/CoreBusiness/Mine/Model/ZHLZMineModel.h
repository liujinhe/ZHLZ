//
//  ZHLZMineModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/15.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZMineModel : ZHLZBaseModel

@property (nonatomic , strong) NSString *createTime;

@property (nonatomic , assign) NSInteger createUserId;

@property (nonatomic , strong) NSString *email;

@property (nonatomic , strong) NSString *encryptionKey;

@property (nonatomic , strong) NSString *fullname;

@property (nonatomic , strong) NSString *mobile;

@property (nonatomic , strong) NSString *orderArea;

@property (nonatomic , strong) NSArray *orderAreaArr;

@property (nonatomic , assign) NSInteger orderPowerType;

@property (nonatomic , assign) NSInteger orgId;

@property (nonatomic , strong) NSString *orgName;

@property (nonatomic , strong) NSString *orgcode;

@property (nonatomic , strong) NSString *orgname;

@property (nonatomic , assign) NSInteger roleId;

@property (nonatomic , strong) NSArray *roleIdList;

@property (nonatomic , strong) NSString *roleName;

@property (nonatomic , strong) NSString *roleNameNew;

@property (nonatomic , assign) NSInteger status;

@property (nonatomic , assign) NSInteger userId;

@property (nonatomic , strong) NSString *username;

@end

NS_ASSUME_NONNULL_END
