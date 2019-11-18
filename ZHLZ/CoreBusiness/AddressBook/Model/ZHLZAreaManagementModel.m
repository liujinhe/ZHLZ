//
//  ZHLZAreaManagementModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZAreaManagementModel.h"

@implementation AreaManagementList

@end

@implementation ZHLZAreaManagementModel
- (void)setList:(NSArray<AreaManagementList *> *)list{
    _list = [NSArray modelArrayWithClass:[AreaManagementList class] json:list];
}
@end

