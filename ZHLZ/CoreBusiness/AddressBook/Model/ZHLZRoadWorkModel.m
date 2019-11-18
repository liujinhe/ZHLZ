//
//  ZHLZRoadWorkModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZRoadWorkModel.h"
@implementation RoadWorkList

@end

@implementation ZHLZRoadWorkModel

- (void)setList:(NSArray<RoadWorkList *> *)list{
    _list = [NSArray modelArrayWithClass:[RoadWorkList class] json:list];
}

@end

