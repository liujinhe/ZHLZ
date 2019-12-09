//
//  ZHLZHomeMapCustomAnnotationView.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

#import "ZHLZHomeMapModel.h"
#import "ZHLZHomeMapProblemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeMapCustomAnnotationView : MAAnnotationView

@property (nonatomic, strong) ZHLZHomeMapModel *homeMapModel;

@property (nonatomic, strong) ZHLZHomeMapProblemModel *homeMapProblemModel;

@property (nonatomic, strong) UIView *calloutView;

@property (nonatomic, copy) void (^selectHomeMapBlock)(NSString *detailId);

@property (nonatomic, copy) void (^selectHomeMapProblemBlock)(NSString *detailId);

@end

NS_ASSUME_NONNULL_END
