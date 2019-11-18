//
//  GRBatchRequest.m
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRBatchRequest.h"
#import "GRBatchRequestAgent.h"
#import "GRRequest.h"
#import "GRBatchRequest+RequestAccessory.h"

@interface GRBatchRequest () <GRRequestDelegate>

@property (nonatomic, assign) NSInteger finishedCount;

@end

@implementation GRBatchRequest


- (instancetype)initWithRequestArray:(NSArray<GRRequest *> *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (GRRequest * req in _requestArray) {
            if (![req isKindOfClass:[GRRequest class]]) {
                NSLog(@"Error, request item must be GRRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (_finishedCount > 0) {
        NSLog(@"Error! Batch request has already started.");
        return;
    }
    _failedRequest = nil;
    [[GRBatchRequestAgent sharedInstance] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    for (GRRequest * req in _requestArray) {
        req.delegate = self;
        [req clearCompletionBlock];
        [req start];
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopCallBack];
    [[GRBatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(GRBatchRequest *batchRequest))success
                                    failure:(void (^)(GRBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(GRBatchRequest *batchRequest))success
                              failure:(void (^)(GRBatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (BOOL)isDataFromCache {
    BOOL result = YES;
    for (GRRequest *request in _requestArray) {
        if (!request.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

//- (void)requestFinished:(GRRequest *)request {
- (void)requestFinished:(GRResponse *)request {
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
        [self toggleAccessoriesDidStopCallBack];
        [[GRBatchRequestAgent sharedInstance] removeBatchRequest:self];
    }
}

//- (void)requestFailed:(GRRequest *)request {
- (void)requestFailed:(GRResponse *)request {
    _failedRequest = request;
    [self toggleAccessoriesWillStopCallBack];
    
    for (GRRequest *req in _requestArray) {
        [req stop];
    }
    
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    
    [self clearCompletionBlock];
    
    [self toggleAccessoriesDidStopCallBack];
    [[GRBatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)clearRequest {
    for (GRRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<GRRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}


@end
