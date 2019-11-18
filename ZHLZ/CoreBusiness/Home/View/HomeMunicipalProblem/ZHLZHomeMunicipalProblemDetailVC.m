//
//  ZHLZHomeMunicipalProblemDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMunicipalProblemDetailVC.h"

@interface ZHLZHomeMunicipalProblemDetailVC ()

@end

@implementation ZHLZHomeMunicipalProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"市政设施详情";
    
    [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
}

- (void)editAction {
    
}

@end
