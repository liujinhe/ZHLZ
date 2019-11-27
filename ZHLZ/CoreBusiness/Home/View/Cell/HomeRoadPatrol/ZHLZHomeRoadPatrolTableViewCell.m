//
//  ZHLZHomeRoadPatrolTableViewCell.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/27.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeRoadPatrolTableViewCell.h"

@interface ZHLZHomeRoadPatrolTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageLabel;
@property (weak, nonatomic) IBOutlet UILabel *closedLoopLabel;
@property (weak, nonatomic) IBOutlet UILabel *findLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation ZHLZHomeRoadPatrolTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHomeRoadPatrolModel:(ZHLZHomeRoadPatrolModel *)homeRoadPatrolModel {
    _homeRoadPatrolModel = homeRoadPatrolModel;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@｜%@", _homeRoadPatrolModel.orgname?:@"", _homeRoadPatrolModel.areaname?:@""];
    self.peopleLabel.text = _homeRoadPatrolModel.foundnum?:@"";
    self.mileageLabel.text = _homeRoadPatrolModel.mapMileage?:@"";
    self.closedLoopLabel.text = _homeRoadPatrolModel.closenum?:@"";
    self.findLabel.text = _homeRoadPatrolModel.findnum?:@"";
    self.timeLabel.text = _homeRoadPatrolModel.createdate?:@"";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 3.f;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_homeRoadPatrolModel.remark?:@""];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    self.remarkLabel.attributedText = attributedString;
}

@end
