//
//  ZHLZHomeOccupyProblemTableViewCell.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeOccupyProblemTableViewCell.h"

@interface ZHLZHomeOccupyProblemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *openOrCloseButton;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ZHLZHomeOccupyProblemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 10.f;
    self.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHomeOccupyProblemModel:(ZHLZHomeOccupyProblemModel *)homeOccupyProblemModel {
    _homeOccupyProblemModel = homeOccupyProblemModel;
    
    self.titleLabel.text = _homeOccupyProblemModel.projectname?:@"";
    self.openOrCloseButton.selected = !(_homeOccupyProblemModel.prostatus && [_homeOccupyProblemModel.prostatus integerValue] == 1);
    self.openOrCloseButton.layer.borderColor = self.openOrCloseButton.isSelected ? UIColor.yellowColor.CGColor : UIColor.greenColor.CGColor;
    self.numLabel.text = _homeOccupyProblemModel.proid?:@"";
    self.resultLabel.text = _homeOccupyProblemModel.prodescription?:@"";
    self.addressLabel.text = _homeOccupyProblemModel.position?:@"";
}

@end
