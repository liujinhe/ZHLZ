//
//  ZHLZHomeOccupyProblemSearchVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeOccupyProblemSearchVC.h"
#import "ZHLZDatePickerVC.h"
#import "ZHLZListPickerViewVC.h"
#import "ZHLZPickerViewVC.h"

@interface ZHLZHomeOccupyProblemSearchVC ()
{
    NSString *_startDateFind;   // 发现开始时间
    NSString *_endDateFind;     // 发现结束时间
    NSString *_startDateClosed; // 关闭开始时间
    NSString *_endDateClosed;   // 关闭结束时间
    NSString *_problemType;     // 问题类型
    NSString *_searchRange;     // 搜索范围
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *filterTopView;
@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollView;
@property (weak, nonatomic) IBOutlet UIView *filterBottomView;

@property (weak, nonatomic) IBOutlet UITextField *projectIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *projectDescTextField;

@property (weak, nonatomic) IBOutlet UIButton *startDateFindButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateFindButton;
@property (weak, nonatomic) IBOutlet UIButton *startDateClosedButton;
@property (weak, nonatomic) IBOutlet UIButton *endDateClosedButton;

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@property (weak, nonatomic) IBOutlet UIButton *problemTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *searchRangeButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;

@property (nonatomic, strong) ZHLZDatePickerVC *startDateFindDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDateFindDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *startDateClosedDatePickerVC;
@property (nonatomic, strong) ZHLZDatePickerVC *endDateClosedDatePickerVC;

@property (nonatomic, strong) ZHLZListPickerViewVC *problemTypeListPickerViewVC;
@property (nonatomic, strong) ZHLZPickerViewVC *searchRangePickerViewVC;

@end

@implementation ZHLZHomeOccupyProblemSearchVC

- (void)viewDidLoad {
    @weakify(self);
    [super viewDidLoad];
    
    self.maskView.hidden = YES;
    self.filterTopView.hidden = YES;
    self.filterScrollView.hidden = YES;
    self.filterBottomView.hidden = YES;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hideFilterView)]];
    
    self.startDateFindDatePickerVC = [ZHLZDatePickerVC new];
    self.startDateFindDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_startDateFind = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.startDateFindButton.selected = YES;
            [self.startDateFindButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.endDateFindDatePickerVC = [ZHLZDatePickerVC new];
    self.endDateFindDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_endDateFind = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.endDateFindButton.selected = YES;
            [self.endDateFindButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.startDateClosedDatePickerVC = [ZHLZDatePickerVC new];
    self.startDateClosedDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_startDateClosed = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.startDateClosedButton.selected = YES;
            [self.startDateClosedButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.endDateClosedDatePickerVC = [ZHLZDatePickerVC new];
    self.endDateClosedDatePickerVC.selectDatePickerBlock = ^(NSString * _Nonnull date) {
        @strongify(self);
        self->_endDateClosed = date;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.endDateClosedButton.selected = YES;
            [self.endDateClosedButton setTitle:date forState:UIControlStateSelected];
        });
    };
    
    self.problemTypeListPickerViewVC = [ZHLZListPickerViewVC new];
    self.problemTypeListPickerViewVC.type = 7;
    self.problemTypeListPickerViewVC.selectPickerBlock = ^(NSString * _Nonnull code, NSString * _Nonnull name) {
        @strongify(self);
        self->_problemType = code;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.problemTypeButton.selected = YES;
            [self.problemTypeButton setTitle:name forState:UIControlStateSelected];
        });
    };
    
    self.searchRangePickerViewVC = [ZHLZPickerViewVC new];
    NSArray *searchRangeArray = @[@"500", @"1000", @"1500", @"2000"];
    self.searchRangePickerViewVC.titleArray = @[@"500米", @"1000米", @"1500米", @"2000米"];
    self.searchRangePickerViewVC.selectPickerBlock = ^(NSInteger index, NSString * _Nonnull name) {
        @strongify(self);
        self->_searchRange = searchRangeArray[index];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchRangeButton.selected = YES;
            [self.searchRangeButton setTitle:name forState:UIControlStateSelected];
        });
    };
}

#pragma mark - Action

- (IBAction)startDateAction {
    [self presentViewController:self.startDateFindDatePickerVC animated:NO completion:nil];
}

- (IBAction)endDateFindAction {
    [self presentViewController:self.endDateFindDatePickerVC animated:NO completion:nil];
}

- (IBAction)startDateClosedAction {
    [self presentViewController:self.startDateClosedDatePickerVC animated:NO completion:nil];
}

- (IBAction)endDateClosedAction {
    [self presentViewController:self.endDateClosedDatePickerVC animated:NO completion:nil];
}

- (IBAction)problemTypeAction {
    [self presentViewController:self.problemTypeListPickerViewVC animated:NO completion:nil];
}

- (IBAction)searchRangeAction {
    [self presentViewController:self.searchRangePickerViewVC animated:NO completion:nil];
}

- (IBAction)resetAction {
    self.projectIdTextField.text = @"";
    self.projectNameTextField.text = @"";
    self.projectDescTextField.text = @"";
    self.locationTextField.text = @"";
    
    _startDateFind = nil;
    self.startDateFindButton.selected = NO;
    _endDateFind = nil;
    self.endDateFindButton.selected = NO;
    _startDateClosed = nil;
    self.startDateClosedButton.selected = NO;
    _endDateClosed = nil;
    self.endDateClosedButton.selected = NO;
    _problemType = nil;
    self.problemTypeButton.selected = NO;
    _searchRange = nil;
    self.searchRangeButton.selected = NO;
}

- (IBAction)determineAction {
    ZHLZHomeOccupyProblemSearchModel *model = [ZHLZHomeOccupyProblemSearchModel new];
    model.projectid = self.projectIdTextField.text;
    model.projectname = self.projectNameTextField.text;
    model.prodescription = self.projectDescTextField.text;
    model.position = self.locationTextField.text;
    model.protype = _problemType;
    model.rangeleg = _searchRange;
    model.startDate = _startDateFind;
    model.endDate = _endDateFind;
    model.cstartdate = _startDateClosed;
    model.cenddate = _endDateClosed;
    
    if (self.selectSearchBlock) {
        self.selectSearchBlock(model);
    }
    [self hideFilterView];
}

#pragma mark - Public

- (void)showFilterView {
    self.maskView.hidden = NO;
    
    [self filterAnimation:NO];
}

- (void)hideFilterView {
    [self filterAnimation:YES];
    
    [self performSelector:@selector(hideMaskView) withObject:nil afterDelay:PopAnimationDurationConst];
}

#pragma mark - Private

- (void)filterAnimation:(BOOL)isHidden {
    self.filterTopView.hidden = isHidden;
    self.filterScrollView.hidden = isHidden;
    self.filterBottomView.hidden = isHidden;
    
    CATransition *animation = [CATransition animation];
    // 设置动画的类型
    animation.type = kCATransitionPush;
    // 设置动画的方向
    animation.subtype = isHidden ? kCATransitionFromLeft : kCATransitionFromRight;
    animation.duration = PopAnimationDurationConst;
    [self.filterTopView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterScrollView.layer addAnimation:animation forKey:@"pushAnimation"];
    [self.filterBottomView.layer addAnimation:animation forKey:@"pushAnimation"];
}

- (void)hideMaskView {
    self.maskView.hidden = YES;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
