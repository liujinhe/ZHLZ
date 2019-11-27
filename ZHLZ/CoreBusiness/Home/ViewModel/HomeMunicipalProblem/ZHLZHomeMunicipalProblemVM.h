//
//  ZHLZHomeMunicipalProblemVM.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVM.h"
#import "ZHLZHomeMunicipalProblemSearchModel.h"
#import "ZHLZHomeMunicipalProblemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMunicipalProblemVM : ZHLZBaseVM

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)loadHomeMunicipalProblemDataWithPageNo:(NSInteger)pageNo withModel:(ZHLZHomeMunicipalProblemSearchModel *)model withBlock:(void (^)(NSArray<ZHLZHomeMunicipalProblemModel *> *array))block;

@end

NS_ASSUME_NONNULL_END
