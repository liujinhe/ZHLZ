//
//  ZHLZConstructionVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZConstructionVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZAddressBookVM.h"


@interface ZHLZConstructionVC ()

@property (weak, nonatomic) IBOutlet ZHLZTextField *nameTextFIle;
@property (weak, nonatomic) IBOutlet ZHLZTextField *chargerTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *phoneTextFIle;

@property (weak, nonatomic) IBOutlet ZHLZButton *constructionButton;


@end

@implementation ZHLZConstructionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConstructionView];
    
}
- (void)loadConstructionView{

    if (self.setType == 1) {
        self.title = @"添加建设单位";
        [self.constructionButton setTitle:@"确认添加" forState:UIControlStateNormal];
        
    } else {
        self.title = @"编辑建设单位";
        [self.constructionButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
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
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:[NSString stringWithFormat:@"%@/%@",ConstructionUnitDeleteAPIURLConst,@"123"] andParms:@{} withCompletionBlock:^{
            [GRToast makeText:@"删除成功"];
        }];
    }];
}

- (IBAction)constructionAction:(ZHLZButton *)sender {
    if (![self.nameTextFIle.text isNotBlank]) {
        [GRToast makeText:@"请输入施工单位"];
        return;
    }
    if (![self.chargerTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入施工单位联系人"];
        return;
    }
    if (![self.phoneTextFIle.text isNotBlank]) {
        [GRToast makeText:@"请输入施工单位联系人手机"];
        return;
    }
    
    if (self.setType == 1) { //添加
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ConstructionUnitSaveAPIURLConst andParms:@{@"name":self.nameTextFIle.text,@"charger":self.chargerTextFile.text,@"phone":self.phoneTextFIle.text} withCompletionBlock:^{
            [GRToast makeText:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {//编辑
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ConstructionUnitUpdateAPIURLConst andParms:@{@"name":self.nameTextFIle.text,@"charger":self.chargerTextFile.text,@"phone":self.phoneTextFIle.text} withCompletionBlock:^{
            [GRToast makeText:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}


@end
