//
//  WebViewController.m
//  CommonApp
//
//  Created by lipeng on 2016/11/12.
//  Copyright © 2016年 common. All rights reserved.
//

#import "WebViewController.h"
#import "WebKit/WKWebView.h"
#import "WebKit/WKNavigationDelegate.h"

@interface WebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wKWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) NSUInteger loadCount;

@end

@implementation WebViewController

- (void)dealloc {
    [self.wKWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wKWebView = [WKWebView newAutoLayoutView];
    [self.view addSubview:self.wKWebView];
    [self.wKWebView autoPinEdgesToSuperviewEdges];
    
    self.progressView = [UIProgressView newAutoLayoutView];
    [self.view addSubview:self.progressView];
    [self.progressView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.progressView autoSetDimension:ALDimensionHeight toSize:3];
    self.progressView.backgroundColor = COLOR_BG_THEME;
    
    self.wKWebView.navigationDelegate = self;
    [self.wKWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    [self.wKWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // 加载进度
    if (object == self.wKWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat oldprogress = [[change objectForKey:NSKeyValueChangeOldKey] doubleValue];
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        
        //不要让进度条倒着走...有时候goback会出现这种情况
        if (newprogress < oldprogress) {
            return;
        }
        
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 内容返回时
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 防止有些时候进度条走不完就结束了
    self.progressView.hidden = YES;
    [self.progressView setProgress:0 animated:NO];
}
// 失败
- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = YES;
    [self.progressView setProgress:0 animated:NO];
}

@end
