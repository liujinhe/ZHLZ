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

- (void)editAction {
    ZHLZHomeSafeProblemDetailVC *safeProblemDetailVC = [ZHLZHomeSafeProblemDetailVC new];
    safeProblemDetailVC.detailType = 3;
    [self.navigationController pushViewController:safeProblemDetailVC animated:YES];
}

- (void)initSafeProblemDetailView {
    if (self.detailType == 1) {
        self.title = @"新增安全(三防)问题";
    } else if (self.detailType == 2){
        self.title = @"查看安全(三防)问题";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        [self lookSetView];
        
    } else {
        self.title = @"编辑安全(三防)问题";
    }
}

- (void)lookSetView {
    
}


@end
