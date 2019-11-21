//
//  ZHLZHomeSafeDetailVC.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeDetailVC.h"

@interface ZHLZHomeSafeDetailVC ()

@property (weak, nonatomic) IBOutlet UIButton *bigGrouponButton;
@property (weak, nonatomic) IBOutlet UITextField *locationTextFile;

@property (weak, nonatomic) IBOutlet UIButton *dutyUnitButton;

@property (weak, nonatomic) IBOutlet ZHLZTextView *problemTextView;
@property (weak, nonatomic) IBOutlet ZHLZTextView *lookHistoryTextView;

@property (weak, nonatomic) IBOutlet ZHLZTextView *workTypeTextView;

@property (weak, nonatomic) IBOutlet ZHLZButton *submitButton;
@end

@implementation ZHLZHomeSafeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHomeSafeDetailView];
}

- (void)editAction {
    ZHLZHomeSafeDetailVC *safeDetailVC = [ZHLZHomeSafeDetailVC new];
    safeDetailVC.type = 3;
    [self.navigationController pushViewController:safeDetailVC animated:YES];
}

- (void)initHomeSafeDetailView {
    if (self.type == 1) {
        self.title = @"新增安全(三防)台账";
        [self.submitButton setTitle:@"确认添加" forState:UIControlStateNormal];
    } else if (self.type == 2){
        self.title = @"查看安全(三防)台账";
        [self addRightBarButtonItemWithTitle:@"编辑" action:@selector(editAction)];
        
        self.submitButton.hidden = YES;
        
        [self isLookControl];
    } else {
        self.title = @"编辑安全(三防)台账";
        [self.submitButton setTitle:@"确认修改" forState:UIControlStateNormal];
    }
}

- (void)isLookControl{
    self.bigGrouponButton.userInteractionEnabled = NO;
    self.locationTextFile.userInteractionEnabled = NO;
    self.dutyUnitButton.userInteractionEnabled = NO;
    
    [self.problemTextView setEditable:NO];
    [self.lookHistoryTextView setEditable:NO];
    [self.workTypeTextView setEditable:NO];
}


- (IBAction)bigGrouponAction:(UIButton *)sender {
    
}

- (IBAction)dutyUnitAction:(UIButton *)sender {
    
}

- (IBAction)SubmitAction:(UIButton *)sender {
    
}

@end
