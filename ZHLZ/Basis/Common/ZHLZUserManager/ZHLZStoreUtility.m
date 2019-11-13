//
//  ZHLZStoreUtility.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZStoreUtility.h"

#define kDOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

@implementation ZHLZStoreUtility

#pragma mark - Root

+ (BOOL)storeToRootDirectory:(id)data key:(NSString *)key {
    NSParameterAssert(data && [data conformsToProtocol:@protocol(NSCoding)]);
    NSParameterAssert([key isNotBlank]);
    
    return [NSKeyedArchiver archiveRootObject:data toFile:[self rootPathByKey:key]];
}

+ (id)fetchByRootDirectory:(NSString *)key {
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[self rootPathByKey:key]];
    return obj;
}

+ (BOOL)deleteRootPatByKey:(NSString *)key {
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[self rootPathByKey:key]]) {
        return [fm removeItemAtPath:[self rootPathByKey:key] error:nil];
    } else {
        return NO;
    }
}

#pragma mark - Private Method

+ (NSString *)rootPathByKey:(NSString *)key {
    return [[self storeRootDirectory] stringByAppendingPathComponent:key];
}

+ (NSString *)storeRootDirectory {
    NSString *path = [NSString stringWithFormat:@"%@/store", kDOCUMENT_DIRECTORY];
    BOOL isDirectory;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (success) {
            [self addSkipBackupAttributeToItemAtPath:path];
        } else {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
            }
        }
    }
    return path;
}

/// 让此目录不被iCloud备份
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString {
    NSURL *URL = [NSURL fileURLWithPath:filePathString];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath:URL.path]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return NO;
    }
    
    return success;
}

@end
