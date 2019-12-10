//
//  ZHLZHomeCarVideoTableViewCell.m
//  ZHLZ
//
//  Created by liujinhe on 2019/12/10.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCarVideoTableViewCell.h"

@interface ZHLZHomeCarVideoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *carImgButton;
@property (weak, nonatomic) IBOutlet UIButton *brigadeButton;

@end

@implementation ZHLZHomeCarVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDeviceStatusModel:(ZHLZDeviceStatusModel *)deviceStatusModel {
    _deviceStatusModel = deviceStatusModel;
    
    if (_deviceStatusModel && _deviceStatusModel.online == 1) {
        self.userInteractionEnabled = YES;
        self.carImgButton.selected = YES;
        self.brigadeButton.selected = YES;
        [self.brigadeButton setTitle:_deviceStatusModel.brigade?:@"" forState:UIControlStateSelected];
    } else {
        self.userInteractionEnabled = NO;
        self.carImgButton.selected = NO;
        self.brigadeButton.selected = NO;
        [self.brigadeButton setTitle:_deviceStatusModel.brigade?:@"" forState:UIControlStateNormal];
    }
}

@end
