//
//  ZHLZMineVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZMineVC.h"
#import "ZHLZChangePasswordVC.h"
#import "ZHLZHelpVC.h"
#import "ZHLZAboutVC.h"
#import "ZHLZUserManager.h"
#import "ZHLZLoginVC.h"

#import "ZHLZMineCell.h"

@interface ZHLZMineVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UITableView *mineTableView;

@property (nonatomic , strong) NSArray *itemArray;
@property (nonatomic , strong) NSArray *loginOut;

@end

@implementation ZHLZMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMineView];
}

#pragma mark --初始化视图

- (void)initMineView{
    
    self.itemArray = @[@"修改密码",@"关于我们",@"帮助中心"];
    self.loginOut = @[@"退出登录"];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.mineTableView.dataSource = self;
    self.mineTableView.delegate = self;
    self.mineTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.mineTableView.showsVerticalScrollIndicator = NO;
    
    [self.mineTableView registerNib:[UINib nibWithNibName:@"ZHLZMineCell" bundle:nil] forCellReuseIdentifier:@"ZHLZMineCell"];
    
}

#pragma mark --UITableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.itemArray.count;
    } else {
        return self.loginOut.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"ZHLZMineCell";
    if (indexPath.section == 0) {
        ZHLZMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ZHLZMineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.itemNameString = self.itemArray[indexPath.row];
        cell.isRedColor = NO;
        
        return cell;
    } else {
        ZHLZMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ZHLZMineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.itemNameString = self.loginOut[indexPath.row];
        cell.isRedColor = YES;
        
        return cell;
    }
 }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ZHLZChangePasswordVC *changePasswordVC = [ZHLZChangePasswordVC new];
            [self.navigationController pushViewController:changePasswordVC animated:YES];
        } else if (indexPath.row == 1) {
            ZHLZAboutVC *aboutVC = [ZHLZAboutVC new];
            [self.navigationController pushViewController:aboutVC animated:YES];
        } else if (indexPath.row == 2) {
            ZHLZHelpVC *helpVC = [ZHLZHelpVC new];
            [self.navigationController pushViewController:helpVC animated:YES];
        }
    } else {
        @weakify(self);
        [self popActionWithTip:@"是否退出登录？" withBlock:^{
            @strongify(self);
            [[ZHLZUserManager sharedInstance] logoutWithBlock:^{
                @strongify(self);
                [GRToast makeText:@"退出成功"];
                ZHLZLoginVC *loginVC = [ZHLZLoginVC new];
                loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
                [self.navigationController presentViewController:loginVC animated:NO completion:nil];
            }];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 150;
    } else {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.headerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return self.footerView;
    } else {
        return nil;
    }
    
}


@end
