//
//  ZHLZConstructionModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZConstructionModel.h"
@implementation ConstructionList

@end
@implementation ZHLZConstructionModel
- (void)setList:(NSArray<ConstructionList *> *)list{
    _list = [NSArray modelArrayWithClass:[ConstructionList class] json:list];
}

@end

