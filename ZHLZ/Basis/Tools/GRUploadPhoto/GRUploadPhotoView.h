//
//  GRUploadPhotoView.h
//  GR
//
//  Created by liujinhe on 2019/10/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 每个 Item 内间距
static CGFloat const ItemMargin = 20.f;

@protocol GRUploadPhotoViewDelegate <NSObject>

@optional

- (void)selectedWithPhotoArray:(nullable NSArray<UIImage *> *)photoArray withImgExtArray:(nullable NSArray<NSString *> *)imgExtArray withParentView:(UIView *)parentView;

@end

@interface GRUploadPhotoView : UIView

@property (nonatomic, assign) NSInteger optionType; // 操作类型（1-新增 2-查看 3-编辑）

@property (nonatomic, copy) void (^delegateDataBlock)(NSString *imgURL);

@property (nonatomic, weak, nullable) id<GRUploadPhotoViewDelegate> delegate;

- (instancetype)initWithParentView:(UIView *)parentView
                withViewController:(UIViewController *)vc
                withMaxImagesCount:(NSInteger)maxImagesCount
                        withImgURL:(nonnull NSString *)imgURL;

@end

NS_ASSUME_NONNULL_END
