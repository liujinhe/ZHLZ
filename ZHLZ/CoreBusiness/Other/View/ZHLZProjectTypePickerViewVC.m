//
//  ZHLZProjectTypePickerViewVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZProjectTypePickerViewVC.h"
#import "ZHLZOtherVM.h"

@interface ZHLZProjectTypePickerViewVC () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _currentIndex;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSArray<ZHLZProjectTypeModel *> *array;

@end

@implementation ZHLZProjectTypePickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.array && self.array.count > 0) {
        return;
    }
    [self loadData];
}

- (void)initUI {
    self.array = @[].mutableCopy;
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)loadData {
    @weakify(self);
    self.task = [[ZHLZOtherVM sharedInstance] getProjectTypeWithBlock:^(NSArray<ZHLZProjectTypeModel *> * _Nonnull array) {
        @strongify(self);
        self.array = array;
        
        [self.pickerView reloadAllComponents];
    }];
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
        ZHLZProjectTypeModel *model = self.array[self->_currentIndex];
        if (self.selectPickerBlock && model) {
            self.selectPickerBlock(model.code, [model.code isNotBlank] ? model.value : @"请选择");
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
    return self.array.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.array[row].value?:@"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _currentIndex = row;
}

@end
