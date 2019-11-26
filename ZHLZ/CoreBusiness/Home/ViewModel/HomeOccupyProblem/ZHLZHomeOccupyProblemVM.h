//
//  ZHLZHomeOccupyProblemVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeOccupyProblemSearchModel.h"
#import "ZHLZHomeOccupyProblemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeOccupyProblemVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeOccupyProblemDataWithPageNo:(NSInteger)pageNo withModel:(ZHLZHomeOccupyProblemSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeOccupyProblemModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
