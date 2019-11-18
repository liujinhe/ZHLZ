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
- (NSURLSessionTask *)loadListWithType:(NSInteger)type CallBack:(void (^)(NSDictionary *parms))block;


//数据操作
- (NSURLSessionTask *)operationWithUrl:(NSString *)url andParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;

#pragma make 责任单位
//增加保存
- (NSURLSessionTask *)saveResponsibleunitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;
//修改
- (NSURLSessionTask *)editResponsibleunitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;
//删除
- (NSURLSessionTask *)deleteResponsibleunitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;


#pragma mark 施工单位
//增加保存
- (NSURLSessionTask *)saveConstructionUnitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;
//修改
- (NSURLSessionTask *)editConstructionUnitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;
//删除
- (NSURLSessionTask *)deleteConstructionUnitWithParms:(NSDictionary *)parms withCompletionBlock:(dispatch_block_t)block;



@end

NS_ASSUME_NONNULL_END
