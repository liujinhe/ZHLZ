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
@property (weak, nonatomic) IBOutlet UIView *addressListBgView;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@end

@implementation ZHLZBookListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.addressListBgView.layer.cornerRadius = 10.0f;
    
}

- (void)setList:(MonadModelList *)list {
    if (!list) {
        return;
    }
    if ([list.name isNotBlank]) {
        self.addressNameLabel.text = list.name;
    }
    
    if ([list.charger isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",list.charger,list.phone];
    }
    
}

- (IBAction)callPhoneAction:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", @""]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
