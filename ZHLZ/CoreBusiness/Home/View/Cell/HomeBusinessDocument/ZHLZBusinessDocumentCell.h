//
//  ZHLZBusinessDocumentCell.h
//  ZHLZ
//
//  Created by apple on 2019/11/20.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHLZHomeBusinessDocumentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZBusinessDocumentCell : UITableViewCell

@property (nonatomic, strong) ZHLZHomeBusinessDocumentModel *homeBusinessDocumentModel;

/// 是否已下载
@property (nonatomic, assign) BOOL isHasDownLoad;

@end

NS_ASSUME_NONNULL_END
