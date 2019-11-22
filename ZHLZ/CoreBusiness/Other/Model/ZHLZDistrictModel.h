//
//  ZHLZDistrictModel.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZDistrictModel : ZHLZBaseModel

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *paraCode;
@property (nonatomic, strong) NSString *paraId;
@property (nonatomic, strong) NSString *paraKey;
@property (nonatomic, strong) NSString *paraName;
@property (nonatomic, strong) NSString *sortNo;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *value;

@end

NS_ASSUME_NONNULL_END
