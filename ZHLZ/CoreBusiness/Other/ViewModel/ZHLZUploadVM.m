//
//  ZHLZUploadVM.m
//  ZHLZ
//
//  Created by apple on 2019/12/2.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZUploadVM.h"

@implementation ZHLZUploadVM

+ (instancetype)sharedInstance {
    static id uploadVM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploadVM = [[self alloc] init];
    });
    return uploadVM;
}

- (void)uploadImageArray:(NSArray<NSData *> *)uploadImageArray withBlock:(dispatch_block_t)block {
    
    if (uploadImageArray && uploadImageArray.count > 0) {
        
//        NSMutableArray<GRRequest *> *requestArray = @[].mutableCopy;
//        for (int i = 0 ; i< uploadImageArray.count; i++) {
//            [requestArray addObject:[[ZHLZBaseVM alloc] initWithRequestUrl:DocumentUploadAPIURLConst withRequestArgument:[uploadImageArray[i] modelToJSONString]]];
//        }
        GRBatchRequest *batchRequest = [[GRBatchRequest alloc] initWithRequestArray:uploadImageArray.copy];
        [batchRequest startWithCompletionBlockWithSuccess:^(GRBatchRequest * _Nonnull batchRequest) {
            NSString *imgsUrl = @"";
            NSString *imgsId = @"";
            for (GRRequest *request in batchRequest.requestArray) {
                if (request && request.responseObject) {
                    GRResponse *response = [GRResponse modelWithJSON:request.responseObject];
                    NSString *imgUrl = [response.data objectForKey:@"imgUrl"];
                    NSUInteger imgId = [[response.data objectForKey:@"id"] integerValue];
                    if (imgUrl && [imgUrl isNotBlank]) {
                        imgsUrl = [imgsUrl stringByAppendingFormat:@"%@,", imgUrl];
                        imgsId = [imgsId stringByAppendingFormat:@"%lu,", (unsigned long)imgId];
                    }
                }
            }
//            feedbackModel.imgsUrl = [imgsUrl substringToIndex:imgsUrl.length - 1];
//            feedbackModel.imgsId = [imgsId substringToIndex:imgsId.length - 1];
            
        } failure:^(GRBatchRequest * _Nonnull batchRequest) {
            
        }];
    }
}

@end
