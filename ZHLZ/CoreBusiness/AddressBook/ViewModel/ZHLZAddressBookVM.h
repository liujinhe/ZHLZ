//
//  ZHLZAddressBookVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZAddressBookVM : ZHLZBaseVM

+ (instancetype)sharedInstance;
//查询列表
- (NSURLSessionTask *)loadListWithType:(NSInteger)type withPageNum:(NSInteger)page CallBack:(void (^)(NSDictionary *parms))block;


//数据操作
- (NSURLSessionTask *)operationWithUrl:(NSString *)url andParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;


@end

NS_ASSUME_NONNULL_END
