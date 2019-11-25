//
//  ZHLZHomeDownloadBusinessDocumentVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/25.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeDownloadBusinessDocumentVC.h"

@interface ZHLZHomeDownloadBusinessDocumentVC ()
{
    NSString *_url;
}

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *documentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startDownloadButton;

@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;

@property (assign, nonatomic) CGFloat progress;

@end

@implementation ZHLZHomeDownloadBusinessDocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePopAction)]];
}

- (void)dealloc {
    [self.downloadTask cancel];
    self.downloadTask = nil;
}

- (void)changeProgress:(float)progress {
    self.progressView.progress = progress;
    self.tipLabel.text = progress > 0 ? [NSString stringWithFormat:@"下载进度%d%%", (int)(100.f * progress)] : @"";
}

- (void)closePopAction {
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)downloadAction:(UIButton *)sender {
    [self changeProgress:0];
    self.startDownloadButton.selected = YES;
    self.startDownloadButton.userInteractionEnabled = NO;
    self.startDownloadButton.backgroundColor = UIColor.lightGrayColor;
    
    [self downloadDoc];
}

- (void)setHomeBusinessDocumentModel:(ZHLZHomeBusinessDocumentModel *)homeBusinessDocumentModel {
    _homeBusinessDocumentModel = homeBusinessDocumentModel;
    
    self.documentNameLabel.text = _homeBusinessDocumentModel.fileName?:@"";
    
    [self changeProgress:0];
    
    [self.startDownloadButton setTitle:@"开始下载" forState:UIControlStateNormal];
}

- (void)setFullPath:(NSString *)fullPath {
    _fullPath = fullPath;
}

- (void)downloadDoc {
    @weakify(self);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[BaseAPIURLConst stringByAppendingString:_homeBusinessDocumentModel.url]]];
    self.downloadTask = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self changeProgress:(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount)];
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 必须携带file://
        return [NSURL fileURLWithPath:self->_fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.startDownloadButton.selected = NO;
            self.startDownloadButton.userInteractionEnabled = YES;
            self.startDownloadButton.backgroundColor = kThemeColor;
            if (error) {
                self.tipLabel.text = @"";
                return;
            }
            [self.startDownloadButton setTitle:@"下载完成" forState:UIControlStateNormal];
        });
        
        if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
            [self dismissViewControllerAnimated:NO completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:OpenDocNotificationConst object:@{@"filePath": filePath}];
            }];
        }
    }];
    [self.downloadTask resume];
}

@end
