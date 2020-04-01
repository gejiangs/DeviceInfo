//
//  BasicWebViewController.m
//  FenQiBao
//
//  Created by gejiangs on 14/12/11.
//  Copyright (c) 2014年 DaChengSoftware. All rights reserved.
//

#import "BaseWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import <WebKit/WebKit.h>

@interface BaseWebViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate, WKNavigationDelegate, UITabBarDelegate>
{
    UIProgressView *_progressView;
    NJKWebViewProgress *_webViewProgress;
}

@property (nonatomic, strong) UIWebView *dfWebView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (strong, nonatomic) NSURLCache *urlCache;



@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self loadURString:self.urlString];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(UIView *)webView
{
    if (iOS10Later) {
        return self.wkWebView;
    }else{
        return self.dfWebView;
    }
}

-(void)initUI
{
    self.urlCache = [NSURLCache sharedURLCache];
    [self.urlCache setMemoryCapacity:3*1024*1024];
    
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    _progressView = [[UIProgressView alloc] init];
    _progressView.trackTintColor = [UIColor clearColor];
    [_progressView setProgress:0 animated:YES];
    
    if (iOS10Later) {
        [self.wkWebView addSubview:_progressView];
    }else{
        [self.dfWebView addSubview:_progressView];
        self.dfWebView.delegate = _webViewProgress;
    }
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(2);
    }];
}


-(void)loadURString:(NSString *)urlString
{
    _urlString = urlString;
    
    //自动缓存1天
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:60*60*24];
    
    //从请求中获取缓存输出
    NSCachedURLResponse *response = [self.urlCache cachedResponseForRequest:request];
    if (response == nil) {
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60*60*24];
    }
    
    if (iOS10Later) {
        [self.wkWebView loadRequest:request];
    }else{
        [self.dfWebView loadRequest:request];
    }
}

-(void)goBack
{
    if (iOS10Later) {
        [self.wkWebView goBack];
    }else{
        [self.dfWebView goBack];
    }
}

-(void)goForward
{
    if (iOS10Later) {
        [self.wkWebView goForward];
    }else{
        [self.dfWebView goForward];
    }
}

-(void)reload
{
    if (iOS10Later) {
        [self.wkWebView reload];
    }else{
        [self.dfWebView reload];
    }
}


-(UIWebView *)dfWebView
{
    if (_dfWebView != nil) {
        return _dfWebView;
    }
    
    self.dfWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _dfWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _dfWebView.scalesPageToFit = YES;
    _dfWebView.delegate = self;
    
    return _dfWebView;
}

-(WKWebView *)wkWebView
{
    if (_wkWebView != nil) {
        return _wkWebView;
    }
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _wkWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _wkWebView.navigationDelegate = self;
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    return _wkWebView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    NSString *title = [self.dfWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //    self.title = title;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - UITabBar Delegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        [self loadURString:self.urlString];
    }else if (item.tag == 1){
        [self goBack];
    }else if (item.tag == 2){
        [self goForward];
    }else if (item.tag == 3){
        [self reload];
    }
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        [_progressView setProgress:newprogress animated:YES];
        if (newprogress >= 1) {
            [_progressView setProgress:0];
        }
    }
}


-(void)dealloc
{
    if (iOS10Later) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    self.dfWebView = nil;
    self.urlString = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
