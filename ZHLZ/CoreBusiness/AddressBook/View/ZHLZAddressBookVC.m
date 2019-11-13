//
//  ZHLZAddressBookVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZAddressBookVC.h"
#import "ZHLZAddressBookCell.h"
#import "ZHLZBookListVC.h"

@interface ZHLZAddressBookVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *addressBookTableView;

@end

@implementation ZHLZAddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAddressBookView];
}

#pragma mark --初始化视图

- (void)initAddressBookView{
    
    self.addressBookTableView.dataSource = self;
    self.addressBookTableView.delegate = self;
    self.addressBookTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.addressBookTableView.showsVerticalScrollIndicator = NO;
    
    [self.addressBookTableView registerNib:[UINib nibWithNibName:@"ZHLZAddressBookCell" bundle:nil] forCellReuseIdentifier:@"ZHLZAddressBookCell"];
    
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZAddressBookCell";

    ZHLZAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZAddressBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHLZBookListVC *bookListVC = [ZHLZBookListVC new];
    [self.navigationController pushViewController:bookListVC animated:YES];
}



@end
