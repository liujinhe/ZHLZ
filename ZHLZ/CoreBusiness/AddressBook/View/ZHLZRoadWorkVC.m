//
//  ZHLZRoadWorkVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZRoadWorkVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZAddressBookVM.h"

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


- (void)loadRoadWorkView{

    if (self.editType == 1) {
        
        self.title = @"添加施工单位";
        [self.roadWorkButton setTitle:@"确认添加" forState:UIControlStateNormal];
        
    } else {
        
        self.title = @"编辑施工单位";
        [self.roadWorkButton setTitle:@"确认修改" forState:UIControlStateNormal];
        
        //[self addNavRightButton];
        
        self.unitNameTextFile.text = self.roadWorkModel.name;
        self.principalNameTextFile.text = self.roadWorkModel.charger;
        self.principalPhonetextFile.text = self.roadWorkModel.phone;
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
        ZHLZAddressBookVM *addressBookVM = [ZHLZAddressBookVM sharedInstance];
        addressBookVM.isRequestArgumentSlash = YES;
        self.task = [addressBookVM operationWithUrl:ResponsibleUnitDeleteAPIURLConst andParms:@"12" withCompletionBlock:^{
            [GRToast makeText:@"删除成功"];
        }];
    }];
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
    
    if (self.editType == 1) { //添加
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ConstructionUnitSaveAPIURLConst andParms:@{@"name":self.unitNameTextFile.text,@"charger":self.principalNameTextFile.text, @"phone":self.principalPhonetextFile.text} withCompletionBlock:^{
            [GRToast makeText:@"添加成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {//编辑
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ConstructionUnitUpdateAPIURLConst andParms:@{@"name":self.unitNameTextFile.text, @"charger":self.principalNameTextFile.text, @"phone":self.principalPhonetextFile.text, @"id":self.roadWorkModel.objectID} withCompletionBlock:^{
            [GRToast makeText:@"修改成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}





@end
