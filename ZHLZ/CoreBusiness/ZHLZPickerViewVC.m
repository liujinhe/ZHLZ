//
//  ZHLZPickerViewVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/22.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZPickerViewVC.h"

static NSString * const SelectDefaultValue = @"---请选择---";

@interface ZHLZPickerViewVC () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _currentIndex;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ZHLZPickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.maskView.hidden = YES;
    self.popView.hidden = YES;
    
    _currentIndex = -1;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

#pragma mark - Action

/// 取消
- (IBAction)cancelAction {
    [self dismissViewControllerAnimated:NO completion:nil];
}

/// 确定
- (IBAction)determineAction {
    @weakify(self);
    [self dismissViewControllerAnimated:NO completion:^{
        @strongify(self);
        if (self.selectPickerBlock) {
            NSString *name = (self->_currentIndex > 0) ? self.titleArray[self->_currentIndex] : @"请选择";
            self.selectPickerBlock(self->_currentIndex - 1, name);
        }
    }];
}

#pragma mark - UIPickerViewDataSource

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval = [[UILabel alloc] initWithFrame:CGRectMake(0.f,
                                                           0.f,
                                                           [pickerView rowSizeForComponent:component].width,
                                                           [pickerView rowSizeForComponent:component].height)];
    }
    [retval setTextColor:[UIColor blackColor]];
    [retval setFont:kFont(16)];
    [retval setTextAlignment:NSTextAlignmentCenter];
    [retval setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
    return retval;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.titleArray.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titleArray[row]?:@"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _currentIndex = row;
}

#pragma mark - Getter and Setter

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    
    if (_titleArray && _titleArray.count > 0) {
        _titleArray = [@[SelectDefaultValue] arrayByAddingObjectsFromArray:_titleArray];
        [self.pickerView reloadAllComponents];
    }
}

#pragma mark - Public

- (void)showFilterViewWithVC:(UIViewController *)vc {
    [vc presentViewController:self animated:NO completion:^{
        self.maskView.hidden = NO;
        
        [self filterAnimation:NO];
    }];
}

- (void)hideFilterView {
    [self filterAnimation:YES];
    
    [self performSelector:@selector(hideMaskView) withObject:nil afterDelay:PopAnimationDurationConst];
}

#pragma mark - Private

- (void)filterAnimation:(BOOL)isHidden {
    self.maskView.hidden = isHidden;
    self.popView.hidden = isHidden;
    
    CATransition *animation = [CATransition animation];
    // 设置动画的类型
    animation.type = kCATransitionPush;
    // 设置动画的方向
    animation.subtype = isHidden ? kCATransitionFromBottom : kCATransitionFromTop;
    animation.duration = PopAnimationDurationConst;
    [self.popView.layer addAnimation:animation forKey:@"pushAnimation"];
}

- (void)hideMaskView {
    self.maskView.hidden = YES;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
