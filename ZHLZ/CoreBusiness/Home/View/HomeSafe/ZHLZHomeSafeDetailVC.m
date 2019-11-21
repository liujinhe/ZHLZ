//
//  ZHLZHomeSafeDetailVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeDetailVC.h"

@interface ZHLZHomeSafeDetailVC ()

@end

@implementation ZHLZHomeSafeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHomeSafeDetailView];
}

- (void)initHomeSafeDetailView {
    if (self.isAdd) {
        self.title = @"新增安全(三防)台账";
    } else {
        self.title = @"查看安全(三防)台账";
    }
    
    [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
}

- (void)editAction {
    self.title = @"编辑安全(三防)台账";
}

@end
