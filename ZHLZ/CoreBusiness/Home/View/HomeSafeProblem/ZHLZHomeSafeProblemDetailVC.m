//
//  ZHLZHomeSafeProblemDetailVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemDetailVC.h"
#import "ZHLZHomeSafeProblemVM.h"
#import "ZHLZAddCouncilorVC.h"

@interface ZHLZHomeSafeProblemDetailVC ()

@property (nonatomic , strong) ZHLZHomeSafeProblemModel *homeSafeProblemModel;

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

- (void)getProblemDetailData{
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeSafeProblemModel * _Nonnull homeSafeProblem) {
        self.homeSafeProblemModel = homeSafeProblem;
        
    }];
}

- (void)initSafeProblemDetailView {
    if (self.detailType == 1) {
        self.title = @"新增安全(三防)问题";
    } else if (self.detailType == 2){
        self.title = @"查看安全(三防)问题";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        [self getProblemDetailData];
        
        [self lookSetView];
        
    } else {
        
        self.title = @"编辑安全(三防)问题";
        
        [self getProblemDetailData];
    }
}

- (void)lookSetView {
    
}


- (IBAction)setSupervisorAction:(UIButton *)sender {
    ZHLZAddCouncilorVC *addCouncilorVC = [ZHLZAddCouncilorVC new];
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}


@end
