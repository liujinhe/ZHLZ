//
//  ZHLZHomeSafeProblemCell.h
//  ZHLZ
//
//  Created by apple on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHLZHomeSafeProblemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeSafeProblemCell : UITableViewCell

- (void)homeSafeProblemCellWithModel:(ZHLZHomeSafeProblemModel *)homeSafeProblemModel andIndex:(NSInteger)index;

@property(nonatomic,copy) void (^clickButton)(NSInteger selectIndex);

@end

NS_ASSUME_NONNULL_END
