//
//  ZHLZHomeOccupyProblemTableViewCell.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHLZHomeOccupyProblemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeOccupyProblemTableViewCell : UITableViewCell

- (void)homeOccupyProblem:(ZHLZHomeOccupyProblemModel *)homeOccupyProblemModel withIndex:(NSInteger)index;

@property(nonatomic,copy) void (^clickButton)(NSInteger selectIndex);

@end

NS_ASSUME_NONNULL_END
