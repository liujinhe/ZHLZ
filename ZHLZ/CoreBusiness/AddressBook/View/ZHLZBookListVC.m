//
//  ZHLZBookListVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBookListVC.h"
#import <YYKit/UIControl+YYAdd.h>
#import "ZHLZBookListCell.h"
#import "ZHLZAddressBookVM.h"

#import "ZHLZRoadWorkVC.h"//施工单位
#import "ZHLZExamineVC.h"//审批部门
#import "ZHLZConstructionVC.h"//建设单位

#import "ZHLZAreaManagementVC.h"//区管管理单位
#import "ZHLZCityManagementVC.h"//市管管理单位
#import "ZHLZSpecialVC.h"//特殊业主单位

#import "ZHLZMonadVC.h"//责任单位


@interface ZHLZBookListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bookListTableView;

@end

@implementation ZHLZBookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBookListView];
    
    [self loadAddressListData];
}

- (void)loadAddressListData{
    self.task = [[ZHLZAddressBookVM sharedInstance] loadListWithType:self.selectIndex CallBack:^(NSDictionary * _Nonnull parms) {
        
    }];
}

#pragma mark --初始化视图

- (void)initBookListView{
    
    self.title = self.titleNameString;
    
    UIButton *areaManagementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [areaManagementButton setTitle:@"添加" forState:UIControlStateNormal];
    [areaManagementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [areaManagementButton sizeToFit];
    @weakify(self);
    [areaManagementButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id _Nonnull sender) {
        @strongify(self);
        [self clickAddActionwithType:1];
    }];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:areaManagementButton]];
    
    
    
    self.bookListTableView.dataSource = self;
    self.bookListTableView.delegate = self;
    self.bookListTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.bookListTableView.showsVerticalScrollIndicator = NO;
    
    [self.bookListTableView registerNib:[UINib nibWithNibName:@"ZHLZBookListCell" bundle:nil] forCellReuseIdentifier:@"ZHLZBookListCell"];
    
}

- (void)clickAddActionwithType:(NSInteger)type{
    
    if (self.selectIndex == 0) {
        ZHLZRoadWorkVC *roadWorkVC = [ZHLZRoadWorkVC new];
        roadWorkVC.editType = type;
        [self.navigationController pushViewController:roadWorkVC animated:YES];
        
    } else if(self.selectIndex == 1){
        ZHLZExamineVC *examineVC = [ZHLZExamineVC new];
        examineVC.setType = type;
        [self.navigationController pushViewController:examineVC animated:YES];
        
    } else if(self.selectIndex == 2){
        ZHLZConstructionVC *constructionVC = [ZHLZConstructionVC new];
        [self.navigationController pushViewController:constructionVC animated:YES];
        
    } else if(self.selectIndex == 3){
        ZHLZAreaManagementVC *areaManagementVC = [ZHLZAreaManagementVC new];
        [self.navigationController pushViewController:areaManagementVC animated:YES];
        
    } else if(self.selectIndex == 4){
        ZHLZCityManagementVC *cityManagementVC = [ZHLZCityManagementVC new];
        [self.navigationController pushViewController:cityManagementVC animated:YES];
        
    } else if(self.selectIndex == 5){
        ZHLZSpecialVC *specialVC = [ZHLZSpecialVC new];
        [self.navigationController pushViewController:specialVC animated:YES];
        
    } else if(self.selectIndex == 6){
        ZHLZMonadVC *monadVC = [ZHLZMonadVC new];
        monadVC.setType = type;
        [self.navigationController pushViewController:monadVC animated:YES];
        
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self clickAddActionwithType:2];
}

@end
