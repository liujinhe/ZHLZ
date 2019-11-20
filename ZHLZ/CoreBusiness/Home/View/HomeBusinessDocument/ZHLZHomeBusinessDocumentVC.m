//
//  ZHLZHomeBusinessDocumentVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBusinessDocumentVC.h"
#import "ZHLZBusinessDocumentCell.h"

@interface ZHLZHomeBusinessDocumentVC ()<UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *businessDocumentTableView;


@end

@implementation ZHLZHomeBusinessDocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodBusinessDocumentView];
}

- (void)laodBusinessDocumentView{
    self.title = @"业务文件";
    
    self.businessDocumentTableView.dataSource = self;
    self.businessDocumentTableView.delegate = self;
    self.businessDocumentTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.businessDocumentTableView.showsVerticalScrollIndicator = NO;
    
    [self.businessDocumentTableView registerNib:[UINib nibWithNibName:@"ZHLZBusinessDocumentCell" bundle:nil] forCellReuseIdentifier:@"ZHLZBusinessDocumentCell"];
}

#pragma mark --UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZBusinessDocumentCell";

    ZHLZBusinessDocumentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZBusinessDocumentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
