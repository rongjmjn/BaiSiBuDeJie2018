//
//  FRWebViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/15.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRWebViewController.h"
#import <WebKit/WebKit.h>

@interface FRWebViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtnItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goforwardBtnItem;
@property (weak, nonatomic) IBOutlet UIView *contertView;
@property (weak, nonatomic) WKWebView *webView;
@end

@implementation FRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc]init];
    
    [self.contertView addSubview:webView];
    
    //展示网页
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:_url];
    [webView loadRequest:request];
    
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
    // 前进,后退,刷新,进度条
    // KVO监听属性
    // Observer:观察者
    // KeyPath:监听哪个属性
    // options:NSKeyValueObservingOptionNew,监听新值改变
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];

    _webView = webView;
    
}

/**对象即将销毁,移除观察者*/
- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

/**监听属性有新值就会调用此方法*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    _backBtnItem.enabled = _webView.canGoBack;
    _goforwardBtnItem.enabled =  _webView.canGoForward;
    _progressView.progress = _webView.estimatedProgress;
    _progressView.hidden = _webView.estimatedProgress>=1;
    self.navigationItem.title = _webView.title;
}

- (IBAction)back:(UIBarButtonItem *)sender {
    [_webView goBack];
}
- (IBAction)forward:(UIBarButtonItem *)sender {
    [_webView goForward];
}

- (IBAction)refresh:(UIBarButtonItem *)sender {
    [_webView reload];
}

//布局子控件frame
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    //取出webView
    WKWebView *webView = _contertView.subviews[0];
    
    webView.frame = _contertView.bounds;
}


@end
