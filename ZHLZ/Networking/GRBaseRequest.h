//
//  GRBaseRequest.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRResponse.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const GRRequestValidationErrorDomain;

typedef NS_ENUM(NSInteger, GRRequestValidateError) {
    GRRequestValidateErrorExpired = -1,
    GRRequestValidateErrorVersionMismatch = -2,
    GRRequestValidateErrorSensitiveDataMismatch = -3,
    GRRequestValidateErrorAppVersionMismatch = -4,
    GRRequestValidateErrorCacheTime = -5,
    GRRequestValidateErrorMetadata = -6,
    GRRequestValidateErrorCacheData = -7,
    GRRequestValidateErrorInStatusCode = -8,
    GRRequestValidateErrorInJSONFormat = -9
};

/// GRRequestMethod
typedef NS_ENUM(NSInteger, GRRequestMethod) {
    GRRequestMethodGET = 0,
    GRRequestMethodPOST = 1,
    GRRequestMethodHEAD = 2,
    GRRequestMethodPUT = 3,
    GRRequestMethodDELETE = 4,
    GRRequestMethodPATCH = 5
};

/// GRRequestSerializerType
typedef NS_ENUM(NSInteger, GRRequestSerializerType) {
    GRRequestSerializerTypeHTTP = 0,
    GRRequestSerializerTypeJSON = 1
};

/// GRResponseSerializerType
typedef NS_ENUM(NSInteger, GRResponseSerializerType) {
    GRResponseSerializerTypeHTTP = 0,
    GRResponseSerializerTypeJSON = 1,
    GRResponseSerializerTypeXMLParser = 2,
};

/// GRRequestPriority
typedef NS_ENUM(NSInteger, GRRequestPriority) {
    GRRequestPriorityLow = -4L,
    GRRequestPriorityDefault = 0,
    GRRequestPriorityHigh = 4,
};

/// AFMultipartFormData
@protocol AFMultipartFormData;

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);
typedef void (^AFURLSessionTaskProgressBlock)(NSProgress *);

//@class GRBaseRequest;
//
//typedef void (^GRRequestCompletionBlock)(__kindof GRBaseRequest *request);

//@class GRResponse;

typedef void (^GRResponseCompletionBlock)(__kindof GRResponse *response);

/// GRRequestDelegate
@protocol GRRequestDelegate <NSObject>

@optional

//- (void)requestFinished:(__kindof GRBaseRequest *)request;
//
//- (void)requestFailed:(__kindof GRBaseRequest *)request;

- (void)requestFinished:(__kindof GRResponse *)response;

- (void)requestFailed:(__kindof GRResponse *)response;

@end

/// GRRequestAccessory
@protocol GRRequestAccessory <NSObject>

@optional

- (void)requestWillStart:(id)request;

- (void)requestWillStop:(id)request;

- (void)requestDidStop:(id)request;

@end

/// GRBaseRequest
@interface GRBaseRequest : NSObject

#pragma mark - Request and Response Information

@property (nonatomic, readonly) NSInteger responseStatusCode;

@property (nonatomic, strong, readonly) NSURLSessionTask *requestTask;

@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;

@property (nonatomic, strong, readonly) NSURLRequest *originalRequest;

@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;

@property (nonatomic, strong, readonly, nullable) NSDictionary *responseHeaders;

@property (nonatomic, strong, readonly, nullable) NSData *responseData;

@property (nonatomic, strong, readonly, nullable) NSString *responseString;

@property (nonatomic, strong, readonly, nullable) id responseObject;

@property (nonatomic, strong, readonly, nullable) id responseJSONObject;

@property (nonatomic, strong, readonly, nullable) NSError *error;

@property (nonatomic, readonly, getter = isCancelled) BOOL cancelled;

@property (nonatomic, readonly, getter = isExecuting) BOOL executing;

#pragma mark - Request Configuration

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong, nullable) NSDictionary *userInfo;

@property (nonatomic, weak, nullable) id<GRRequestDelegate> delegate;

//@property (nonatomic, copy, nullable) GRRequestCompletionBlock successCompletionBlock;
@property (nonatomic, copy, nullable) GRResponseCompletionBlock successCompletionBlock;

//@property (nonatomic, copy, nullable) GRRequestCompletionBlock failureCompletionBlock;
@property (nonatomic, copy, nullable) GRResponseCompletionBlock failureCompletionBlock;

@property (nonatomic, strong, nullable) NSMutableArray<id<GRRequestAccessory>> *requestAccessories;

@property (nonatomic, copy, nullable) AFConstructingBlock constructingBodyBlock;

@property (nonatomic, strong, nullable) NSString *resumableDownloadPath;

@property (nonatomic, copy, nullable) AFURLSessionTaskProgressBlock resumableDownloadProgressBlock;

@property (nonatomic, assign) GRRequestPriority requestPriority;

//- (void)setCompletionBlockWithSuccess:(nullable GRRequestCompletionBlock)success
//                              failure:(nullable GRRequestCompletionBlock)failure;
- (void)setCompletionBlockWithSuccess:(nullable GRResponseCompletionBlock)success
                              failure:(nullable GRResponseCompletionBlock)failure;

- (void)clearCompletionBlock;

- (void)addAccessory:(id<GRRequestAccessory>)accessory;

#pragma mark - Request Action

- (void)start;

- (void)stop;

- (void)startWithCompletionBlockWithSuccess:(nullable GRResponseCompletionBlock)success
                                    failure:(nullable GRResponseCompletionBlock)failure;

#pragma mark - Subclass Override

- (void)requestCompletePreprocessor;

- (void)requestCompleteFilter;

- (void)requestFailedPreprocessor;

- (void)requestFailedFilter;

- (NSString *)baseUrl;

- (NSString *)cdnUrl;

- (NSString *)requestUrl;

- (NSTimeInterval)requestTimeoutInterval;

- (nullable id)requestArgument;

- (id)cacheFileNameFilterForRequestArgument:(id)argument;

- (GRRequestMethod)requestMethod;

- (GRRequestSerializerType)requestSerializerType;

- (GRResponseSerializerType)responseSerializerType;

- (nullable NSArray<NSString *> *)requestAuthorizationHeaderFieldArray;

- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary;

- (nullable NSURLRequest *)buildCustomUrlRequest;

- (BOOL)useCDN;

- (BOOL)allowsCellularAccess;

- (nullable id)jsonValidator;

- (BOOL)statusCodeValidator;

@end

NS_ASSUME_NONNULL_END
