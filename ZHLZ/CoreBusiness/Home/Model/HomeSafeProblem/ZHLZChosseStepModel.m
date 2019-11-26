//
//  ZHLZChosseStepModel.m
//  ZHLZ
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZChosseStepModel.h"

@implementation ZHLZChosseChildrenModel

@end

@implementation ZHLZChosseStepModel

- (void)setChildren:(NSArray<ZHLZChosseChildrenModel *> *)children {
    _children = [NSArray modelArrayWithClass:[ZHLZChosseChildrenModel class] json:children];
}

@end

