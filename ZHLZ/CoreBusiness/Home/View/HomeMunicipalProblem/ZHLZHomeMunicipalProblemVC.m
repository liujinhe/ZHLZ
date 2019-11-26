//
//  ZHLZHomeMunicipalProblemVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMunicipalProblemVC.h"
#import "ZHLZHomeMunicipalProblemSearchVC.h"

@interface ZHLZHomeMunicipalProblemVC ()

@property (nonatomic, strong) ZHLZHomeMunicipalProblemSearchVC *homeMunicipalProblemSearchVC;

@end

@implementation ZHLZHomeMunicipalProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithImageName:@"icon_search_light" action:@selector(searchAction)];
    
    self.homeMunicipalProblemSearchVC = [ZHLZHomeMunicipalProblemSearchVC new];
}

#pragma mark - Action

- (void)searchAction {
    [self presentViewController:self.homeMunicipalProblemSearchVC animated:NO completion:^{
        [self.homeMunicipalProblemSearchVC showFilterView];
    }];
}

@end
