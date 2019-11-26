//
//  ZHLZChosseStepModel.h
//  ZHLZ
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZChosseChildrenModel : ZHLZBaseModel

@property (nonatomic , copy) NSString *name;
@property (nonatomic , assign) NSInteger value;
@property (nonatomic , assign) BOOL isSelect;

@end

@interface ZHLZChosseStepModel : ZHLZBaseModel

@property (nonatomic , copy) NSString *name;
@property (nonatomic , assign) NSInteger value;
@property (nonatomic , copy) NSArray <ZHLZChosseChildrenModel *> *children;
@property (nonatomic , assign) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
