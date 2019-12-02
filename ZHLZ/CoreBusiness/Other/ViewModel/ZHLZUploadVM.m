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

- (void)uploadImageArray:(NSArray<UIImage *> *)uploadImageArray withBlock:(void(^)(NSString *uploadIdStr))block {
    if (uploadImageArray && uploadImageArray.count > 0) {
        NSMutableArray<GRRequest *> *requestArray = @[].mutableCopy;
        NSMutableArray *uploadIdArray = @[].mutableCopy;
        for (int i = 0 ; i< uploadImageArray.count; i++) {
            NSString *uploadId = [self random:16];
            [requestArray addObject:[[ZHLZBaseVM alloc] initWithRequestUrl:DocumentUploadAPIURLConst
                                                           withUploadImage:uploadImageArray[i]
                                                       withUploadImageName:uploadId
                                                       withRequestArgument:@{@"uploadId":uploadId}]];
            [uploadIdArray addObject:uploadId];
        }
        GRBatchRequest *batchRequest = [[GRBatchRequest alloc] initWithRequestArray:requestArray.copy];
        [batchRequest startWithCompletionBlockWithSuccess:^(GRBatchRequest * _Nonnull batchRequest) {
            NSString *imgUrlStr = @"";
            for (NSInteger i = 0; i < batchRequest.requestArray.count; i++) {
                GRRequest *request = requestArray[i];
                if (request && request.responseObject) {
                    GRResponse *response = [GRResponse modelWithJSON:request.responseObject];
                    if (response.data) {
                        [imgUrlStr stringByAppendingString:[NSString stringWithFormat:@"%@,", uploadIdArray[i]]];
                    }
                }
            }
            if ([imgUrlStr isNotBlank]) {
                imgUrlStr = [imgUrlStr substringToIndex:(imgUrlStr.length - 1)];
            }
            block(imgUrlStr);
        } failure:^(GRBatchRequest * _Nonnull batchRequest) {
            
        }];
    }
}

- (NSString *)random:(int)len {
    char ch[len];
    for (int index=0; index<len; index++) {
        int num = arc4random_uniform(75)+48;
        if (num>57 && num<65) { num = num%57+48; }
        else if (num>90 && num<97) { num = num%90+65; }
        ch[index] = num;
    }
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}

@end
