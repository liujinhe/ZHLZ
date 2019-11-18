//
//  ZHLZConstructionVC.h
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZConstructionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZConstructionVC : ZHLZBaseVC

@property(nonatomic , assign) NSInteger setType;//1增加 2编辑
@property (nonatomic , strong) ConstructionList *constructionModel;//建设单位


@end

NS_ASSUME_NONNULL_END
