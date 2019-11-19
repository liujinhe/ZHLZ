//
//  ZHLZHomeBuildProjectVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeBuildProjectModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeBuildProjectVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeBuildProjectDataWithPageNum:(NSInteger)pageNum WithBlock:(void (^)(NSArray<ZHLZHomeBuildProjectModel *> *homeBuildProjectModelArray))block;

@end

NS_ASSUME_NONNULL_END
