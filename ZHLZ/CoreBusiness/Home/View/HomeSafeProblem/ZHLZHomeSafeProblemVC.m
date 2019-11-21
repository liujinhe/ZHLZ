//
//  ZHLZHomeSafeProblemVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemVC.h"
#import "ZHLZHomeSafeProblemCell.h"
#import "ZHLZHomeSafeProblemVM.h"
#import "ZHLZHomeSafeProblemDetailVC.h"

@interface ZHLZHomeSafeProblemVC ()<UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeSafeProblemTableView;

@property (nonatomic , assign) NSInteger pageNum;

@property (nonatomic , strong) NSMutableArray <ZHLZHomeSafeProblemModel *> *homeSafeProblemModelArray;

@end

@implementation ZHLZHomeSafeProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightBarButtonItemWithTitle:@"新增" action:@selector(addAction)];
    
    [self loadHomeSafeProblemView];
    
    [self loadHomeSafeProblemData];
}

- (void)addAction {
    ZHLZHomeSafeProblemDetailVC *homeSafeProblemDetailVC = [ZHLZHomeSafeProblemDetailVC new];
    [self.navigationController pushViewController:homeSafeProblemDetailVC animated:YES];
}

- (void)loadHomeSafeProblemData{
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeProblemDataWithPageNum:self.pageNum WithBlock:^(NSArray<ZHLZHomeSafeProblemModel *> * _Nonnull homeSafeProblemArray) {
        
        self.homeSafeProblemModelArray = homeSafeProblemArray.mutableCopy;
        
        [self.homeSafeProblemTableView reloadData];
    }];
}

- (void)loadHomeSafeProblemView{
    
    self.pageNum = 1;
    
    self.homeSafeProblemModelArray = [NSMutableArray <ZHLZHomeSafeProblemModel *> new];
    
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
    return self.homeSafeProblemModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZHomeSafeProblemCell";
    
    ZHLZHomeSafeProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZHomeSafeProblemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.homeSafeProblemModel = self.homeSafeProblemModelArray[indexPath.row];

    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}




@end
