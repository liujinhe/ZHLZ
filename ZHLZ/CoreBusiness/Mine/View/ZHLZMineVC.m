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

#import "ZHLZMineCell.h"

@interface ZHLZMineVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mineTableView;

@end

@implementation ZHLZMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMineView];
}

#pragma mark --初始化视图

- (void)initMineView{
    
    self.mineTableView.dataSource = self;
    self.mineTableView.delegate = self;
    self.mineTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.mineTableView.showsVerticalScrollIndicator = NO;
    
    [self.mineTableView registerNib:[UINib nibWithNibName:@"ZHLZMineCell" bundle:nil] forCellReuseIdentifier:@"ZHLZMineCell"];
    
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZMineCell";

    ZHLZMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZMineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
