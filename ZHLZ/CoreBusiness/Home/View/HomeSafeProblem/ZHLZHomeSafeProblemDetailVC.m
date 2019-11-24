//
//  ZHLZHomeSafeProblemDetailVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemDetailVC.h"
#import "ZHLZHomeSafeProblemVM.h"
#import "ZHLZAddCouncilorVC.h"

@interface ZHLZHomeSafeProblemDetailVC ()

@property (weak, nonatomic) IBOutlet ZHLZButton *problemSubmitButton;

@property (nonatomic , strong) ZHLZHomeSafeProblemModel *homeSafeProblemModel;

@property (nonatomic , strong) ZHLZHomeSafeProblemSUbmitModel *homeSafeProblemSUbmitModel;

@end

@implementation ZHLZHomeSafeProblemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSafeProblemDetailView];
}

- (void)editAction {
    ZHLZHomeSafeProblemDetailVC *safeProblemDetailVC = [ZHLZHomeSafeProblemDetailVC new];
    safeProblemDetailVC.detailType = 3;
    safeProblemDetailVC.detailId = [NSString stringWithFormat:@"%@",self.homeSafeProblemModel.objectID];
    [self.navigationController pushViewController:safeProblemDetailVC animated:YES];
}

- (void)getProblemDetailData{
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] loadHomeSafeProblemDetailWithId:self.detailId WithBlock:^(ZHLZHomeSafeProblemModel * _Nonnull homeSafeProblem) {
        self.homeSafeProblemModel = homeSafeProblem;
        
    }];
}

- (void)initSafeProblemDetailView {
    
    if (self.detailType == 1) {
        self.title = @"新增安全(三防)问题";
        [self.problemSubmitButton setTitle:@"确定添加" forState:UIControlStateNormal];
        
        
    } else if (self.detailType == 2){
        self.title = @"查看安全(三防)问题";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        [self getProblemDetailData];
        
        [self lookSetView];
        
    } else {
        
        self.title = @"编辑安全(三防)问题";
        [self.problemSubmitButton setTitle:@"确定修改" forState:UIControlStateNormal];
        
        [self getProblemDetailData];
        
    }
    
    self.homeSafeProblemSUbmitModel = [ZHLZHomeSafeProblemSUbmitModel new];
}

- (void)lookSetView {
    self.problemSubmitButton.hidden = YES;
}


- (IBAction)setSupervisorAction:(UIButton *)sender {
    ZHLZAddCouncilorVC *addCouncilorVC = [ZHLZAddCouncilorVC new];
    [self.navigationController pushViewController:addCouncilorVC animated:YES];
}

- (IBAction)problemSubmitAction:(ZHLZButton *)sender {
    
    self.homeSafeProblemSUbmitModel.risksid = @"123";
    self.homeSafeProblemSUbmitModel.areaid = @"123";
    self.homeSafeProblemSUbmitModel.belong = @"";
    self.homeSafeProblemSUbmitModel.finddate = @"";
    self.homeSafeProblemSUbmitModel.promanager = @"";
    self.homeSafeProblemSUbmitModel.ddssjtms = @"";
    self.homeSafeProblemSUbmitModel.prodescription = @"";
    self.homeSafeProblemSUbmitModel.remark = @"";
    self.homeSafeProblemSUbmitModel.uploadId = @"";
    
    
    @weakify(self)
    self.task = [[ZHLZHomeSafeProblemVM sharedInstance] submitHomeSafeProblemWithSubmitType:self.detailType andSubmitModel:self.homeSafeProblemSUbmitModel withBlock:^{
        
        @strongify(self)
        if (self.detailType == 1) {
            [GRToast makeText:@"新增成功"];
        } else {
            [GRToast makeText:@"修改成功"];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
