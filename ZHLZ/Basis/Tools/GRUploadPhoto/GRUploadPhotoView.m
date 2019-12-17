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
#import "ZHLZUploadVM.h"

// 图片宽度(px)
static CGFloat const ImageWidth = 800.f;

// 列个数
static NSInteger const ColumnCount = 3;

static NSString * const Cell = @"GRUploadPhotoCell";

@interface GRUploadPhotoView () <TZImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIViewController *_vc;
    NSMutableArray<NSDictionary *> *_photosArray;
    NSMutableArray *_photoURLArray;
    
    NSMutableArray<UIImage *> *_hasExistPhotos;
    NSMutableArray<UIImage *> *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    NSInteger _maxPhotosCount;
    NSInteger _hasExistPhotosCount;
    NSInteger _selectPhotosCount;
    
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

- (instancetype)initWithParentView:(UIView *)parentView withViewController:(UIViewController *)vc withMaxImagesCount:(NSInteger)maxImagesCount withImgURL:(nonnull NSString *)imgURL {
    self = [super init];
    if (self) {
        _vc = vc;
                    
        _photosArray = @[].mutableCopy;
        _photoURLArray = @[].mutableCopy;
        if ([imgURL isNotBlank]) {
            _photoURLArray = [imgURL componentsSeparatedByString:@","].mutableCopy;
        }
        
        _maxPhotosCount = maxImagesCount;
        // 已存在的图片张数
        _hasExistPhotosCount = _photoURLArray.count;
        // 可选择的图片张数
        _selectPhotosCount = _maxPhotosCount - _hasExistPhotosCount;
        
        // 已存在的图片
        _hasExistPhotos = @[].mutableCopy;
        // 可选择的图片
        _selectedPhotos = @[].mutableCopy;
        
        _selectedAssets = @[].mutableCopy;
        
        for (NSString *photoURL in _photoURLArray) {
            [self downloadAction:photoURL];
        }
        
        _width = kScreenWidth - CGRectGetMinX(parentView.frame) * 2;
        
        _itemWH = (_width - (ColumnCount - 1) * ItemMargin) / ColumnCount;
        
        [self initCollectionView];
        
        _fullScreenPreviewImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _fullScreenPreviewImageView.backgroundColor = kHexRGBAlpha(0x000000, 0.75);
        _fullScreenPreviewImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullScreenPreviewImageView.autoresizesSubviews = YES;
        _fullScreenPreviewImageView.userInteractionEnabled = YES;
        [_fullScreenPreviewImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)]];
        
        if (_hasExistPhotosCount == 0) {
            [self showImage];
        }
    }
    return self;
}

- (void)downloadAction:(NSString *)photoURL {
    @weakify(self);
    NSString *url = [BaseAPIURLConst stringByAppendingString:photoURL];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        @strongify(self);
        if (error) {
            [self->_photosArray addObject:@{url: [UIImage imageNamed:@"icon_empty"]}];
        } else {
            [self->_photosArray addObject:@{url: image}];
        }
        if (self->_photosArray.count == self->_hasExistPhotosCount) {
            [self allDownloaderCompleted];
        }
    }];
}

- (void)allDownloaderCompleted {
    for (NSString *url in self->_photoURLArray) {
        for (NSDictionary *dic in self->_photosArray) {
            if ([[BaseAPIURLConst stringByAppendingString:url] isEqualToString:[dic.allKeys firstObject]]) {
                id value = [dic.allValues firstObject];
                if ([value isKindOfClass:[UIImage class]]) {
                    [_hasExistPhotos addObject:(UIImage *)value];
                }
                break;
            }
        }
    }

    [self showImage];
    
    [self->_photosArray removeAllObjects];
}

#pragma mark - init

- (void)changeViewHeight {
    NSInteger photosCount = (_hasExistPhotosCount + _selectedPhotos.count);
    NSInteger row = 0;
    if (self.optionType == 2) {
        row = photosCount / ColumnCount + (photosCount % ColumnCount > 0 ? 1 : 0);
    } else {
        row = photosCount == _maxPhotosCount ? (photosCount / ColumnCount) : (photosCount / ColumnCount + 1);
    }
    
    _height = _itemWH * row + ItemMargin * (row - 1);
    self.frame = CGRectMake(0, 0, _width, _height);
    _collectionView.frame = CGRectMake(0, 0, _width, _height);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_collectionView reloadData];
    });
}

- (void)initCollectionView {
    _layout = [[GRUploadPhotoGridViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = ItemMargin;
    _layout.minimumLineSpacing = ItemMargin;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = UIColor.clearColor;
    _collectionView.contentInset = UIEdgeInsetsZero;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
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
        TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:_selectPhotosCount delegate:self];
        imagePickerController.photoWidth = ImageWidth;
        imagePickerController.photoPreviewMaxWidth = ImageWidth;
        imagePickerController.allowPickingVideo = NO;
        imagePickerController.allowTakeVideo = NO;
        imagePickerController.allowTakePicture = NO;
        imagePickerController.allowCameraLocation = NO;
        
        if (_selectPhotosCount > 1) {
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
        imagePickerController.showSelectedIndex = _selectPhotosCount > 1;
        
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
    [self changeViewHeight];
    
    NSMutableArray<NSString *> *imgExtArray = @[].mutableCopy;
    if (_selectedPhotos && _selectedPhotos.count > 0) {
        if ([self.delegate respondsToSelector:@selector(selectedWithPhotoArray:withImgExtArray:withParentView:)]) {
            for (UIImage *image in _selectedPhotos) {
                NSString *imgExt = [self imageExtWithImage:image];
                if (imgExt && [imgExt isNotBlank]) {
                    [imgExtArray addObject:imgExt];
                }
            }
            [self.delegate selectedWithPhotoArray:_selectedPhotos withImgExtArray:imgExtArray withParentView:self];
        }
    } else {
        [self.delegate selectedWithPhotoArray:_selectedPhotos withImgExtArray:imgExtArray withParentView:self];
    }
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
    if (_hasExistPhotosCount > row) {
        if (_hasExistPhotos.count > row) {
            _fullScreenPreviewImageView.image = _hasExistPhotos[row];
        } else {
            [GRToast makeText:@"当前图片正在加载中..."];
            return;
        }
    } else {
        _fullScreenPreviewImageView.image = _selectedPhotos[row - _hasExistPhotosCount];
    }
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
    if (self.optionType == 2) {
        return _hasExistPhotosCount;
    }
    if (_hasExistPhotosCount + _selectedPhotos.count >= _maxPhotosCount) {
        return _maxPhotosCount;
    }
    return _hasExistPhotosCount + _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GRUploadPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell forIndexPath:indexPath];
    
    cell.deleteBtn.hidden = YES;
    if (indexPath.item == _hasExistPhotosCount + _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"icon_upload_pics"];
    } else if (indexPath.item < _hasExistPhotosCount) {
        if (indexPath.item < _hasExistPhotos.count) {
            cell.imageView.image = _hasExistPhotos[indexPath.item];
            cell.deleteBtn.hidden = self.optionType == 2;
        }
    } else {
        NSInteger index = indexPath.item - _hasExistPhotosCount;
        cell.imageView.image = _selectedPhotos[index];
        cell.asset = _selectedAssets[index];
        cell.deleteBtn.hidden = NO;
    }
    [cell changeBorder];
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _hasExistPhotosCount + _selectedPhotos.count) {
        [self uploadPhotoAction];
    } else {
        [self previewPhotoAction:indexPath.item];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedPhotos addObject:image];
    [_selectedAssets addObject:asset];
    
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
    if (sender.tag < _hasExistPhotosCount) {
        @weakify(self);
        NSString *imageURL = _photoURLArray[sender.tag];
        if (![imageURL isNotBlank]) {
            return;
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要删除当前图片？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAlertAction = [UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            [[ZHLZUploadVM sharedInstance] deleteImageWithImageUrl:imageURL withBlock:^{
                @strongify(self);
                [self->_hasExistPhotos removeObjectAtIndex:sender.tag];
                [self->_photoURLArray removeObjectAtIndex:sender.tag];
                
                self->_hasExistPhotosCount--;
                self->_selectPhotosCount = self->_maxPhotosCount - self->_hasExistPhotosCount;

                [self showImage];
            }];
        }];
        [alertController addAction:okAlertAction];
        UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAlertAction];
        [_vc presentViewController:alertController animated:NO completion:nil];
        
        // 删除已有图片回调
//        if (self.delegateDataBlock) {
//            NSString *imgURL = @"";
//            for (NSString *url in _photoURLArray) {
//                imgURL = [imgURL stringByAppendingString:[NSString stringWithFormat:@"%@,", url]];
//            }
//            imgURL = [imgURL substringToIndex:(imgURL.length - 1)];
//            self.delegateDataBlock(imgURL);
//        }
    } else {
        NSInteger index = ((sender.tag + 1) - _hasExistPhotosCount) - 1;
        
        if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _maxPhotosCount) {
            [_selectedPhotos removeObjectAtIndex:index];
            [_selectedAssets removeObjectAtIndex:index];
            
            [self showImage];
            return;
        }
        
        [_selectedPhotos removeObjectAtIndex:index];
        [_selectedAssets removeObjectAtIndex:index];
        
        [self showImage];
    }
}

@end
