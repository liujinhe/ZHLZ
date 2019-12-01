//
//  GRUploadPhotoCell.m
//  GR
//
//  Created by liujinhe on 2019/10/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRUploadPhotoCell.h"
#import "UIView+Layout.h"
#import <Photos/Photos.h>
#import "TZImagePickerController/TZImagePickerController.h"

@implementation GRUploadPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
        
        self.clipsToBounds = YES;

        CGFloat width = kScreenWidth > 375 ? kScreenWidth * 15 / 375 : 15;
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.imageView.contentMode = UIViewContentModeScaleToFill;
        _deleteBtn.frame = CGRectMake(self.tz_width - width, 0, width, width);
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_upload_pic_close"] forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}

- (void)changeBorder {
    if (_deleteBtn.hidden) {
        self.layer.borderColor = UIColor.clearColor.CGColor;
        self.layer.borderWidth = 0;
        self.layer.cornerRadius = 0;
        self.layer.masksToBounds = 0;
        
        _imageView.frame = self.bounds;
    } else {
        self.layer.borderColor = kHexRGB(0xE4E8F0).CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2.5;
        self.layer.masksToBounds = YES;
        
        _imageView.frame = CGRectMake(5, 5, self.tz_width - 10, self.tz_height - 10);
    }
}

- (UIView *)snapshotView {
    UIView *snapshotView = [[UIView alloc] init];
    
    UIView *cellSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    } else {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}

@end
