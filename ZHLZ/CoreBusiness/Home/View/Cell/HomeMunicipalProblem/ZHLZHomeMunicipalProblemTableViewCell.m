//
//  ZHLZHomeMunicipalProblemTableViewCell.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMunicipalProblemTableViewCell.h"

@interface ZHLZHomeMunicipalProblemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *openOrCloseButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ZHLZHomeMunicipalProblemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHomeMunicipalProblemModel:(ZHLZHomeMunicipalProblemModel *)homeMunicipalProblemModel {
    _homeMunicipalProblemModel = homeMunicipalProblemModel;
        
    self.numLabel.text = _homeMunicipalProblemModel.objectID?:@"";
    self.openOrCloseButton.selected = !(_homeMunicipalProblemModel.problemStatus && _homeMunicipalProblemModel.problemStatus.integerValue == 2);
    self.openOrCloseButton.layer.borderColor = self.openOrCloseButton.isSelected ? UIColor.yellowColor.CGColor : UIColor.greenColor.CGColor;
    self.resultLabel.text = _homeMunicipalProblemModel.problemDet?:@"";
    self.addressLabel.text = _homeMunicipalProblemModel.siteDet?:@"";
}

@end
