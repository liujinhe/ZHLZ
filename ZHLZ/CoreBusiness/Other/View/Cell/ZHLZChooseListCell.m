//
//  ZHLZChooseListCell.m
//  ZHLZ
//
//  Created by apple on 2019/11/25.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZChooseListCell.h"

@interface ZHLZChooseListCell ()
@property (weak, nonatomic) IBOutlet UIView *listView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

@end

@implementation ZHLZChooseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.listView.layer.cornerRadius = 5.0f;
    self.chooseButton.layer.cornerRadius = 5.0f;
    self.chooseButton.layer.borderColor = kHexRGB(0x666666).CGColor;
    self.chooseButton.layer.borderWidth = 1.0f;
    self.chooseButton.userInteractionEnabled = NO;
}

- (void)setMonadList:(MonadModelList *)monadList {
    if (!monadList) {
        return;
    }
    if ([monadList.name isNotBlank]) {
        self.nameLabel.text = monadList.name;
    }

    if ([monadList.charger isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",monadList.charger,monadList.phone];
    }
}

- (void)setSpecialList:(SpecialList *)specialList {
    if (!specialList) {
        return;
    }
    if ([specialList.name isNotBlank]) {
        self.nameLabel.text = specialList.name;
    }

    if ([specialList.charger isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",specialList.charger,specialList.phone];
    }
}

- (void)setCityManagementList:(CityManagementList *)cityManagementList{
    if (!cityManagementList) {
        return;
    }
    if ([cityManagementList.name isNotBlank]) {
        self.nameLabel.text = cityManagementList.name;
    }

    if ([cityManagementList.charger isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",cityManagementList.charger,cityManagementList.phone];
    }
}

- (void)setAreaManagementList:(AreaManagementList *)areaManagementList{
    if (!areaManagementList) {
        return;
    }
    if ([areaManagementList.name isNotBlank]) {
        self.nameLabel.text = areaManagementList.name;
    }

    if ([areaManagementList.charger isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",areaManagementList.charger,areaManagementList.phone];
    }
}

- (void)setConstructionList:(ConstructionList *)constructionList{
    if (!constructionList) {
        return;
    }
    if ([constructionList.name isNotBlank]) {
        self.nameLabel.text = constructionList.name;
    }

    if ([constructionList.changer isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",constructionList.changer,constructionList.phone];
    }
}

- (void)setExamineList:(ExamineList *)examineList{
    if (!examineList) {
        return;
    }
    if ([examineList.name isNotBlank]) {
        self.nameLabel.text = examineList.name;
    }

    if ([examineList.creater isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"创建人  %@",examineList.creater];
    }
}

- (void)setRoadWorkList:(RoadWorkList *)roadWorkList{
    if (!roadWorkList) {
        return;
    }
    if ([roadWorkList.name isNotBlank]) {
        self.nameLabel.text = roadWorkList.name;
    }

    if ([roadWorkList.charger isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",roadWorkList.charger,roadWorkList.phone];
    }
}

- (void)setHomeSafeModel:(ZHLZHomeSafeModel *)homeSafeModel {
    if (!homeSafeModel) {
        return;
    }
    
    if ([homeSafeModel.orgName isNotBlank]) {
        self.nameLabel.text = homeSafeModel.orgName;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
