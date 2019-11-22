//
//  ZHLZExamineVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZExamineVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZAddressBookVM.h"

@interface ZHLZExamineVC ()

@property (weak, nonatomic) IBOutlet ZHLZTextField *examineDepartmentTextFile;

@property (weak, nonatomic) IBOutlet UIButton *examineButton;


@end

@implementation ZHLZExamineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadExamineView];
}

- (void)loadExamineView{

    if (self.setType == 1) {
        self.title = @"添加审批单位";
        [self.examineButton setTitle:@"确认添加" forState:UIControlStateNormal];
        
    } else {
        self.title = @"编辑审批单位";
        [self.examineButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
        self.examineDepartmentTextFile.text = self.examineModel.name;
        
        //[self addNavRightButton];
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
    [self popActionWithTip:@"您确定要删除该部门吗？" withBlock:^{
        ZHLZAddressBookVM *addressBookVM = [ZHLZAddressBookVM sharedInstance];
        addressBookVM.isRequestArgumentSlash = YES;
        self.task = [addressBookVM operationWithUrl:ResponsibleUnitDeleteAPIURLConst andParms:@"123" withCompletionBlock:^{
            [GRToast makeText:@"删除成功"];
        }];
    }];
}



- (IBAction)examineAction:(UIButton *)sender {
    if (![self.examineDepartmentTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入正确的部门名称"];
        return;
    }
    
    if (self.setType == 1) { //添加
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ApprovalDepartmentSaveAPIURLConst andParms:@{@"name":self.examineDepartmentTextFile.text} withCompletionBlock:^{
            [GRToast makeText:@"添加成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {//编辑
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ApprovalDepartmentUpdateAPIURLConst andParms:@{@"name":self.examineDepartmentTextFile.text, @"id":self.examineModel.objectID} withCompletionBlock:^{
            [GRToast makeText:@"修改成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }

}


@end
