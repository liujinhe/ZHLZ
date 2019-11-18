//
//  ZHLZSpecialModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZSpecialModel.h"
@implementation SpecialList

@end

@implementation ZHLZSpecialModel

- (void)setList:(NSArray<SpecialList *> *)list{
    _list = [NSArray modelArrayWithClass:[SpecialList class] json:list];
}

@end
