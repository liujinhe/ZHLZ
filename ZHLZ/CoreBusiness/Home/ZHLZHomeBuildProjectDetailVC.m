//
//  ZHLZHomeBuildProjectDetailVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectDetailVC.h"
#import "ZHLZProjectDetailTableViewCell.h"
#import "ZHLZHomeBuildProjectVM.h"

@interface ZHLZHomeBuildProjectDetailVC ()

@property (weak, nonatomic) IBOutlet UITextField *projectNameTextFile;
@property (weak, nonatomic) IBOutlet UIButton *projectTypeButton;
@property (weak, nonatomic) IBOutlet UITextField *projectLocationTextFile;
@property (weak, nonatomic) IBOutlet UIButton *developmentUnitButton;
@property (weak, nonatomic) IBOutlet UIButton *roadWorkButton;
@property (weak, nonatomic) IBOutlet UIButton *approvalAuthorityButton;

@property (weak, nonatomic) IBOutlet UIButton *licenceStartButton;
@property (weak, nonatomic) IBOutlet UIButton *licenceEndButton;
@property (weak, nonatomic) IBOutlet UIButton *demandTimeButton;

@property (weak, nonatomic) IBOutlet UIButton *roadWorkTypeButton;

@property (weak, nonatomic) IBOutlet UIButton *brigadeButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UIButton *dutyAreaButton;

@property (weak, nonatomic) IBOutlet UITextField *acreageTextFile;
@property (weak, nonatomic) IBOutlet UITextField *licenceNumTextFile;

@property (weak, nonatomic) IBOutlet UITextField *projectNumTextFile;
@property (weak, nonatomic) IBOutlet UIButton *emphasisProjectButton;


@property (weak, nonatomic) IBOutlet UILabel *locationXLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationYLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet ZHLZTextView *remarkTextView;


@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;

@property (nonatomic , strong) ZHLZHomeBuildProjectSubmitModel *projectSubmitModel;

@end

@implementation ZHLZHomeBuildProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildProjectDetailView];
}

-(void)editAction {
    ZHLZHomeBuildProjectDetailVC *buildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
    buildProjectDetailVC.detailType = 3;
    buildProjectDetailVC.detailId = self.detailId;
    [self.navigationController pushViewController:buildProjectDetailVC animated:YES];
}

- (void)buildProjectDetailView{
    
    if (self.detailType == 1) {
        
        self.title = @"新增在建项目";
        [self.submitButton setTitle:@"确认新建" forState:UIControlStateNormal];
        
    } else if (self.detailType == 2){
        self.title = @"查看在建项目";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        self.submitButton.hidden = YES;
        
        [self loadDetailData];
        
        [self setViewToLookDetail];
        
    } else {
        self.title = @"编辑在建项目";
        [self.submitButton setTitle:@"确认保存" forState:UIControlStateNormal];
        
        [self loadDetailData];
    }
    
    self.projectSubmitModel = [ZHLZHomeBuildProjectSubmitModel new];
}

- (void)setViewToLookDetail {
    
    //设置UIButton背景颜色
    self.projectTypeButton.backgroundColor = [UIColor whiteColor];
    self.projectTypeButton.backgroundColor = [UIColor whiteColor];
    self.developmentUnitButton.backgroundColor = [UIColor whiteColor];
    self.roadWorkButton.backgroundColor = [UIColor whiteColor];
    self.approvalAuthorityButton.backgroundColor = [UIColor whiteColor];
    
    self.licenceStartButton.backgroundColor = [UIColor whiteColor];
    self.licenceEndButton.backgroundColor = [UIColor whiteColor];
    self.demandTimeButton.backgroundColor = [UIColor whiteColor];
    self.roadWorkTypeButton.backgroundColor = [UIColor whiteColor];
    self.brigadeButton.backgroundColor = [UIColor whiteColor];
    
    self.areaButton.backgroundColor = [UIColor whiteColor];
    self.dutyAreaButton.backgroundColor = [UIColor whiteColor];
    self.emphasisProjectButton.backgroundColor = [UIColor whiteColor];
    
    
    //设置按钮不可编辑
    self.projectTypeButton.userInteractionEnabled = NO;
    self.projectTypeButton.userInteractionEnabled = NO;
    self.projectLocationTextFile.userInteractionEnabled = NO;
    self.developmentUnitButton.userInteractionEnabled = NO;
    self.roadWorkButton.userInteractionEnabled = NO;
    
    self.approvalAuthorityButton.userInteractionEnabled = NO;
    self.licenceStartButton.userInteractionEnabled = NO;
    self.licenceEndButton.userInteractionEnabled = NO;
    self.demandTimeButton.userInteractionEnabled = NO;
    self.roadWorkTypeButton.userInteractionEnabled = NO;
    
    self.brigadeButton.userInteractionEnabled = NO;
    self.areaButton.userInteractionEnabled = NO;
    self.dutyAreaButton.userInteractionEnabled = NO;
    self.acreageTextFile.userInteractionEnabled = NO;
    self.licenceNumTextFile.userInteractionEnabled = NO;
    
    self.projectNumTextFile.userInteractionEnabled = NO;
    self.emphasisProjectButton.userInteractionEnabled = NO;
    [self.remarkTextView setEditable:NO];
    
}

- (void)loadDetailData {
    self.task = [[ZHLZHomeBuildProjectVM sharedInstance] loadHomeBuildProjectDataId:self.detailId WithBlock:^(ZHLZHomeBuildProjectModel * _Nonnull homeBuildProjectModel) {
        
        self.projectNameTextFile.text = homeBuildProjectModel.name;
        
        [self.projectTypeButton setTitle:homeBuildProjectModel.typeName forState:UIControlStateNormal];
        
        self.projectLocationTextFile.text = homeBuildProjectModel.position;
        
        [self.developmentUnitButton setTitle:homeBuildProjectModel.constructorName forState:UIControlStateNormal];
        
        [self.roadWorkButton setTitle:homeBuildProjectModel.builderName forState:UIControlStateNormal];
        
        [self.approvalAuthorityButton setTitle:homeBuildProjectModel.approverName forState:UIControlStateNormal];
        
        
        NSString *licenceTimeString  = homeBuildProjectModel.enddateNew;
        NSRange range = [licenceTimeString rangeOfString:@"至"];
        NSString *timeStart = [licenceTimeString substringToIndex:range.location];
        NSString *timeEnd = [licenceTimeString substringFromIndex:range.location + 1];
        
        [self.licenceStartButton setTitle:timeStart forState:UIControlStateNormal];
        [self.licenceEndButton setTitle:timeEnd forState:UIControlStateNormal];
        
        
        [self.demandTimeButton setTitle:homeBuildProjectModel.frequencyName forState:UIControlStateNormal];
        
        
        [self.roadWorkTypeButton setTitle:homeBuildProjectModel.statusName forState:UIControlStateNormal];
        
        [self.brigadeButton setTitle:homeBuildProjectModel.bidName forState:UIControlStateNormal];
        
        //
        [self.areaButton setTitle:homeBuildProjectModel.areaid forState:UIControlStateNormal];
        //
        [self.dutyAreaButton setTitle:homeBuildProjectModel.belong forState:UIControlStateNormal];
        
        self.acreageTextFile.text = homeBuildProjectModel.area;
        self.licenceNumTextFile.text = homeBuildProjectModel.licenseId;
        self.projectNumTextFile.text = homeBuildProjectModel.projectno;
        
        [self.emphasisProjectButton setTitle:homeBuildProjectModel.focuson forState:UIControlStateNormal];
    
        
        self.locationXLabel.text = [NSString stringWithFormat:@"经度：%@",homeBuildProjectModel.coordinatesX];
        self.locationYLabel.text = [NSString stringWithFormat:@"纬度：%@",homeBuildProjectModel.coordinatesY];
        self.locationLabel.text = [NSString stringWithFormat:@"当前位置：%@",homeBuildProjectModel.position];
        
    }];
}



- (IBAction)submitAction:(id)sender {
    
    
    
    
    
    @weakify(self)
    self.task = [[ZHLZHomeBuildProjectVM sharedInstance] submitHomeBuildProjectSubmitType:self.detailType andSubmitModel:self.projectSubmitModel withBlock:^{
        @strongify(self)
        
        if (self.detailType == 1) {
            [GRToast makeText:@"新增成功"];
        } else {
            [GRToast makeText:@"保存成功"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
