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

- (void)setMonadList:(MonadModelList *)monadList {
    if (!monadList) {
        return;
    }
    if ([monadList.name isNotBlank]) {
        self.addressNameLabel.text = monadList.name;
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
        self.addressNameLabel.text = specialList.name;
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
        self.addressNameLabel.text = cityManagementList.name;
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
        self.addressNameLabel.text = areaManagementList.name;
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
        self.addressNameLabel.text = constructionList.name;
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
        self.addressNameLabel.text = examineList.name;
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
        self.addressNameLabel.text = roadWorkList.name;
    }
    
    if ([roadWorkList.charger isNotBlank]) {
        self.contentNameLabel.text = [NSString stringWithFormat:@"%@  %@",roadWorkList.charger,roadWorkList.phone];
    }
}


- (void)setSelectIndex:(NSInteger)selectIndex {
    self.callButton.tag = selectIndex;
}


- (IBAction)callPhoneAction:(UIButton *)sender {
    if (self.clickPhoneButton) {
        self.clickPhoneButton(sender.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
