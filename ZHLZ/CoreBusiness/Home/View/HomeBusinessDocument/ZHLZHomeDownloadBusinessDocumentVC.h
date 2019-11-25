//
//  ZHLZHomeDownloadBusinessDocumentVC.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/25.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"
#import "ZHLZHomeBusinessDocumentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZHomeDownloadBusinessDocumentVC : ZHLZBaseVC

@property (nonatomic, strong) ZHLZHomeBusinessDocumentModel *homeBusinessDocumentModel;

@property (nonatomic, strong) NSString *fullPath;

@end

NS_ASSUME_NONNULL_END
