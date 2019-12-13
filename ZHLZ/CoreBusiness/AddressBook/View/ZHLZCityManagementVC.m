//
//  ZHLZCityManagementVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZCityManagementVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZAddressBookVM.h"


@interface ZHLZCityManagementVC ()

@property (weak, nonatomic) IBOutlet ZHLZTextField *nameTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *chargerTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *phoneTextFile;
@property (weak, nonatomic) IBOutlet ZHLZButton *cityManagementButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@end

@implementation ZHLZCityManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConstructionView];
}

- (void)loadConstructionView{

    if (self.setType == 1) {
        self.title = @"添加市管管理单位";
        [self.cityManagementButton setTitle:@"确认添加" forState:UIControlStateNormal];
        self.callButton.hidden = YES;
    } else {
        self.title = @"编辑市管管理单位";
        [self.cityManagementButton setTitle:@"确认修改" forState:UIControlStateNormal];
        self.callButton.hidden = NO;
        
        self.nameTextFile.text = self.cityManagementModel.name;
        self.chargerTextFile.text = self.cityManagementModel.charger;
        self.phoneTextFile.text = self.cityManagementModel.phone;
        
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

- (void)deleteAction {
    [self popActionWithTip:@"您确定要删除？" withBlock:^{
        ZHLZAddressBookVM *addressBookVM = [ZHLZAddressBookVM sharedInstance];
        addressBookVM.isRequestArgumentSlash = YES;
        self.task = [addressBookVM operationWithUrl:CityManagementUnitDeleteAPIURLConst andParms:@"123" withCompletionBlock:^{
            [GRToast makeText:@"删除成功"];
        }];
    }];
}


- (IBAction)cityManagementAction:(ZHLZButton *)sender {
    if (![self.nameTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输单位名称"];
        return;
    }
    if (![self.chargerTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入负责人名称"];
        return;
    }
    if (![self.phoneTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入负责人联系电话"];
        return;
    }
    
    if (self.setType == 1) { //添加
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:CityManagementUnitSaveAPIURLConst andParms:@{@"name":self.nameTextFile.text, @"charger":self.chargerTextFile.text, @"phone":self.phoneTextFile.text} withCompletionBlock:^{
            [GRToast makeText:@"添加成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {//编辑
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:CityManagementUnitUpdateAPIURLConst andParms:@{@"name":self.nameTextFile.text, @"charger":self.chargerTextFile.text, @"phone":self.phoneTextFile.text, @"id":self.cityManagementModel.objectID} withCompletionBlock:^{
            [GRToast makeText:@"修改成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (IBAction)callAction:(UIButton *)sender {
    NSString *phoneString = self.phoneTextFile.text;
    if ([phoneString isNotBlank]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneString]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            });
        }
    }
    else {
        [GRToast makeText:@"暂无联系方式"];
    }
}

@end
