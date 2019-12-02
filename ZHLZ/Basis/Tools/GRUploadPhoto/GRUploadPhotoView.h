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

- (void)selectedWithPhotoArray:(NSArray<UIImage *> *)photoArray withImgExtArray:(NSArray<NSString *> *)imgExtArray withParentView:(UIView *)parentView;

@end

@interface GRUploadPhotoView : UIView

@property (nonatomic, assign) NSInteger optionType; // 操作类型（1-新增 2-查看 3-编辑）

@property (nonatomic, copy) dispatch_block_t endEditingBlock;

@property (nonatomic, weak, nullable) id<GRUploadPhotoViewDelegate> delegate;

- (instancetype)initWithParentView:(UIView *)parentView
                withViewController:(UIViewController *)vc
                withMaxImagesCount:(NSInteger)maxImagesCount
                 withPhotoURLArray:(nonnull NSArray *)photoURLArray;

@end

NS_ASSUME_NONNULL_END
