//
//  ZHLZCityManagementModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZCityManagementModel.h"

@implementation CityManagementList

@end

@implementation ZHLZCityManagementModel
- (void)setList:(NSArray<CityManagementList *> *)list{
    _list = [NSArray modelArrayWithClass:[CityManagementList class] json:list];
}
@end
