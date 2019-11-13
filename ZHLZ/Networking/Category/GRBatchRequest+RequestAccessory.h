//
//  GRBatchRequest+RequestAccessory.h
//  GRNetworking
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRBaseRequest.h"
#import "GRBatchRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface GRBatchRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;

- (void)toggleAccessoriesWillStopCallBack;

- (void)toggleAccessoriesDidStopCallBack;

@end

NS_ASSUME_NONNULL_END
