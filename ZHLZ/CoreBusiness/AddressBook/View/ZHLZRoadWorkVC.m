//
//  ZHLZRoadWorkVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZRoadWorkVC.h"
#import <YYKit/UIControl+YYAdd.h>


@interface ZHLZRoadWorkVC ()

@property (weak, nonatomic) IBOutlet ZHLZTextField *unitNameTextFile;

@property (weak, nonatomic) IBOutlet ZHLZTextField *principalNameTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *principalPhonetextFile;


@property (weak, nonatomic) IBOutlet ZHLZButton *roadWorkButton;


@end

@implementation ZHLZRoadWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRoadWorkView];
}

- (IBAction)roadWorkButtonAction:(ZHLZButton *)sender {
    if (![self.unitNameTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入施工单位"];
        return;
    }
    if (![self.principalNameTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入施工单位联系人"];
        return;
    }
    if (![self.principalPhonetextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入施工单位联系人手机"];
        return;
    }
    
    if (self.editType == 1) {
        
    }
    
    else {
        
        
    }
    
}


- (void)loadRoadWorkView{

    if (self.editType == 1) {
        
        self.title = @"添加施工单位";
        [self.roadWorkButton setTitle:@"确认添加" forState:UIControlStateNormal];
        
    } else {
        
        self.title = @"编辑施工单位";
        [self.roadWorkButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
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

- (void)deleteAction {
    
}




@end
