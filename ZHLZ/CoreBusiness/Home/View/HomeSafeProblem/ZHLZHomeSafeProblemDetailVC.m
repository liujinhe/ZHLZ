//
//  ZHLZHomeSafeProblemDetailVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemDetailVC.h"

@interface ZHLZHomeSafeProblemDetailVC ()

@end

@implementation ZHLZHomeSafeProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSafeProblemDetailView];
}

- (void)initSafeProblemDetailView {
    if (self.isAdd) {
        self.title = @"新增安全(三防)问题";
    } else {
        self.title = @"查看安全(三防)问题";
    }
    
    [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
}

- (void)editAction {
    self.title = @"编辑安全(三防)问题";
}


@end
