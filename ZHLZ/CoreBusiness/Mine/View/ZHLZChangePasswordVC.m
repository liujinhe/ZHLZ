//
//  ZHLZChangePasswordVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZChangePasswordVC.h"
#import "ZHLZMineVM.h"

@interface ZHLZChangePasswordVC ()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextFile;
@property (weak, nonatomic) IBOutlet UITextField *changePasswordTextFile;


@end

@implementation ZHLZChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
    self.oldPasswordTextFile.secureTextEntry = YES;
    self.changePasswordTextFile.secureTextEntry = YES;
}

- (IBAction)changeAction:(ZHLZButton *)sender {
    if (![self.oldPasswordTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入旧密码"];
        return;
    }
    if (![self.changePasswordTextFile.text isNotBlank]) {
        [GRToast makeText:@"请输入新密码"];
        return;
    }
    if ([self.changePasswordTextFile.text isEqualToString:self.oldPasswordTextFile.text]) {
        [GRToast makeText:@"新密码不可与原密码一致"];
        return;
    }
    
    self.task = [[ZHLZMineVM sharedInstance] changePasswordWitParms:@{@"password":self.oldPasswordTextFile.text,@"newPassword":self.changePasswordTextFile.text} withCompletionBlock:^{
        [GRToast makeText:@"密码修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
