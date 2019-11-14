//
//  ZHLZBookListCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBookListCell.h"
@interface ZHLZBookListCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentNameLabel;
@end

@implementation ZHLZBookListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.addressNameLabel.text = @"深圳市福田区北环大道2001段";
    self.contentNameLabel.text = @"李锦辉  13691781589";
}
- (IBAction)callPhoneAction:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
