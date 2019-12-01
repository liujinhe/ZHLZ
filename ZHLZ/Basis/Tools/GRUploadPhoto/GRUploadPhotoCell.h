//
//  GRUploadPhotoCell.h
//  GR
//
//  Created by liujinhe on 2019/10/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRUploadPhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

- (void)changeBorder;

- (UIView *)snapshotView;

@end

