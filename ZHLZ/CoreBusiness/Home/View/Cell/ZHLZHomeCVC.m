//
//  ZHLZHomeCVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/13.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCVC.h"

@interface ZHLZHomeCVC ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation ZHLZHomeCVC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = UIColor.whiteColor;
    
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(24);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-8);
    }];
    
    self.descLabel = [UILabel new];
    self.descLabel.font = kFont(12);
    self.descLabel.textColor = kHexRGB(0x666666);
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
}

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    
    self.imageView.image = [UIImage imageNamed:_imgName];
}

- (void)setDesc:(NSString *)desc {
    _desc = desc;
    
    self.descLabel.text = _desc?:@"";
}

@end
