//
//  ZHLZHomeOccupyProblemDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeOccupyProblemDetailVC.h"

@interface ZHLZHomeOccupyProblemDetailVC ()

@end

@implementation ZHLZHomeOccupyProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"占道施工详情";
    
    [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
}

- (void)editAction {
    
}

@end
