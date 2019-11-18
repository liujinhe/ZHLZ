//
//  ZHLZHomeBulletinCVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/15.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBulletinCVC.h"

@interface ZHLZHomeBulletinCVC ()
{
    BOOL _isScrolling;
}

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZHLZHomeBulletinCVC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = UIColor.whiteColor;
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.backgroundColor = kThemeColor;
    tagLabel.font = kFont(12);
    tagLabel.text = @"公告";
    tagLabel.textColor = UIColor.whiteColor;
    tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tagLabel];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.width.offset(36);
        make.height.offset(22);
    }];
    
    UIView *titleView = [UIView new];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagLabel.mas_left).offset(20);
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
        make.height.offset(22);
    }];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(titleView.frame), 0, CGRectGetWidth(titleView.frame), CGRectGetHeight(titleView.frame))];
    self.titleLabel.font = kFont(12);
    self.titleLabel.textColor = UIColor.redColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:self.titleLabel];
}

- (void)setBulletin:(NSString *)bulletin {
    _bulletin = bulletin;
    
    self.titleLabel.text = _bulletin?:@"";
    
    [self startAnimation];
}

- (void)startAnimation {
    [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionRepeat animations:^{
        CGRect rect = self.titleLabel.frame;
        rect.origin.x = 0;
        self.titleLabel.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

@end
