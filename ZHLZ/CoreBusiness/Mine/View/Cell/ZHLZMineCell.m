//
//  ZHLZMineCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZMineCell.h"

@interface ZHLZMineCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@end

@implementation ZHLZMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setItemNameString:(NSString *)itemNameString{
    if ([itemNameString isNotBlank]) {
        self.nameLable.text = itemNameString;
        
        
    }
}

- (void)setIsRedColor:(BOOL)isRedColor{
    if (isRedColor) {
        self.nameLable.textColor = kHexRGB(0xFF6921);
    } else {
        self.nameLable.textColor = kHexRGB(0x333333);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
