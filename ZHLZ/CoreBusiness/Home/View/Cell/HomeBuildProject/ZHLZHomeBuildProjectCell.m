
//
//  ZHLZHomeBuildProjectCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeBuildProjectCell.h"

@interface ZHLZHomeBuildProjectCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectTimeLabel;


@end


@implementation ZHLZHomeBuildProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.cornerRadius = 10.0f;
}

-(void)setHomeBuildProjectModel:(ZHLZHomeBuildProjectModel *)homeBuildProjectModel {
    if (!homeBuildProjectModel) {
        return;
    }
    
    if (homeBuildProjectModel.enddateNew) {
        
        NSRange range = [homeBuildProjectModel.enddateNew rangeOfString:@"至"];//匹配得到的下标
        NSString *endTimeStr = [homeBuildProjectModel.enddateNew substringFromIndex:range.location + 1];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        // 得到当前时间（世界标准时间 UTC/GMT）
        NSDate *nowDate = [NSDate date];
        // 设置系统时区为本地时区
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        // 计算本地时区与 GMT 时区的时间差
        NSInteger interval = [zone secondsFromGMT];
        // 在 GMT 时间基础上追加时间差值，得到本地时间
        nowDate = [nowDate dateByAddingTimeInterval:interval];
        NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
        
        NSDate *startDate = [dateFormatter dateFromString:nowDateString];
        NSDate *endDate = [dateFormatter dateFromString:endTimeStr];
        //利用NSCalendar比较日期的差异
        NSCalendar *calendar = [NSCalendar currentCalendar];

        NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
        //比较的结果是NSDateComponents类对象
        NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
        if (delta.day < 30) {
            self.bgView.backgroundColor  = kHexRGBAlpha(0x03A9F4, 0.3);
        } else {
            self.bgView.backgroundColor = [UIColor whiteColor];
        }
    }

    if ([homeBuildProjectModel.name isNotBlank]) {
        self.projectNameLabel.text = homeBuildProjectModel.name;
    }
    
    if ([homeBuildProjectModel.position isNotBlank]) {
        self.projectPlaceLabel.text = homeBuildProjectModel.position;
    }
    
    self.projectTimeLabel.text = [NSString stringWithFormat:@"%@ %@",homeBuildProjectModel.bidName , homeBuildProjectModel.enddateNew];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
