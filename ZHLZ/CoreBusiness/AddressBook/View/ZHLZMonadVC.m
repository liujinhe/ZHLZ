//
//  ZHLZMonadVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZMonadVC.h"
#import <YYKit/UIControl+YYAdd.h>


@interface ZHLZMonadVC ()




@property (weak, nonatomic) IBOutlet ZHLZButton *sureButton;

@end

@implementation ZHLZMonadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMonadView];
}


- (void)loadMonadView{
    
    
    
    if (self.setType == 1) {
        
        self.title = @"添加责任单位";
        [self.sureButton setTitle:@"确认添加" forState:UIControlStateNormal];
    
    } else {
        
        self.title = @"编辑责任单位";
        [self.sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
        [self addNavRightButton];
        
    }
}

- (void)addNavRightButton{
    UIButton *areaManagementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [areaManagementButton setTitle:@"删除" forState:UIControlStateNormal];
    [areaManagementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [areaManagementButton sizeToFit];
    @weakify(self);
    [areaManagementButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id _Nonnull sender) {
        @strongify(self);
        [self deleteAction];
    }];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:areaManagementButton]];
}

- (void)deleteAction{
    @weakify(self)
    [self popActionWithTip:@"您确定要删除？" withBlock:^{
        @strongify(self)
        
        [GRToast makeText:@"删除成功"];
    }];
}

- (IBAction)sureAction:(ZHLZButton *)sender {
    
    if (self.setType == 1) {
        
    } else {
        
    }
}



@end
