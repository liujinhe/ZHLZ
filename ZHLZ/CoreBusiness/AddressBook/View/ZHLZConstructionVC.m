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

@property (weak, nonatomic) IBOutlet UIButton *callButton;

@property (nonatomic , strong) ConstructionList *constructionModel;//建设单位

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
        self.callButton.hidden = YES;
    } else {
        self.title = @"编辑建设单位";
        [self.constructionButton setTitle:@"确认修改" forState:UIControlStateNormal];
        self.callButton.hidden = NO;
        
        self.task = [[ZHLZAddressBookVM sharedInstance] checkDetailWithId:self.detailId andType:2 CallBack:^(NSDictionary * _Nonnull parms) {
            self.constructionModel = [ConstructionList modelWithJSON:parms];
            self.nameTextFIle.text = self.constructionModel.name;
            self.chargerTextFile.text = self.constructionModel.changer;
            self.phoneTextFIle.text = self.constructionModel.phone;
        }];
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
        self.task = [addressBookVM operationWithUrl:ConstructionUnitDeleteAPIURLConst andParms:@"123" withCompletionBlock:^{
            [GRToast makeText:@"删除成功"];
        }];
    }];
}

- (IBAction)constructionAction:(ZHLZButton *)sender {
    if (![self.nameTextFIle.text isNotBlank]) {
        [GRToast makeText:@"请输入建设单位"];
        return;
    }
    if (![self.chargerTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入建设单位联系人名称"];
        return;
    }
    if (![self.phoneTextFIle.text isNotBlank]) {
        [GRToast makeText:@"请输入建设单位联系人电话"];
        return;
    }
    
    if (self.setType == 1) { //添加
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:BuildUnitSaveAPIURLConst andParms:@{@"name":self.nameTextFIle.text,@"changer":self.chargerTextFile.text,@"phone":self.phoneTextFIle.text} withCompletionBlock:^{
            [GRToast makeText:@"添加成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {//编辑
        self.task = [[ZHLZAddressBookVM sharedInstance] operationWithUrl:BuildUnitUpdateAPIURLConst andParms:@{@"name":self.nameTextFIle.text,@"changer":self.chargerTextFile.text,@"phone":self.phoneTextFIle.text,@"id":self.constructionModel.objectID} withCompletionBlock:^{
            [GRToast makeText:@"修改成功"];
            self.reloadDataBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (IBAction)callAction:(UIButton *)sender {
    NSString *phoneString = self.phoneTextFIle.text;
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
