//
//  ZHLZBookListVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBookListVC.h"
#import "ZHLZBookListCell.h"


@interface ZHLZBookListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bookListTableView;

@end

@implementation ZHLZBookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBookListView];
}
#pragma mark --初始化视图

- (void)initBookListView{
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.bookListTableView.dataSource = self;
    self.bookListTableView.delegate = self;
    self.bookListTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.bookListTableView.showsVerticalScrollIndicator = NO;
    
    [self.bookListTableView registerNib:[UINib nibWithNibName:@"ZHLZBookListCell" bundle:nil] forCellReuseIdentifier:@"ZHLZBookListCell"];
    
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZBookListCell";

    ZHLZBookListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZBookListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


@end
