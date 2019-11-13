//
//  ZHLZBaseModel.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseModel.h"

#import <objc/runtime.h>

@implementation ZHLZBaseModel

/// 特殊字段转换
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"objectID": @[@"id"] };
}

/// 返回 self 的所有对象名称
+ (NSArray *)propertyOfSelf {
    unsigned int count;
    
    // 1、获得类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    NSMutableArray *properNames =[NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        // 2、获得成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 3、除去下划线，从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        
        [properNames addObject:key];
    }
    
    return [properNames copy];
}

/// 归档
/// @param enCoder 编码
- (void)encodeWithCoder:(NSCoder *)enCoder {
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        // SEL getSel = NSSelectorFromString(propertyName);
        // 对每一个属性实现归档
        if ([self valueForKey:propertyName]) {
            [enCoder encodeObject:[self valueForKey:propertyName] forKey:propertyName];
        }
    }
}

/// 解档
/// @param aDecoder 解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    __typeof(self) this = [[self class] new];
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    for (NSString *propertyName in properNames) {
        // 创建指向属性的set方法
        id value = [aDecoder decodeObjectForKey:propertyName];
        if (([value isNotBlank])) {
            [this setValue:value forKey:propertyName];
        }
    }
    return this;
}

@end
