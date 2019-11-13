//
//  GRBatchRequestAgent.m
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRBatchRequestAgent.h"

@interface GRBatchRequestAgent ()

@property (nonatomic, strong) NSMutableArray<GRBatchRequest *> *requestArray;

@end

@implementation GRBatchRequestAgent

+ (GRBatchRequestAgent *)sharedInstance {
    static id batchRequestAgent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        batchRequestAgent = [[self alloc] init];
    });
    return batchRequestAgent;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addBatchRequest:(GRBatchRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(GRBatchRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
