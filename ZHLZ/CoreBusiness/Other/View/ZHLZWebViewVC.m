//
//  ZHLZWebViewVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/28.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZWebViewVC.h"
#import <WebKit/WebKit.h>

static NSString * const EstimatedProgress = @"estimatedProgress";

@interface ZHLZWebViewVC () <WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ZHLZWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if ([self.headTitle isNotBlank]) {
        self.title = self.headTitle;
    }
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view insertSubview:self.webView belowSubview:self.progressView];
    
    [self loadData];
}


- (void)dealloc {
    if (self.webView) {
        [self.webView removeObserver:self forKeyPath:EstimatedProgress];
    }
    self.webView = nil;
}

#pragma mark - data

- (void)loadData {
    if ([self.url isNotBlank]) {
        // 路巡小结-新增
        if ([self.url isEqualToString:RoadPatrolSummaryStatisticsAddAPIURLConst]) {
            [self addRightBarButtonItemWithTitle:@"新增" action:@selector(roadPatrolSummaryStatisticsAddAction)];
        } else {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getRequestURL]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:30.0];
        [self.webView loadRequest:request];
    }
}

- (NSURL *)getRequestURL {
    BOOL isExistHTTP = [self.url containsString:@"http://"] || [self.url containsString:@"https://"];
    
    NSString *url = isExistHTTP ? self.url : [NSString stringWithFormat:@"%@%@", BaseAPIURLConst, self.url];
    
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSRange range = [url rangeOfString:@"#"];
    if (range.location != NSNotFound) { // 存在#符号（只允许一个）
        NSString *para = [url substringFromIndex:range.location + range.length];
        para = [self encodingURL:para];
        NSString *path = [url substringToIndex:range.location + range.length];
        url = [path stringByAppendingString:para];
    } else {
        url = [self encodingURL:url];
    }
    
    return [NSURL URLWithString:url];
}

- (NSString *)encodingURL:(NSString *)url {
    return [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:EstimatedProgress]) {
        CGFloat progress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.progressView.alpha = 1.f;
        [self.progressView setProgress:progress animated:YES];
        if (progress >= 1.f) {
            [UIView animateWithDuration:0.25f delay:0.25f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.f;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.f animated:YES];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate

/// 准备加载页面
/// @param webView webView description
/// @param navigation navigation description
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

/// 页面内容开始加载
/// @param webView webView description
/// @param navigation navigation description
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

/// 页面加载完成
/// @param webView webView description
/// @param navigation navigation description
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (!self.headTitle) {
        @weakify(self);
        [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
            @strongify(self);
            if (error) {
                return;
            }
            
            if (title && [title isNotBlank]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.title = [NSString stringWithFormat:@"%@", title];
                });
            }
        }];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}

/// 执行跳转
/// @param webView webView description
/// @param navigationAction navigationAction description
/// @param decisionHandler decisionHandler description
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - getter and setter

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _progressView.tintColor = UIColor.redColor;
        _progressView.trackTintColor = UIColor.whiteColor;
        [self.view addSubview:self.progressView];
    }
    
    return _progressView;
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        configuration.allowsInlineMediaPlayback = YES;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.backgroundColor = kBgColor;
        _webView.navigationDelegate = self;
        _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _webView.opaque = NO;
        [_webView addObserver:self forKeyPath:EstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return _webView;
}

#pragma mark - Action

- (void)roadPatrolSummaryStatisticsAddAction {
    ZHLZWebViewVC *webViewVC = [ZHLZWebViewVC new];
    webViewVC.headTitle = @"新增";
    webViewVC.url = RoadPatrolSummaryStatisticsAddAPIURLConst;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

@end
