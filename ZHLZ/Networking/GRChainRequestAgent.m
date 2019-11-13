//
//  GRChainRequestAgent.m
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRChainRequestAgent.h"
#import "GRChainRequest.h"

@interface GRChainRequestAgent ()

@property (nonatomic, strong) NSMutableArray<GRChainRequest *> *requestArray;

@end

@implementation GRChainRequestAgent

+ (GRChainRequestAgent *)sharedInstance {
    static id chainRequestAgent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chainRequestAgent = [[self alloc] init];
    });
    return chainRequestAgent;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addChainRequest:(GRChainRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeChainRequest:(GRChainRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
