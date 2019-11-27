//
//  ZHLZHomeSafeCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeSafeCell.h"

@interface ZHLZHomeSafeCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ZHLZHomeSafeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setHomeSafeModel:(ZHLZHomeSafeModel *)homeSafeModel {
    if (!homeSafeModel) {
        return;
    }
    
    
    if ([homeSafeModel.orgName isNotBlank]) {
        self.nameLable.text = homeSafeModel.orgName;
    } else {
        self.nameLable.text = @"";
    }
    if ([homeSafeModel.prodescription isNotBlank]) {
        self.contentLabel.text = homeSafeModel.prodescription;
    } else {
        self.contentLabel.text = @"";
    }
    
    if ([homeSafeModel.currentPlace isNotBlank]) {
        self.locationLabel.text = homeSafeModel.currentPlace;
    } else {
        self.locationLabel.text = @"";
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
