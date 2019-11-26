//
//  ZHLZChooseStepCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZChooseStepCell.h"
@interface ZHLZChooseStepCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

@end

@implementation ZHLZChooseStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.chooseButton.userInteractionEnabled = NO;
}

- (void)setChooseChildrenModel:(ZHLZChosseChildrenModel *)chooseChildrenModel {
    if (!chooseChildrenModel) {
        return;
    }
    
    self.nameLabel.text = chooseChildrenModel.name;
    
    if (chooseChildrenModel.isSelect) {
        [self.chooseButton setImage:[UIImage imageNamed:@"icon_choose_selected"] forState:UIControlStateNormal];
    } else {
        [self.chooseButton setImage:[UIImage imageNamed:@"icon_choose_normal"] forState:UIControlStateNormal];
    }
}

- (IBAction)chooseAction:(UIButton *)sender {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
