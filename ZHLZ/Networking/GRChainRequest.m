//
//  GRChainRequest.m
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRChainRequest.h"
#import "GRChainRequestAgent.h"
#import "GRBaseRequest.h"
#import "GRChainRequest+RequestAccessory.h"

@interface GRChainRequest () <GRRequestDelegate>

@property (nonatomic, strong) NSMutableArray<GRBaseRequest *> *requestArray;
@property (nonatomic, strong) NSMutableArray<GRChainCallback> *requestCallbackArray;
@property (nonatomic, assign) NSUInteger nextRequestIndex;
@property (nonatomic, strong) GRChainCallback emptyCallback;

@end

@implementation GRChainRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _nextRequestIndex = 0;
        _requestArray = [NSMutableArray array];
        _requestCallbackArray = [NSMutableArray array];
        _emptyCallback = ^(GRChainRequest *chainRequest, GRBaseRequest *baseRequest) {
            // do nothing
        };
    }
    return self;
}

- (void)start {
    if (_nextRequestIndex > 0) {
        NSLog(@"Error! Chain request has already started.");
        return;
    }
    
    if ([_requestArray count] > 0) {
        [self toggleAccessoriesWillStartCallBack];
        [self startNextRequest];
        [[GRChainRequestAgent sharedInstance] addChainRequest:self];
    } else {
        NSLog(@"Error! Chain request array is empty.");
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    [self clearRequest];
    [[GRChainRequestAgent sharedInstance] removeChainRequest:self];
    [self toggleAccessoriesDidStopCallBack];
}

- (void)addRequest:(GRBaseRequest *)request callback:(GRChainCallback)callback {
    [_requestArray addObject:request];
    if (callback != nil) {
        [_requestCallbackArray addObject:callback];
    } else {
        [_requestCallbackArray addObject:_emptyCallback];
    }
}

- (NSArray<GRBaseRequest *> *)requestArray {
    return _requestArray;
}

- (BOOL)startNextRequest {
    if (_nextRequestIndex < [_requestArray count]) {
        GRBaseRequest *request = _requestArray[_nextRequestIndex];
        _nextRequestIndex++;
        request.delegate = self;
        [request clearCompletionBlock];
        [request start];
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Network Request Delegate

- (void)requestFinished:(GRBaseRequest *)request {
    NSUInteger currentRequestIndex = _nextRequestIndex - 1;
    GRChainCallback callback = _requestCallbackArray[currentRequestIndex];
    callback(self, request);
    if (![self startNextRequest]) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(chainRequestFinished:)]) {
            [_delegate chainRequestFinished:self];
            [[GRChainRequestAgent sharedInstance] removeChainRequest:self];
        }
        [self toggleAccessoriesDidStopCallBack];
    }
}

- (void)requestFailed:(GRBaseRequest *)request {
    [self toggleAccessoriesWillStopCallBack];
    if ([_delegate respondsToSelector:@selector(chainRequestFailed:failedBaseRequest:)]) {
        [_delegate chainRequestFailed:self failedBaseRequest:request];
        [[GRChainRequestAgent sharedInstance] removeChainRequest:self];
    }
    [self toggleAccessoriesDidStopCallBack];
}

- (void)clearRequest {
    NSUInteger currentRequestIndex = _nextRequestIndex - 1;
    if (currentRequestIndex < [_requestArray count]) {
        GRBaseRequest *request = _requestArray[currentRequestIndex];
        [request stop];
    }
    [_requestArray removeAllObjects];
    [_requestCallbackArray removeAllObjects];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<GRRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}


@end
