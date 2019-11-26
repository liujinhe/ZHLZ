//
//  ZHLZHomeOccupyProblemVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeOccupyProblemVC.h"
#import "ZHLZHomeOccupyProblemSearchVC.h"

@interface ZHLZHomeOccupyProblemVC ()

@property (nonatomic, strong) ZHLZHomeOccupyProblemSearchVC *homeOccupyProblemSearchVC;

@end

@implementation ZHLZHomeOccupyProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithImageName:@"icon_search_light" action:@selector(searchAction)];
    
    self.homeOccupyProblemSearchVC = [ZHLZHomeOccupyProblemSearchVC new];
}

#pragma mark - Action

- (void)searchAction {
    [self presentViewController:self.homeOccupyProblemSearchVC animated:NO completion:^{
        [self.homeOccupyProblemSearchVC showFilterView];
    }];
}

@end
