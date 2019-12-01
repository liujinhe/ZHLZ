//
//  GRUploadPhotoView.m
//  GR
//
//  Created by liujinhe on 2019/10/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRUploadPhotoView.h"
#import "GRUploadPhotoCell.h"
#import "GRUploadPhotoGridViewFlowLayout.h"
#import <TZImagePickerController/TZImagePickerController.h>

// 图片宽度(px)
static CGFloat const ImageWidth = 800.f;

// 每个 Item 内间距
static CGFloat const ItemMargin = 20.f;
// 列个数
static NSInteger const ColumnCount = 3;

static NSString * const Cell = @"GRUploadPhotoCell";

@interface GRUploadPhotoView () <TZImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIViewController *_vc;
    NSMutableArray<UIImage *> *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    NSInteger _maxImagesCount;
    
    CGFloat _width;
    CGFloat _height;
    CGFloat _itemWH;
    
    UIImageView *_fullScreenPreviewImageView;
}

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GRUploadPhotoGridViewFlowLayout *layout;
@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation GRUploadPhotoView

#pragma mark - lifecycle

- (instancetype)initWithParentView:(UIView *)parentView withViewController:(UIViewController *)vc withMaxImagesCount:(NSInteger)maxImagesCount {
    self = [super init];
    if (self) {
        _vc = vc;
        
        _maxImagesCount = maxImagesCount;
        
        _selectedPhotos = @[].mutableCopy;
        _selectedAssets = @[].mutableCopy;
        
        _width = kScreenWidth - CGRectGetMinX(parentView.frame) * 2;
        
        _itemWH = (_width - (ColumnCount - 1) * ItemMargin) / ColumnCount;
        
        _height = _itemWH;
        
        [self initCollectionView];
        
        [self changeViewHeight];
        
        _fullScreenPreviewImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _fullScreenPreviewImageView.backgroundColor = UIColor.whiteColor;
        _fullScreenPreviewImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullScreenPreviewImageView.autoresizesSubviews = YES;
        _fullScreenPreviewImageView.userInteractionEnabled = YES;
        [_fullScreenPreviewImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)]];
    }
    return self;
}

#pragma mark - init

- (void)changeViewHeight {
    NSInteger count = _selectedPhotos.count == _maxImagesCount ? (_selectedPhotos.count / ColumnCount) : (_selectedPhotos.count / ColumnCount + 1);
    _height = _itemWH * count + ItemMargin * (count - 1);
    self.frame = CGRectMake(0, 0, _width, _height);
    self.collectionView.frame = CGRectMake(0, 0, _width, _height);
}

- (void)initCollectionView {
    _layout = [[GRUploadPhotoGridViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = ItemMargin;
    _layout.minimumLineSpacing = ItemMargin;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.contentInset = UIEdgeInsetsZero;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_collectionView registerClass:[GRUploadPhotoCell class] forCellWithReuseIdentifier:Cell];
    [self addSubview:_collectionView];
}

/// 相机
- (void)takePhotoAction {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
        { // 无相机权限
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请前往 iPhone 的”设置-隐私-相机”中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAlertAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:okAlertAction];
            [_vc presentViewController:alertController animated:NO completion:nil];
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        { // 防止用户首次拍照拒绝授权时相机页黑屏
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhotoAction];
                    });
                }
            }];
        }
            break;
        default:
        {
            // 拍照之前还需要检查相册权限
            if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
                [self unableAccessAlbum];
            } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
                [[TZImageManager manager] requestAuthorizationWithCompletion:^{
                    [self takePhotoAction];
                }];
            } else {
                __weak typeof(self) weakSelf = self;
                [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    strongSelf.location = [locations firstObject];
                } failureBlock:^(NSError *error) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    strongSelf.location = nil;
                }];
                
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    imagePickerController.delegate = self;
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [_vc presentViewController:imagePickerController animated:YES completion:nil];
                } else {
                    NSLog(@"模拟器中无法打开相机，请在真机中使用");
                }
            }
        }
            break;
    }
}

/// 从相册选择
- (void)imagePickerAction {
    // 拍照之前还需要检查相册权限
    if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [self unableAccessAlbum];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self imagePickerAction];
        }];
    } else {
        TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxImagesCount delegate:self];
        imagePickerController.photoWidth = ImageWidth;
        imagePickerController.photoPreviewMaxWidth = ImageWidth;
        imagePickerController.allowPickingVideo = NO;
        imagePickerController.allowTakeVideo = NO;
        imagePickerController.allowTakePicture = NO;
        imagePickerController.allowCameraLocation = NO;
        
        if (_maxImagesCount > 1) {
            imagePickerController.selectedAssets = _selectedAssets;
            
            imagePickerController.iconThemeColor = kHexRGB(0x0558FF);
            imagePickerController.showPhotoCannotSelectLayer = YES;
            imagePickerController.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
            [imagePickerController setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
                [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }];
        }
        
        // 设置是否可以选择原图
        imagePickerController.allowPickingImage = YES;
        imagePickerController.allowPickingOriginalPhoto = YES;
        
        // 单选模式，maxImagesCount == 1 时，生效
        imagePickerController.showSelectBtn = NO;
        imagePickerController.statusBarStyle = UIStatusBarStyleLightContent;
        
        // 设置是否显示图片序号
        imagePickerController.showSelectedIndex = _maxImagesCount > 1;
        
        [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (photos && photos.count > 0) {
                self->_selectedPhotos = photos.mutableCopy;
                self->_selectedAssets = assets.mutableCopy;
                
                [self showImage];
            }
        }];
        [_vc presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (NSString *)base64WithImage:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData && ![imageData isEqual:[NSNull null]]) {
        return [imageData base64EncodedString];
    } else {
        imageData = UIImagePNGRepresentation(image);
        if (imageData && ![imageData isEqual:[NSNull null]]) {
            return [imageData base64EncodedString];
        }
    }
    
    return nil;
}

- (NSString *)imageExtWithImage:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData && ![imageData isEqual:[NSNull null]]) {
        return @".jpg";
    } else {
        imageData = UIImagePNGRepresentation(image);
        if (imageData && ![imageData isEqual:[NSNull null]]) {
            return @".png";
        }
    }
    
    return nil;
}

- (void)showImage {
    NSMutableArray<NSString *> *photoArray = @[].mutableCopy;
    NSMutableArray<NSString *> *imgExtArray = @[].mutableCopy;
    
    if (_selectedPhotos && _selectedPhotos.count > 0) {
        if ([self.delegate respondsToSelector:@selector(selectedWithPhotoArray:withImgExtArray:withParentView:)]) {
            for (UIImage *image in _selectedPhotos) {
                NSString *img = [self base64WithImage:image];
                NSString *imgExt = [self imageExtWithImage:image];
                if (img && [img isNotBlank] && imgExt && [imgExt isNotBlank]) {
                    [photoArray addObject:img];
                    [imgExtArray addObject:imgExt];
                }
            }
            [self.delegate selectedWithPhotoArray:photoArray withImgExtArray:imgExtArray withParentView:self];
        }
    } else {
        [self.delegate selectedWithPhotoArray:photoArray withImgExtArray:imgExtArray withParentView:self];
    }
    
    [self changeViewHeight];
    
    [_collectionView reloadData];
}

- (void)unableAccessAlbum {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请前往 iPhone 的“设置-隐私-相册”中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAlertAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAlertAction];
    [_vc presentViewController:alertController animated:NO completion:nil];
}

- (void)uploadPhotoAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAlertAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhotoAction];
    }];
    [alertController addAction:takePhotoAlertAction];
    
    UIAlertAction *imagePickerAlertAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickerAction];
    }];
    [alertController addAction:imagePickerAlertAction];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAlertAction];
    
    [_vc presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - preview photo

- (void)previewPhotoAction:(NSInteger)row {
    _fullScreenPreviewImageView.image = _selectedPhotos[row];
    [[UIApplication sharedApplication].keyWindow addSubview:_fullScreenPreviewImageView];
    [self fullScreenPreview:_fullScreenPreviewImageView];
}

- (void)fullScreenPreview:(UIView *)view {
    view.hidden = NO;
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [view.layer addAnimation:animation forKey:nil];
}

- (void)closeAction:(UITapGestureRecognizer *)tap {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [tap.view.layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(removeView) withObject:nil afterDelay:animation.duration - 0.05];
}

- (void)removeView {
    _fullScreenPreviewImageView.hidden = YES;
    [_fullScreenPreviewImageView removeFromSuperview];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count >= _maxImagesCount) {
        return _selectedPhotos.count;
    }
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GRUploadPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell forIndexPath:indexPath];
    if (indexPath.item == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"icon_upload_pics"];
        cell.deleteBtn.hidden = YES;
        [cell changeBorder];
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
        [cell changeBorder];
    }
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.endEditingBlock) {
        self.endEditingBlock();
    }
    if (indexPath.item == _selectedPhotos.count) {
        [self uploadPhotoAction];
    } else {
        [self previewPhotoAction:indexPath.item];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    
    [self showImage];
}

#pragma mark - GRUploadPhotoGridViewDataSource

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [self showImage];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (!image) {
            return;
        }
        
        image = [[TZImageManager manager] scaleImage:image toSize:CGSizeMake(ImageWidth, (image.size.height * ImageWidth) / image.size.width)];
        
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        
        // 保存图片，获取到 Asset
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:self.location completion:^(PHAsset *asset, NSError *error) {
            if (error) {
                NSLog(@"图片保存失败 %@", error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
            }
        }];
    }
}

#pragma mark - click event

- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [_selectedAssets removeObjectAtIndex:sender.tag];
        [self showImage];
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self showImage];
    }];
}

@end
