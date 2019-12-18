//
//  ZHLZTransactedPersonModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/12/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZTransactedPersonModel : ZHLZBaseModel

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *createUserId;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *encryptionKey;
@property (nonatomic, strong) NSString *expiresIn;
// 经办人
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *orderArea;
@property (nonatomic, strong) NSString *orderAreaArr;
@property (nonatomic, strong) NSString *orderPowerType;
@property (nonatomic, strong) NSString *orgId;
@property (nonatomic, strong) NSString *orgName;
@property (nonatomic, strong) NSString *orgcode;
@property (nonatomic, strong) NSString *orgname;
@property (nonatomic, strong) NSString *roleId;
@property (nonatomic, strong) NSString *roleIdList;
@property (nonatomic, strong) NSString *roleName;
@property (nonatomic, strong) NSString *roleNameNew;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;

@end

NS_ASSUME_NONNULL_END
