//
//  ZHLZHomeBuildProjectCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectCell.h"

@interface ZHLZHomeBuildProjectCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectTimeLabel;


@end


@implementation ZHLZHomeBuildProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.cornerRadius = 10.0f;
}

-(void)setHomeBuildProjectModel:(ZHLZHomeBuildProjectModel *)homeBuildProjectModel {
    if (!homeBuildProjectModel) {
        return;
    }
    
    
    if ([homeBuildProjectModel.name isNotBlank]) {
        self.projectNameLabel.text = homeBuildProjectModel.name;
    }
    
    if ([homeBuildProjectModel.position isNotBlank]) {
        self.projectPlaceLabel.text = homeBuildProjectModel.position;
    }
    
    self.projectTimeLabel.text = [NSString stringWithFormat:@"%@ %@",homeBuildProjectModel.bidName , homeBuildProjectModel.enddateNew];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
