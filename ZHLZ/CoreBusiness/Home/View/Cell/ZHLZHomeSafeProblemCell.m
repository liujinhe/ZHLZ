//
//  ZHLZHomeSafeProblemCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeProblemCell.h"

@interface ZHLZHomeSafeProblemCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *questionButton;

@end

@implementation ZHLZHomeSafeProblemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.questionButton.layer.borderWidth = 1.0f;
    self.questionButton.layer.cornerRadius = 5.0f;
    self.questionButton.layer.borderColor = kHexRGB(0xFF5000).CGColor;
    [self.questionButton setTitle:@"关闭问题" forState:UIControlStateNormal];
    [self.questionButton setTitleColor:kHexRGB(0xFF5000) forState:UIControlStateNormal];
    
}

- (void)setHomeSafeProblemModel:(ZHLZHomeSafeProblemModel *)homeSafeProblemModel{
    if (!homeSafeProblemModel) {
        return;
    }
    
    if ([homeSafeProblemModel.orgName isNotBlank]) {
        self.nameLabel.text = homeSafeProblemModel.orgName;
    }
    if ([homeSafeProblemModel.finddate isNotBlank]) {
        self.timeLabel.text = homeSafeProblemModel.finddate;
    }
    
    if ([homeSafeProblemModel.currentPlace isNotBlank]) {
        self.locationLabel.text = homeSafeProblemModel.currentPlace;
    }
    
}

- (IBAction)questionAction:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
