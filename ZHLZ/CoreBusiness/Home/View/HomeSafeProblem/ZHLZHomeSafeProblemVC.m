//
//  ZHLZHomeSafeProblemVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemVC.h"
#import "ZHLZHomeSafeProblemCell.h"

@interface ZHLZHomeSafeProblemVC ()<UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeSafeProblemTableView;


@end

@implementation ZHLZHomeSafeProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    
    [self loadHomeSafeProblemView];
}

- (void)addAction {
    
}

- (void)loadHomeSafeProblemView{
    self.homeSafeProblemTableView.dataSource = self;
    self.homeSafeProblemTableView.delegate = self;
    self.homeSafeProblemTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.homeSafeProblemTableView.showsVerticalScrollIndicator = NO;
    
    [self.homeSafeProblemTableView registerNib:[UINib nibWithNibName:@"ZHLZHomeSafeProblemCell" bundle:nil] forCellReuseIdentifier:@"ZHLZHomeSafeProblemCell"];
    
    self.homeSafeProblemTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeProblemHeader)];
    self.homeSafeProblemTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadHomeSafeProblemFooter)];
}

- (void)loadHomeSafeProblemHeader{
    
}

- (void)loadHomeSafeProblemFooter{
    
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZHomeSafeProblemCell";

    ZHLZHomeSafeProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZHomeSafeProblemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}




@end
