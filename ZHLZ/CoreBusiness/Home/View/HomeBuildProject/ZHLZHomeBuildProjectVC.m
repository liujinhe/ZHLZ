//
//  ZHLZHomeBuildProjectVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectVC.h"
#import "ZHLZHomeBuildProjectCell.h"

@interface ZHLZHomeBuildProjectVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hmeBuildProjectTableView;


@end

@implementation ZHLZHomeBuildProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    
    [self loadHomeProjectBuildView];
}

- (void)addAction {
    
}

- (void)loadHomeProjectBuildView{
    self.hmeBuildProjectTableView.dataSource = self;
    self.hmeBuildProjectTableView.delegate = self;
    self.hmeBuildProjectTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.hmeBuildProjectTableView.showsVerticalScrollIndicator = NO;
    
    [self.hmeBuildProjectTableView registerNib:[UINib nibWithNibName:@"ZHLZHomeBuildProjectCell" bundle:nil] forCellReuseIdentifier:@"ZHLZHomeBuildProjectCell"];
    
    self.hmeBuildProjectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeBuildProjectHeader)];
    self.hmeBuildProjectTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeBuildProjectHeaderFooter)];
}

- (void)loadHomeBuildProjectHeader{
    
}

- (void)loadHomeBuildProjectHeaderFooter{
    
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZHomeBuildProjectCell";

    ZHLZHomeBuildProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZHomeBuildProjectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



@end
