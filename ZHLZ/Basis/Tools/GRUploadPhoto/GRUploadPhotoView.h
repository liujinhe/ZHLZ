//
//  GRUploadPhotoView.h
//  GR
//
//  Created by liujinhe on 2019/10/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GRUploadPhotoViewDelegate <NSObject>

@optional

- (void)selectedWithPhotoArray:(NSArray<NSString *> *)photoArray withImgExtArray:(NSArray<NSString *> *)imgExtArray withParentView:(UIView *)parentView;

@end

@interface GRUploadPhotoView : UIView

@property (nonatomic, copy) dispatch_block_t endEditingBlock;

@property (nonatomic, weak, nullable) id<GRUploadPhotoViewDelegate> delegate;

- (instancetype)initWithParentView:(UIView *)parentView withViewController:(UIViewController *)vc withMaxImagesCount:(NSInteger)maxImagesCount;

@end

NS_ASSUME_NONNULL_END
