//
//  ZHLZChosseStepVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZChosseStepVC.h"
#import "ZHLZHomeSafeProblemVM.h"
#import "ZHLZChosseStepModel.h"
#import "ZHLZChooseStepCell.h"

@interface ZHLZChosseStepVC ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) NSMutableArray <ZHLZChosseStepModel *> *stepModelArray;

@property (weak, nonatomic) IBOutlet UITableView *stepTableView;

@end

@implementation ZHLZChosseStepVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择措施";
    
    self.stepTableView.dataSource = self;
    self.stepTableView.delegate = self;
    self.stepTableView.backgroundColor = kHexRGB(0xf7f7f7);
    
    self.stepTableView.showsVerticalScrollIndicator = NO;
    
    [self.stepTableView registerNib:[UINib nibWithNibName:@"ZHLZChooseStepCell" bundle:nil] forCellReuseIdentifier:@"ZHLZChooseStepCell"];
    
    NSArray *aarr = @[@{@"name":@"发出文书",@"value":@"1",@"children":@[
                                @{@"name":@"催办延期通知书",@"value":@"7",@"children":@[]},
                                @{@"name":@"责令整改告知函",@"value":@"8",@"children":@[]},
                                @{@"name":@"执法建议书",@"value":@"9",@"children":@[]},
                                @{@"name":@"责令停止违法行为通知书",@"value":@"10",@"children":@[]},
                                @{@"name":@"责令（限期改正通知书）",@"value":@"11",@"children":@[]},
                                @{@"name":@"调查通知书",@"value":@"12",@"children":@[]},
                                @{@"name":@"行政处罚决定书",@"value":@"13",@"children":@[]},
                                @{@"name":@"其他法律文书",@"value":@"14",@"children":@[]},
                                @{@"name":@"其他公文函件",@"value":@"15",@"children":@[]}
                    ]},
    @{@"name":@"召集会议",@"value":@"3",@"children":@[]},
    @{@"name":@"责令改正",@"value":@"4",@"children":@[]},
    @{@"name":@"微信/电话督办",@"value":@"5",@"children":@[]},
    @{@"name":@"移交/告知/通知（其他职能部门）",@"value":@"6",@"children":@[]},
    @{@"name":@"发出文书",@"value":@"16",@"children":@[]}];
    
    self.stepModelArray = [NSMutableArray <ZHLZChosseStepModel *> new];

    NSArray  *array = [NSArray modelArrayWithClass:[ZHLZChosseStepModel class] json:aarr];
    
    self.stepModelArray = array.mutableCopy;
}

#pragma mark --UITableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.stepModelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    ZHLZChosseStepModel *chosseStepModel = self.stepModelArray[section];
    return chosseStepModel.children.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"ZHLZChooseStepCell";
    
    ZHLZChooseStepCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[ZHLZChooseStepCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    ZHLZChosseStepModel *chosseStepModel = self.stepModelArray[indexPath.section];
    cell.chooseChildrenModel = chosseStepModel.children[indexPath.row];

    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZHLZChosseStepModel *chosseStepModel = self.stepModelArray[section];
    
    UIView *headerView = [UIView  new];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = chosseStepModel.name;
    nameLabel.font = kFont(15);
    [headerView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(20);
        make.top.equalTo(headerView.mas_top);
        make.bottom.equalTo(headerView.mas_bottom);
        make.right.equalTo(headerView.mas_right).offset(-40);
    }];
    
    if (chosseStepModel.children.count == 0) {
        UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.backgroundColor = [UIColor clearColor];
        if (chosseStepModel.isSelect) {
            [chooseButton setImage:[UIImage imageNamed:@"icon_choose_selected"] forState:UIControlStateNormal];
        } else {
            [chooseButton setImage:[UIImage imageNamed:@"icon_choose_normal"] forState:UIControlStateNormal];
        }
        chooseButton.tag = section;
        [chooseButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [chooseButton addTarget:self action:@selector(selectIconAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:chooseButton];
        [chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.mas_top);
            make.bottom.equalTo(headerView.mas_bottom);
            make.right.equalTo(headerView.mas_right).offset(-10);
            make.left.equalTo(nameLabel.mas_right).offset(0);
        }];
    }
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kHexRGB(0xD9D9D9);
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headerView.mas_bottom);
        make.right.equalTo(headerView.mas_right).offset(0);
        make.left.equalTo(headerView.mas_left).offset(0);
        make.height.offset(0.5);
    }];
    
    return headerView;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHLZChosseStepModel *chosseStepModel = self.stepModelArray[indexPath.section];
    
    NSMutableArray <ZHLZChosseChildrenModel *> *childrenArray = [NSMutableArray <ZHLZChosseChildrenModel *> new];
    childrenArray = chosseStepModel.children.mutableCopy;
    ZHLZChosseChildrenModel * childrenModel = childrenArray[indexPath.row];
    childrenModel.isSelect = !childrenModel.isSelect;
    [childrenArray replaceObjectAtIndex:indexPath.row withObject:childrenModel];
    
    chosseStepModel.children = childrenArray.mutableCopy;
    
    [self.stepModelArray replaceObjectAtIndex:indexPath.section withObject:chosseStepModel];
    
    [self.stepTableView reloadData];
    
    
}

- (void)selectIconAction:(UIButton *)btn {
    ZHLZChosseStepModel *chosseStepModel = self.stepModelArray[btn.tag];
    chosseStepModel.isSelect = !chosseStepModel.isSelect;
    
    [self.stepModelArray replaceObjectAtIndex:btn.tag withObject:chosseStepModel];
    
    [self.stepTableView reloadData];
}

@end
