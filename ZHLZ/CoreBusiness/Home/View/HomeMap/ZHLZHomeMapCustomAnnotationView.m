//
//  ZHLZHomeMapCustomAnnotationView.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMapCustomAnnotationView.h"
#import "ZHLZHomeMapCustomCalloutView.h"

@interface ZHLZHomeMapCustomAnnotationView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desc1Label;
@property (nonatomic, strong) UILabel *desc2Label;
@property (nonatomic, strong) UILabel *desc3Label;
@property (nonatomic, strong) UILabel *desc4Label;

@end

@implementation ZHLZHomeMapCustomAnnotationView

- (void)setSelected:(BOOL)selected {
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected) {
        return;
    }
    
    if (selected) {
        if (self.calloutView == nil) {
            self.calloutView = [[ZHLZHomeMapCustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 25.f * 2, 231.f)];
            [self.calloutView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailAction)]];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
            self.titleLabel = [UILabel new];
            self.titleLabel.font = kFont(16);
            self.titleLabel.textColor = kThemeColor;
            [self.calloutView addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self.calloutView).offset(15);
                make.right.equalTo(self.calloutView).offset(-15);
                make.height.offset(16);
            }];
            
            UIView *lineView = [UIView new];
            lineView.backgroundColor = UIColor.whiteColor;
            [self.calloutView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
                make.right.equalTo(self.titleLabel.mas_right);
                make.height.offset(1);
            }];
            
            self.desc1Label = [UILabel new];
            self.desc1Label.numberOfLines = 0;
            self.desc1Label.font = kFont(14);
            self.desc1Label.textColor = UIColor.whiteColor;
            [self.calloutView addSubview:self.desc1Label];
            [self.desc1Label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lineView.mas_bottom).offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
                make.right.equalTo(self.titleLabel.mas_right);
            }];
            
            self.desc2Label = [UILabel new];
            self.desc2Label.numberOfLines = 0;
            self.desc2Label.font = kFont(14);
            self.desc2Label.textColor = UIColor.whiteColor;
            [self.calloutView addSubview:self.desc2Label];
            [self.desc2Label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.desc1Label.mas_bottom).offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
                make.right.equalTo(self.titleLabel.mas_right);
                make.height.equalTo(self.desc1Label.mas_height);
            }];
            
            self.desc3Label = [UILabel new];
            self.desc3Label.numberOfLines = 0;
            self.desc3Label.font = kFont(14);
            self.desc3Label.textColor = UIColor.whiteColor;
            [self.calloutView addSubview:self.desc3Label];
            [self.desc3Label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.desc2Label.mas_bottom).offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
                make.right.equalTo(self.titleLabel.mas_right);
                make.height.equalTo(self.desc1Label.mas_height);
            }];
            
            self.desc4Label = [UILabel new];
            self.desc4Label.numberOfLines = 0;
            self.desc4Label.font = kFont(14);
            self.desc4Label.textColor = UIColor.whiteColor;
            [self.calloutView addSubview:self.desc4Label];
            [self.desc4Label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.desc3Label.mas_bottom).offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
                make.right.equalTo(self.titleLabel.mas_right);
                make.bottom.equalTo(self.calloutView).offset(-30);
                make.height.equalTo(self.desc1Label.mas_height);
            }];
            
            if (_homeMapModel) {
                self.titleLabel.text = @"工程信息";
                
                self.desc1Label.text = _homeMapModel.name?:@"";
                self.desc2Label.text = _homeMapModel.builderName?:@"";
                self.desc3Label.text = _homeMapModel.constructorName?:@"";
                self.desc4Label.text = [NSString stringWithFormat:@"许可期限:%@", _homeMapModel.enddateNew?:@""];
            }
            
            if (_homeMapProblemModel) {
                self.titleLabel.text = @"市政设施问题";
                
                self.desc1Label.text = [NSString stringWithFormat:@"所属大队：%@（%@）", _homeMapProblemModel.orgname?:@"", _homeMapProblemModel.areaname?:@""];
                self.desc2Label.text = [NSString stringWithFormat:@"问题类型：%@", _homeMapProblemModel.problemType?:@""];
                self.desc3Label.text = [NSString stringWithFormat:@"地点描述：%@", _homeMapProblemModel.siteDet?:@""];
                self.desc4Label.text = [NSString stringWithFormat:@"问题描述：%@", _homeMapProblemModel.problemDet?:@""];
            }
        }
        [self addSubview:self.calloutView];
    } else {
        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inside = [super pointInside:point withEvent:event];
    if (!inside && self.selected) {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    return inside;
}

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setHomeMapModel:(ZHLZHomeMapModel *)homeMapModel {
    _homeMapModel = homeMapModel;
}

- (void)setHomeMapProblemModel:(ZHLZHomeMapProblemModel *)homeMapProblemModel {
    _homeMapProblemModel = homeMapProblemModel;
}

- (void)detailAction {
    if (_homeMapModel && self.selectHomeMapBlock) {
        self.selectHomeMapBlock(_homeMapModel.objectID);
        return;
    }
    if (_homeMapProblemModel && self.selectHomeMapProblemBlock) {
        self.selectHomeMapProblemBlock(_homeMapProblemModel.objectID);
        return;
    }
}

@end
