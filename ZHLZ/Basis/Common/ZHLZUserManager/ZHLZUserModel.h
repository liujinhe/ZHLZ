//
//  ZHLZUserModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZUserModel : ZHLZBaseModel

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSNumber *createUserId;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *encryptionKey;

@property (nonatomic, copy) NSString *expiresIn;

@property (nonatomic, copy) NSString *fullname;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *orderArea;

@property (nonatomic, copy) NSArray *orderAreaArr;

@property (nonatomic, copy) NSString *orderPowerType;

@property (nonatomic, copy) NSNumber *orgId;

@property (nonatomic, copy) NSString *orgName;

@property (nonatomic, copy) NSString *orgcode;

@property (nonatomic, copy) NSString *orgname;

@property (nonatomic, copy) NSNumber *roleId;

@property (nonatomic, copy) NSArray *roleIdList;

@property (nonatomic, copy) NSString *roleName;

@property (nonatomic, copy) NSString *roleNameNew;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSNumber *userId;

@property (nonatomic, copy) NSString *username;

@end

NS_ASSUME_NONNULL_END
