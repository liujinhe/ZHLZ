//
//  ZHLZHomeBulletinCVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/15.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZHLZHomeBulletinModel;

typedef void(^SelectBulletinBlock)(NSString *tip);

@interface ZHLZHomeBulletinCVC : UICollectionViewCell

@property (nonatomic, strong) NSArray<ZHLZHomeBulletinModel *> *homeBulletinArray;

@property (nonatomic, copy) SelectBulletinBlock selectBulletinBlock;

@end

NS_ASSUME_NONNULL_END
