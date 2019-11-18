//
//  ZHLZExamineModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/16.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZExamineModel.h"

@implementation ExamineList

@end
@implementation ZHLZExamineModel
- (void)setList:(NSArray<ExamineList *> *)list{
    _list = [NSArray modelArrayWithClass:[ExamineList class] json:list];
}

@end

