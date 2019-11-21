//
//  ZHLZHomeBuildProjectDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectDetailVC.h"
#import "ZHLZProjectDetailTableViewCell.h"

@interface ZHLZHomeBuildProjectDetailVC ()


@end

@implementation ZHLZHomeBuildProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildProjectDetailView];
}

- (void)editAction {
    
}

- (void)buildProjectDetailView{
    
    if (self.isEdit) {
        
        self.title = @"编辑在建项目";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
    } else {
        self.title = @"新增在建项目";
    }
}


@end
