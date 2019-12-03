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
    
    self.openOrCloseButton.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)homeMunicipalProblemModel:(ZHLZHomeMunicipalProblemModel *)homeMunicipalProblemModel andWithIndex:(NSInteger)index {
    
    self.numLabel.text = homeMunicipalProblemModel.objectID?:@"";
    self.openOrCloseButton.selected = !(homeMunicipalProblemModel.problemStatus && homeMunicipalProblemModel.problemStatus.integerValue == 2);
    self.openOrCloseButton.layer.borderColor = self.openOrCloseButton.isSelected ? UIColor.yellowColor.CGColor : UIColor.greenColor.CGColor;
    self.resultLabel.text = homeMunicipalProblemModel.problemDet?:@"";
    self.addressLabel.text = homeMunicipalProblemModel.siteDet?:@"";
    
    self.openOrCloseButton.tag = index;
}

- (IBAction)openOrCloseAction:(UIButton *)sender {
    
    if (self.clickButton) {
        self.clickButton(sender.tag);
    }
}


@end
