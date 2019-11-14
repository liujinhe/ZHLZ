//
//  ZHLZAddressBookCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZAddressBookCell.h"

@interface ZHLZAddressBookCell()

@property (weak, nonatomic) IBOutlet UILabel *addressBookNameLabel;

@end

@implementation ZHLZAddressBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setAddressBookString:(NSString *)addressBookString{
    if ([addressBookString isNotBlank]) {
        self.addressBookNameLabel.text = addressBookString;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
