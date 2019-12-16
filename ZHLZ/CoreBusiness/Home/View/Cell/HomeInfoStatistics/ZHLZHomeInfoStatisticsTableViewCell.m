//
//  ZHLZHomeInfoStatisticsTableViewCell.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/29.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeInfoStatisticsTableViewCell.h"

@interface ZHLZHomeInfoStatisticsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *brigadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *queryKilometersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *queryPeopleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *findProblemCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *closedProblemCountLabel;

@end

@implementation ZHLZHomeInfoStatisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHomeInfoStatisticsModel:(ZHLZHomeInfoStatisticsModel *)homeInfoStatisticsModel {
    _homeInfoStatisticsModel = homeInfoStatisticsModel;
    
    self.brigadeLabel.text = _homeInfoStatisticsModel.orgname?:@"";
    self.queryKilometersCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_homeInfoStatisticsModel.mapMileage];
    self.queryPeopleCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_homeInfoStatisticsModel.foundnum];
    self.findProblemCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_homeInfoStatisticsModel.findnum];
    self.closedProblemCountLabel.text = [NSString stringWithFormat:@"%ld", (long)_homeInfoStatisticsModel.closenum];
}

@end
