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
    
    self.task = [[ZHLZMineVM sharedInstance] changePasswordWitParms:@{@"password":@"",@"newPassword":@""} withCompletionBlock:^{
        [GRToast makeText:@"密码修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)changePassword{
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
