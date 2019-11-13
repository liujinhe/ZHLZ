//
//  ZHLZLoginVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZLoginVC.h"
#import "ZHLZLoginVM.h"
#import "ZHLZLoginModel.h"

@interface ZHLZLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *rememberPwdButton;

@end

@implementation ZHLZLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)rememberPwdAction:(UIButton *)sender {
    
}

- (IBAction)loginAction {
    ZHLZLoginModel *loginModel = [ZHLZLoginModel new];
    loginModel.username = self.userNameTextField.text;
    loginModel.password = self.pwdTextField.text;
    if (![loginModel.username isNotBlank]) {
        [GRToast makeText:@"请输入账号"];
        return;
    }
    if (![loginModel.password isNotBlank]) {
        [GRToast makeText:@"请输入密码"];
        return;
    }
    self.task = [[ZHLZLoginVM sharedInstance] loginWithModel:loginModel withCompletionBlock:^{
        
    }];
}

@end
