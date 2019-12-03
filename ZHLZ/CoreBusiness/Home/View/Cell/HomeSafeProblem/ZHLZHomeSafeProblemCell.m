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
    
    self.questionButton.hidden = YES;
    self.questionButton.layer.borderWidth = 1.0f;
    self.questionButton.layer.cornerRadius = 5.0f;
    self.questionButton.layer.borderColor = kHexRGB(0xFF5000).CGColor;
    [self.questionButton setTitleColor:kHexRGB(0xFF5000) forState:UIControlStateNormal];
    
}

- (void)homeSafeProblemCellWithModel:(ZHLZHomeSafeProblemModel *)homeSafeProblemModel andIndex:(NSInteger)index {
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
    
    if ([homeSafeProblemModel.prostatus integerValue] == 1) {
        self.questionButton.hidden = NO;
        [self.questionButton setTitle:@"开启问题" forState:UIControlStateNormal];
        self.questionButton.layer.borderColor = UIColor.greenColor.CGColor;
        [self.questionButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
    } else {
        self.questionButton.hidden = NO;
        [self.questionButton setTitle:@"关闭问题" forState:UIControlStateNormal];
        self.questionButton.layer.borderColor = kHexRGB(0xFF5000).CGColor;
        [self.questionButton setTitleColor:kHexRGB(0xFF5000) forState:UIControlStateNormal];
    }
    
    self.questionButton.tag = index;
}


- (IBAction)questionAction:(UIButton *)sender {
    if (self.clickButton) {
        self.clickButton(sender.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
