//
//  ZHLZBusinessDocumentCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/20.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBusinessDocumentCell.h"

@interface ZHLZBusinessDocumentCell()

@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fileSizeLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ZHLZBusinessDocumentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHomeBusinessDocumentModel:(ZHLZHomeBusinessDocumentModel *)homeBusinessDocumentModel{
    if (!homeBusinessDocumentModel) {
        return;
    }
    
    self.fileNameLabel.text = homeBusinessDocumentModel.fileName;
    self.fileSizeLabel.text = [NSString stringWithFormat:@"%.2fKB", homeBusinessDocumentModel.fileSize.doubleValue / 1000.f];
}
- (void)setIsHasDownLoad:(BOOL)isHasDownLoad {
    _isHasDownLoad = isHasDownLoad;
    if (_isHasDownLoad) {
        self.descLabel.text = @" / 已下载";
    } else {
        self.descLabel.text = @"";
    }
}

@end
