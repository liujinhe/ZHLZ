//
//  ZHLZSpecialVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZSpecialVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZAddressBookVM.h"

@interface ZHLZSpecialVC ()

@property (weak, nonatomic) IBOutlet ZHLZTextField *nameTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *chargerTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *phoneTextFile;
@property (weak, nonatomic) IBOutlet ZHLZButton *specialButton;

@end

@implementation ZHLZSpecialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSpecialView];
}


- (void)loadSpecialView{

    if (self.setType == 1) {
        
        self.title = @"添加特殊业主单位";
        [self.specialButton setTitle:@"确认添加" forState:UIControlStateNormal];
        
    } else {
        
        self.title = @"编辑特殊业主单位";
        [self.specialButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
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
    [self popActionWithTip:@"您确定要删除？" withBlock:^{
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:[NSString stringWithFormat:@"%@/%@",SpecialOwnerUnitDeleteAPIURLConst,@"12"] andParms:@{} withCompletionBlock:^{
            [GRToast makeText:@"删除成功"];
        }];
    }];
}




- (IBAction)apecialAction:(ZHLZButton *)sender {
    if (![self.nameTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入特殊业主单位"];
        return;
    }
    if (![self.chargerTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入特殊业主单位联系人"];
        return;
    }
    if (![self.phoneTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入特殊业主单位联系人手机"];
        return;
    }
    
    if (self.setType == 1) { //添加
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:SpecialOwnerUnitSaveAPIURLConst andParms:@{@"name":self.nameTextFile.text,@"charger":self.chargerTextFile.text,@"phone":self.phoneTextFile.text} withCompletionBlock:^{
            [GRToast makeText:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {//编辑
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:SpecialOwnerUnitUpdateAPIURLConst andParms:@{@"name":self.nameTextFile.text,@"charger":self.chargerTextFile.text,@"phone":self.phoneTextFile.text} withCompletionBlock:^{
            [GRToast makeText:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}


@end
