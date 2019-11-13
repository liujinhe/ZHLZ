//
//  GRRequest.m
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRRequest.h"
#import "GRCacheMetadata.h"
#import "GRNetworkConfig.h"
#import "GRNetworkUtils.h"
#import "GRResponse.h"

NSString * const GRRequestCacheErrorDomain = @"com.rongjinsuo.request.caching";

static dispatch_queue_t rjs_request_cache_writing_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_attr_t attr = DISPATCH_QUEUE_SERIAL;
        attr = dispatch_queue_attr_make_with_qos_class(attr, QOS_CLASS_BACKGROUND, 0);
        queue = dispatch_queue_create("com.rongjinsuo.rjs.request.caching", attr);
    });
    return queue;
}

@interface GRRequest ()

@property (nonatomic, strong) NSData *cacheData;
@property (nonatomic, strong) NSString *cacheString;
@property (nonatomic, strong) id cacheJSON;
@property (nonatomic, strong) NSXMLParser *cacheXML;

@property (nonatomic, strong) GRCacheMetadata *cacheMetadata;
@property (nonatomic, assign) BOOL dataFromCache;

@end

@implementation GRRequest

- (void)start {
    if (self.ignoreCache) {
        [self startWithoutCache];
        return;
    }
    
    if (self.resumableDownloadPath) {
        [self startWithoutCache];
        return;
    }
    
    if (![self loadCacheWithError:nil]) {
        [self startWithoutCache];
        return;
    }
    
    _dataFromCache = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self requestCompletePreprocessor];
        [self requestCompleteFilter];
        GRRequest *strongSelf = self;
        
        // 重组返回值
        GRResponse *response = [[GRResponse alloc] init];
        response.request = strongSelf;
        
        //        [strongSelf.delegate requestFinished:strongSelf];
        [strongSelf.delegate requestFinished:response];
        if (strongSelf.successCompletionBlock) {
            //            strongSelf.successCompletionBlock(strongSelf);
            strongSelf.successCompletionBlock(response);
        }
        [strongSelf clearCompletionBlock];
    });
}

- (void)startWithoutCache {
    [self clearCacheVariables];
    [super start];
}

#pragma mark - Network Request Delegate

- (void)requestCompletePreprocessor {
    [super requestCompletePreprocessor];
    
    if (self.writeCacheAsynchronously) {
        dispatch_async(rjs_request_cache_writing_queue(), ^{
            [self saveResponseDataToCacheFile:[super responseData]];
        });
    } else {
        [self saveResponseDataToCacheFile:[super responseData]];
    }
}

#pragma mark - Subclass Override

- (NSInteger)cacheTimeInSeconds {
    return -1;
}

- (long long)cacheVersion {
    return 0;
}

- (id)cacheSensitiveData {
    return nil;
}

- (BOOL)writeCacheAsynchronously {
    return YES;
}

#pragma mark -

- (BOOL)isDataFromCache {
    return _dataFromCache;
}

- (NSData *)responseData {
    if (_cacheData) {
        return _cacheData;
    }
    return [super responseData];
}

- (NSString *)responseString {
    if (_cacheString) {
        return _cacheString;
    }
    return [super responseString];
}

- (id)responseJSONObject {
    if (_cacheJSON) {
        return _cacheJSON;
    }
    return [super responseJSONObject];
}

- (id)responseObject {
    if (_cacheJSON) {
        return _cacheJSON;
    }
    if (_cacheXML) {
        return _cacheXML;
    }
    if (_cacheData) {
        return _cacheData;
    }
    return [super responseObject];
}

#pragma mark -

- (BOOL)loadCacheWithError:(NSError * _Nullable __autoreleasing *)error {
    if ([self cacheTimeInSeconds] < 0) {
        if (error) {
            *error = [NSError errorWithDomain:GRRequestCacheErrorDomain code:GRRequestValidateErrorCacheTime userInfo:@{ NSLocalizedDescriptionKey:@"Invalid cache time"}];
        }
        return NO;
    }
    
    if (![self loadCacheMetadata]) {
        if (error) {
            *error = [NSError errorWithDomain:GRRequestCacheErrorDomain code:GRRequestValidateErrorMetadata userInfo:@{ NSLocalizedDescriptionKey:@"Invalid metadata. Cache may not exist"}];
        }
        return NO;
    }
    
    if (![self validateCacheWithError:error]) {
        return NO;
    }
    
    if (![self loadCacheData]) {
        if (error) {
            *error = [NSError errorWithDomain:GRRequestCacheErrorDomain code:GRRequestValidateErrorCacheData userInfo:@{ NSLocalizedDescriptionKey:@"Invalid cache data"}];
        }
        return NO;
    }
    
    return YES;
}

- (BOOL)validateCacheWithError:(NSError * _Nullable __autoreleasing *)error {
    NSDate *creationDate = self.cacheMetadata.creationDate;
    NSTimeInterval duration = -[creationDate timeIntervalSinceNow];
    if (duration < 0 || duration > [self cacheTimeInSeconds]) {
        if (error) {
            *error = [NSError errorWithDomain:GRRequestCacheErrorDomain code:GRRequestValidateErrorExpired userInfo:@{ NSLocalizedDescriptionKey:@"Cache expired"}];
        }
        return NO;
    }
    
    long long cacheVersionFileContent = self.cacheMetadata.version;
    if (cacheVersionFileContent != [self cacheVersion]) {
        if (error) {
            *error = [NSError errorWithDomain:GRRequestCacheErrorDomain code:GRRequestValidateErrorVersionMismatch userInfo:@{ NSLocalizedDescriptionKey:@"Cache version mismatch"}];
        }
        return NO;
    }
    
    NSString *sensitiveDataString = self.cacheMetadata.sensitiveDataString;
    NSString *currentSensitiveDataString = ((NSObject *)[self cacheSensitiveData]).description;
    if (sensitiveDataString || currentSensitiveDataString) {
        if (sensitiveDataString.length != currentSensitiveDataString.length || ![sensitiveDataString isEqualToString:currentSensitiveDataString]) {
            if (error) {
                *error = [NSError errorWithDomain:GRRequestCacheErrorDomain code:GRRequestValidateErrorSensitiveDataMismatch userInfo:@{ NSLocalizedDescriptionKey:@"Cache sensitive data mismatch"}];
            }
            return NO;
        }
    }
    
    NSString *appVersionString = self.cacheMetadata.appVersionString;
    NSString *currentAppVersionString = [GRNetworkUtils appVersionString];
    if (appVersionString || currentAppVersionString) {
        if (appVersionString.length != currentAppVersionString.length || ![appVersionString isEqualToString:currentAppVersionString]) {
            if (error) {
                *error = [NSError errorWithDomain:GRRequestCacheErrorDomain code:GRRequestValidateErrorAppVersionMismatch userInfo:@{ NSLocalizedDescriptionKey:@"App version mismatch"}];
            }
            return NO;
        }
    }
    return YES;
}

- (BOOL)loadCacheMetadata {
    NSString *path = [self cacheMetadataFilePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        @try {
            _cacheMetadata = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            return YES;
        } @catch (NSException *exception) {
            NSLog(@"Load cache metadata failed, reason = %@", exception.reason);
            return NO;
        }
    }
    return NO;
}

- (BOOL)loadCacheData {
    NSString *path = [self cacheFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        _cacheData = data;
        _cacheString = [[NSString alloc] initWithData:_cacheData encoding:self.cacheMetadata.stringEncoding];
        switch (self.responseSerializerType) {
            case GRResponseSerializerTypeHTTP:
                // Do nothing.
                return YES;
            case GRResponseSerializerTypeJSON:
                _cacheJSON = [NSJSONSerialization JSONObjectWithData:_cacheData options:(NSJSONReadingOptions)0 error:&error];
                return error == nil;
            case GRResponseSerializerTypeXMLParser:
                _cacheXML = [[NSXMLParser alloc] initWithData:_cacheData];
                return YES;
        }
    }
    return NO;
}

- (void)saveResponseDataToCacheFile:(NSData *)data {
    if ([self cacheTimeInSeconds] > 0 && ![self isDataFromCache]) {
        if (data != nil) {
            @try {
                [data writeToFile:[self cacheFilePath] atomically:YES];
                
                GRCacheMetadata *metadata = [[GRCacheMetadata alloc] init];
                metadata.version = [self cacheVersion];
                metadata.sensitiveDataString = ((NSObject *)[self cacheSensitiveData]).description;
                metadata.stringEncoding = [GRNetworkUtils stringEncodingWithRequest:self];
                metadata.creationDate = [NSDate date];
                metadata.appVersionString = [GRNetworkUtils appVersionString];
                [NSKeyedArchiver archiveRootObject:metadata toFile:[self cacheMetadataFilePath]];
            } @catch (NSException *exception) {
                NSLog(@"Save cache failed, reason = %@", exception.reason);
            }
        }
    }
}

- (void)clearCacheVariables {
    _cacheData = nil;
    _cacheXML = nil;
    _cacheJSON = nil;
    _cacheString = nil;
    _cacheMetadata = nil;
    _dataFromCache = NO;
}

#pragma mark -

- (void)createDirectoryIfNeeded:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

- (void)createBaseDirectoryAtPath:(NSString *)path {
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        NSLog(@"create cache directory failed, error = %@", error);
    } else {
        [GRNetworkUtils addDoNotBackupAttribute:path];
    }
}

- (NSString *)cacheBasePath {
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"LazyRequestCache"];
    
    NSArray<id<GRCacheDirPathFilterProtocol>> *filters = [[GRNetworkConfig sharedInstance] cacheDirPathFilters];
    if (filters.count > 0) {
        for (id<GRCacheDirPathFilterProtocol> f in filters) {
            path = [f filterCacheDirPath:path withRequest:self];
        }
    }
    
    [self createDirectoryIfNeeded:path];
    return path;
}

- (NSString *)cacheFileName {
    NSString *requestUrl = [self requestUrl];
    NSString *baseUrl = [GRNetworkConfig sharedInstance].baseUrl;
    id argument = [self cacheFileNameFilterForRequestArgument:[self requestArgument]];
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@",
                             (long)[self requestMethod], baseUrl, requestUrl, argument];
    NSString *cacheFileName = [GRNetworkUtils md5StringFromString:requestInfo];
    return cacheFileName;
}

- (NSString *)cacheFilePath {
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSString *)cacheMetadataFilePath {
    NSString *cacheMetadataFileName = [NSString stringWithFormat:@"%@.metadata", [self cacheFileName]];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheMetadataFileName];
    return path;
}

@end
