//
//  ZHLZHomeBusinessDocumentVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBusinessDocumentVC.h"
#import "ZHLZBusinessDocumentCell.h"
#import "ZHLZHomeBusinessDocumentVM.h"


@interface ZHLZHomeBusinessDocumentVC ()<UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *businessDocumentTableView;

@property (nonatomic , assign) NSInteger pageNum;

@property (nonatomic , strong) NSMutableArray <ZHLZHomeBusinessDocumentModel *> *businessDocumentModelArray;

@end

@implementation ZHLZHomeBusinessDocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodBusinessDocumentView];
    
    [self homeBusinessDocumentData];
}

- (void)homeBusinessDocumentData {
    self.task  = [[ZHLZHomeBusinessDocumentVM sharedInstance] loadHomeBusinessDocumentDataWithPageNum:self.pageNum WithBlock:^(NSArray<ZHLZHomeBusinessDocumentModel *> * _Nonnull homeBusinessDocumentModel) {
        
        self.businessDocumentModelArray = homeBusinessDocumentModel.mutableCopy;
        
        [self.businessDocumentTableView reloadData];
    }];
}


- (void)laodBusinessDocumentView{
    self.title = @"业务文件";
    
    self.pageNum = 1;
    
    self.businessDocumentModelArray = [NSMutableArray <ZHLZHomeBusinessDocumentModel *> new];
    
    self.businessDocumentTableView.dataSource = self;
    self.businessDocumentTableView.delegate = self;
    self.businessDocumentTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.businessDocumentTableView.showsVerticalScrollIndicator = NO;
    
    [self.businessDocumentTableView registerNib:[UINib nibWithNibName:@"ZHLZBusinessDocumentCell" bundle:nil] forCellReuseIdentifier:@"ZHLZBusinessDocumentCell"];
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.businessDocumentModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZBusinessDocumentCell";

    ZHLZBusinessDocumentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZBusinessDocumentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.homeBusinessDocumentModel = self.businessDocumentModelArray[indexPath.row];
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
