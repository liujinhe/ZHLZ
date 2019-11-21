//
//  ZHLZPickerViewVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZPickerViewVC.h"

@interface ZHLZPickerViewVC () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _firstIndex;
    NSInteger _secondIndex;
    NSInteger _thirdIndex;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *firstArray;
@property (nonatomic, strong) NSMutableArray *secondArray;
@property (nonatomic, strong) NSMutableArray *thirdArray;

@end

@implementation ZHLZPickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.level = 1;
    
    self.firstArray = @[].mutableCopy;
    self.secondArray = @[].mutableCopy;
    self.thirdArray = @[].mutableCopy;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

#pragma mark - Action

/// 取消
- (IBAction)cancelAction {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
    } else {
        
    }
}

/// 确定
- (IBAction)determineAction {
    if (self.presentingViewController) {
        @weakify(self);
        [self dismissViewControllerAnimated:NO completion:^{
            @strongify(self);
            [self selectAction];
        }];
    } else {
        [self selectAction];
    }
}

/// 选中
- (void)selectAction {
    switch (_level) {
        case 1:
            if (self.selectPickerBlock) {
                self.selectPickerBlock(_firstIndex);
            }
            break;
        case 2:
            if (self.selectSecondPickerBlock) {
                self.selectSecondPickerBlock(_firstIndex, _secondIndex);
            }
            break;
        case 3:
            if (self.selectThirdPickerBlock) {
                self.selectThirdPickerBlock(_firstIndex, _secondIndex, _thirdIndex);
            }
            break;
    }
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
    return self.level;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 1) {
        return self.secondArray.count;
    } else if (component == 2) {
        return self.thirdArray.count;
    } else {
        return self.firstArray.count;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth / self.level;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 1) {
        return self.secondArray[row];
    } else if (component == 2) {
        return self.thirdArray[row];
    } else {
        return self.firstArray[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 1) {
        [self.thirdArray removeAllObjects];
        
        _secondIndex = row;
        
        // 遍历 三级
        
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        _thirdIndex = 0;
    } else if (component == 2) {
        _thirdIndex = row;
    } else {
        [self.secondArray removeAllObjects];
        
        _firstIndex = row;
        
        // 遍历 二级
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        _secondIndex = 0;
    }
}

#pragma mark - Setter And Getter

- (void)setLevel:(NSInteger)level {
    _level = level;
    
    if (_level > 3 || _level <= 0) {
        _level = 1;
    }
}

@end
