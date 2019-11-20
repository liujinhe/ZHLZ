//
//  ZHLZHomeBusinessDocumentVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeBusinessDocumentModel.h"

NS_ASSUME_NONNULL_BEGIN 

@interface ZHLZHomeBusinessDocumentVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeBusinessDocumentDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeBusinessDocumentModel *> *homeBusinessDocumentModel))block;


@end

NS_ASSUME_NONNULL_END
