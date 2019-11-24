//
//  ZHLZHomeBannerCVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/24.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZHLZHomeBannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeBannerCVC : UICollectionViewCell

@property (nonatomic, strong) NSArray<ZHLZHomeBannerModel *> *homeBannerArray;

@end

NS_ASSUME_NONNULL_END
