//
//  GRBaseRequest.m
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRBaseRequest.h"
#import "GRNetworkAgent.h"
#import "GRBaseRequest+RequestAccessory.h"

NSString * const GRRequestValidationErrorDomain = @"com.rongjinsuo.request.validation";

@interface GRBaseRequest ()

@property (nonatomic, strong, readwrite) NSURLSessionTask *requestTask;
@property (nonatomic, strong, readwrite) NSData *responseData;
@property (nonatomic, strong, readwrite) id responseJSONObject;
@property (nonatomic, strong, readwrite) id responseObject;
@property (nonatomic, strong, readwrite) NSString *responseString;
@property (nonatomic, strong, readwrite) NSError *error;

@end

@implementation GRBaseRequest

#pragma mark - Request and Response Information

- (NSInteger)responseStatusCode {
    return self.response.statusCode;
}

- (NSHTTPURLResponse *)response {
    return (NSHTTPURLResponse *)self.requestTask.response;
}

- (NSDictionary *)responseHeaders {
    return self.response.allHeaderFields;
}

- (NSURLRequest *)currentRequest {
    return self.requestTask.currentRequest;
}

- (NSURLRequest *)originalRequest {
    return self.requestTask.originalRequest;
}

- (BOOL)isCancelled {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateCanceling;
}

- (BOOL)isExecuting {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateRunning;
}

#pragma mark - Request Configuration

//- (void)setCompletionBlockWithSuccess:(GRRequestCompletionBlock)success
//                              failure:(GRRequestCompletionBlock)failure {
//    self.successCompletionBlock = success;
//    self.failureCompletionBlock = failure;
//}
- (void)setCompletionBlockWithSuccess:(GRResponseCompletionBlock)success
                              failure:(GRResponseCompletionBlock)failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)addAccessory:(id<GRRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

#pragma mark - Request Action

- (void)start {
    [self toggleAccessoriesWillStartCallBack];
    [[GRNetworkAgent sharedInstance] addRequest:self];
}

- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    self.delegate = nil;
    [[GRNetworkAgent sharedInstance] cancelRequest:self];
    [self toggleAccessoriesDidStopCallBack];
}

- (void)startWithCompletionBlockWithSuccess:(GRResponseCompletionBlock)success
                                    failure:(GRResponseCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

#pragma mark - Subclass Override

- (void)requestCompletePreprocessor {
}

- (void)requestCompleteFilter {
}

- (void)requestFailedPreprocessor {
}

- (void)requestFailedFilter {
}

- (NSString *)baseUrl {
    return @"";
}

- (NSString *)cdnUrl {
    return @"";
}

- (NSString *)requestUrl {
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 60;
}

- (id)requestArgument {
    return nil;
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument {
    return argument;
}

- (GRRequestMethod)requestMethod {
    return GRRequestMethodPOST;
}

- (GRRequestSerializerType)requestSerializerType {
    return GRRequestSerializerTypeJSON;
}

- (GRResponseSerializerType)responseSerializerType {
    return GRResponseSerializerTypeJSON;
}

- (NSArray *)requestAuthorizationHeaderFieldArray {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return nil;
}

- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}

- (BOOL)useCDN {
    return NO;
}

- (BOOL)allowsCellularAccess {
    return YES;
}

- (id)jsonValidator {
    return nil;
}

- (BOOL)statusCodeValidator {
    NSInteger statusCode = [self responseStatusCode];
    return (statusCode >= 200 && statusCode <= 299);
}

#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>{ URL: %@ } { method: %@ } { arguments: %@ }",
            NSStringFromClass([self class]),
            self,
            self.currentRequest.URL,
            self.currentRequest.HTTPMethod,
            self.requestArgument];
}

@end
