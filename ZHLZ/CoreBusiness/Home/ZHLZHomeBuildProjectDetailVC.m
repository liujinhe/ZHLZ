//
//  ZHLZHomeBuildProjectDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectDetailVC.h"
#import "ZHLZProjectDetailTableViewCell.h"

@interface ZHLZHomeBuildProjectDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *buildProjectDetailTableView;

@end

@implementation ZHLZHomeBuildProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildProjectDetailView];
}

- (void)editAction {
    
}

- (void)buildProjectDetailView{
    
    if (self.isEdit) {
        
        self.title = @"编辑在建项目";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
    } else {
        self.title = @"新增在建项目";
    }
    
    self.buildProjectDetailTableView.dataSource = self;
    self.buildProjectDetailTableView.delegate = self;
    self.buildProjectDetailTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.buildProjectDetailTableView.showsVerticalScrollIndicator = NO;
    
    [self.buildProjectDetailTableView registerNib:[UINib nibWithNibName:@"ZHLZProjectDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZHLZProjectDetailTableViewCell"];
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZProjectDetailTableViewCell";

    ZHLZProjectDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZProjectDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
