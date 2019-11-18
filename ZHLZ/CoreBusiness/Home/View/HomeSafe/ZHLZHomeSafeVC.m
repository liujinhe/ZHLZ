//
//  ZHLZHomeSafeVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeVC.h"
#import "ZHLZHomeSafeCell.h"


@interface ZHLZHomeSafeVC ()<UITableViewDelegate , UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *homeSafeTableView;


@end

@implementation ZHLZHomeSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithTitle:@"添加" action:@selector(addAction)];
    
    [self loadHomeSafeView];
}

- (void)addAction {
    
}


- (void)loadHomeSafeView{
    self.homeSafeTableView.dataSource = self;
    self.homeSafeTableView.delegate = self;
    self.homeSafeTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.homeSafeTableView.showsVerticalScrollIndicator = NO;
    
    [self.homeSafeTableView registerNib:[UINib nibWithNibName:@"ZHLZHomeSafeCell" bundle:nil] forCellReuseIdentifier:@"ZHLZHomeSafeCell"];
    
    self.homeSafeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeHeader)];
    self.homeSafeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeFooter)];
}

- (void)loadHomeSafeHeader{
    
}

- (void)loadHomeSafeFooter{
    
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZHomeSafeCell";

    ZHLZHomeSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZHomeSafeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



@end