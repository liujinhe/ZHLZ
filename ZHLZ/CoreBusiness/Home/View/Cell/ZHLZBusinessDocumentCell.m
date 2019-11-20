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

@end

@implementation ZHLZBusinessDocumentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setHomeBusinessDocumentModel:(ZHLZHomeBusinessDocumentModel *)homeBusinessDocumentModel{
    if (!homeBusinessDocumentModel) {
           return;
       }
       
       self.fileNameLabel.text = homeBusinessDocumentModel.fileName;
       self.fileSizeLabel.text = [NSString stringWithFormat:@"%@ KB",homeBusinessDocumentModel.fileSize];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
