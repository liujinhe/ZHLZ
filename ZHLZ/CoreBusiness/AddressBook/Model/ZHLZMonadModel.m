//
//  ZHLZMonadModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZMonadModel.h"

@implementation MonadModelList

@end

@implementation ZHLZMonadModel

-(void)setList:(NSArray<MonadModelList *> *)list{
    _list = [NSArray modelArrayWithClass:[MonadModelList class] json:list];
}

@end
