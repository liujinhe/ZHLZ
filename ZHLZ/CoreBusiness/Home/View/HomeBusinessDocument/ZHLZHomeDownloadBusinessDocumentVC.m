//
//  ZHLZHomeDownloadBusinessDocumentVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/25.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeDownloadBusinessDocumentVC.h"

@interface ZHLZHomeDownloadBusinessDocumentVC () <NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *documentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startDownloadButton;

@property (strong, nonatomic) NSURLSession *session;
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
    [self.session invalidateAndCancel];
    self.session = nil;
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

- (void)downloadDoc {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[BaseAPIURLConst stringByAppendingString:_homeBusinessDocumentModel.url]]];
    self.downloadTask = [self.session downloadTaskWithRequest:request];
    [self.downloadTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate

/// 写数据调用
/// @param session 会话对象
/// @param downloadTask 下载任务
/// @param bytesWritten 写入的数据大小
/// @param totalBytesWritten 下载的数据总大小
/// @param totalBytesExpectedToWrite 文件总大小
- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self changeProgress:(totalBytesWritten / totalBytesExpectedToWrite)];
    });
}

/// 恢复下载调用
/// @param session 会话对象
/// @param downloadTask 下载任务
/// @param fileOffset 需恢复下载的文件位置
/// @param expectedTotalBytes 文件总大小
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

/// 下载完成调用
/// @param session 会话对象
/// @param downloadTask 下载任务
/// @param location 文件临时存储的路径
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSError *error = nil;
    BOOL isCopySuccess = [[NSFileManager defaultManager] copyItemAtURL:location toURL:[NSURL fileURLWithPath:self->_fullPath] error:&error];
    if (!isCopySuccess || error) {
        NSLog(@"========: %@", error.localizedDescription);
    }
}

/// 请求结束后调用
/// @param session 会话对象
/// @param task 下载任务
/// @param error NSError
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.startDownloadButton.selected = NO;
        self.startDownloadButton.backgroundColor = kThemeColor;
        if (error) {
            self.tipLabel.text = @"下载失败";
            
            self.startDownloadButton.userInteractionEnabled = YES;
            [self.startDownloadButton setTitle:@"重新下载" forState:UIControlStateNormal];
        } else {
            [self.startDownloadButton setTitle:@"下载完成" forState:UIControlStateNormal];
            
            [self dismissViewControllerAnimated:NO completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:OpenDocNotificationConst object:@{@"filePath": self->_fullPath}];
            }];
        }
    });
}

#pragma mark - Action

- (IBAction)downloadAction:(UIButton *)sender {
    [self changeProgress:0];
    self.startDownloadButton.selected = YES;
    self.startDownloadButton.userInteractionEnabled = NO;
    self.startDownloadButton.backgroundColor = UIColor.lightGrayColor;
    
    [self downloadDoc];
}

#pragma mark - Getter and Setter

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
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

@end
