//
//  ZHLZMonadVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZMonadVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZAddressBookVM.h"


@interface ZHLZMonadVC ()
@property (weak, nonatomic) IBOutlet ZHLZTextField *workNnameTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *principalNnameTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *principalPhoneTextFile;
@property (weak, nonatomic) IBOutlet ZHLZTextField *remarkTextFile;

@property (weak, nonatomic) IBOutlet ZHLZButton *sureButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

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
        self.callButton.hidden = YES;
        
    } else {
        self.title = @"编辑责任单位";
        [self.sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
        self.callButton.hidden = NO;
        //[self addNavRightButton];
        
        self.workNnameTextFile.text = self.monadModel.name;
        
        self.principalNnameTextFile.text = self.monadModel.charger;
        
        self.principalPhoneTextFile.text = self.monadModel.phone;
        
        self.remarkTextFile.text = self.monadModel.remark;
        
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
    [self popActionWithTip:@"您确定要删除？" withBlock:^{
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ResponsibleUnitDeleteAPIURLConst andParms:@{@"id":@"148"} withCompletionBlock:^{
            [GRToast makeText:@"删除成功"];
        }];
    }];
}

- (IBAction)sureAction:(ZHLZButton *)sender {
    
    if (![self.workNnameTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入单位名称"];
        return;
    }
    if (![self.principalNnameTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入负责人名称"];
        return;
    }
    
    if (self.setType == 1) { //添加
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ResponsibleUnitSaveAPIURLConst andParms:@{@"name":self.workNnameTextFile.text,@"charger":self.principalNnameTextFile.text,@"phone":self.principalPhoneTextFile.text,@"remark":self.remarkTextFile.text} withCompletionBlock:^{
            [GRToast makeText:@"添加成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {//编辑
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:ResponsibleUnitUpdateAPIURLConst andParms:@{@"name":self.workNnameTextFile.text,@"charger":self.principalNnameTextFile.text,@"phone":self.principalPhoneTextFile.text,@"remark":self.remarkTextFile.text,@"id":self.monadModel.objectID} withCompletionBlock:^{
            [GRToast makeText:@"修改成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (IBAction)callAction:(UIButton *)sender {
    NSString *phoneString = self.principalPhoneTextFile.text;
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
