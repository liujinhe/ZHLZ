//
//  ZHLZRoadMaintenancePickerViewVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/29.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZRoadMaintenancePickerViewVC.h"
#import "ZHLZRoadMaintenancePickerViewModel.h"

@interface ZHLZRoadMaintenancePickerViewVC () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _firstIndex;
    NSInteger _secondIndex;
    NSInteger _thirdIndex;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSArray<ZHLZRoadMaintenancePickerViewModel *> *allArray;

@end

@implementation ZHLZRoadMaintenancePickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"problem_type_content" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.allArray = [NSArray modelArrayWithClass:[ZHLZRoadMaintenancePickerViewModel class] json:json];
    
    [self.pickerView reloadAllComponents];
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
            NSArray *valueArray = @[self.allArray[self->_firstIndex].value,
                                    self.allArray[self->_firstIndex].children[self->_secondIndex].value,
                                    self.allArray[self->_firstIndex].children[self->_secondIndex].children[self->_thirdIndex].value];
            
            NSArray *nameArray = @[self.allArray[self->_firstIndex].name,
                                   self.allArray[self->_firstIndex].children[self->_secondIndex].name,
                                   self.allArray[self->_firstIndex].children[self->_secondIndex].children[self->_thirdIndex].name];
            self.selectPickerBlock(valueArray, nameArray);
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
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 1) {
        return self.allArray[_firstIndex].children.count;
    } else if (component == 2) {
        return self.allArray[_firstIndex].children[_secondIndex].children.count;
    } else {
        return self.allArray.count;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth / 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 1) {
        return self.allArray[_firstIndex].children[row].name?:@"";
    } else if (component == 2) {
        return self.allArray[_firstIndex].children[_secondIndex].children[row].name?:@"";
    } else {
        return self.allArray[row].name?:@"";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 1) {
        _secondIndex = row;
        _thirdIndex = 0;
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    } else if (component == 2) {
        _thirdIndex = row;
    } else {
        _firstIndex = row;
        _secondIndex = 0;
        _thirdIndex = 0;
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    }
}

@end
