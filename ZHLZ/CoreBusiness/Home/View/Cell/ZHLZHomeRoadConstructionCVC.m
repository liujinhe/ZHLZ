//
//  ZHLZHomeRoadConstructionCVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeRoadConstructionCVC.h"
#import "ZHLZHomeRoadConstructionModel.h"

@interface ZHLZHomeRoadConstructionCVC ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZHLZHomeRoadConstructionCVC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.contentView.layer.cornerRadius = 10.f;
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = kFont(14);
    self.nameLabel.textColor = kHexRGB(0x333333);
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.offset(14);
    }];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = kFont(12);
    self.timeLabel.textColor = kHexRGB(0x333333);
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.nameLabel);
        make.height.offset(12);
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = kFont(12);
    self.titleLabel.textColor = kHexRGB(0x333333);
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.nameLabel);
    }];
    
    UIImageView *positionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_position"]];
    [self.contentView addSubview:positionImageView];
    [positionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.contentView).offset(-20);
        make.width.height.offset(16);
    }];
}

- (void)setHomeRoadConstructionModel:(ZHLZHomeRoadConstructionModel *)homeRoadConstructionModel {
    _homeRoadConstructionModel = homeRoadConstructionModel;
    
    if (_homeRoadConstructionModel) {
        self.nameLabel.text = _homeRoadConstructionModel.orgName?:@"";
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_homeRoadConstructionModel.prodate.time/1000.f];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.timeLabel.text = [dateFormatter stringFromDate:date];
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = 3.f;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_homeRoadConstructionModel.prodescription?:@""];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
        self.titleLabel.attributedText = attributedString;
    }
}

@end
