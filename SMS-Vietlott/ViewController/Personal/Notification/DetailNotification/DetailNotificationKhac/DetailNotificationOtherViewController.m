//
//  DetailNotificationOtherViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/15/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "DetailNotificationOtherViewController.h"

@interface DetailNotificationOtherViewController ()

@end

@implementation DetailNotificationOtherViewController {
    WKWebView *wkWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fillInfo];
}

- (void)fillInfo {
    self.labelTitle.text = [NSString stringWithFormat:@"%@",self.dictNotification[@"title"]];
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",self.dictNotification[@"img_link"]]];
    [self.imageNotification sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"trung_thuong_645"]];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    theConfiguration.allowsInlineMediaPlayback = YES;
    
    wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.viewContent.frame.size.width, self.viewContent.frame.size.height) configuration:theConfiguration];
    wkWebView.navigationDelegate = self;
    
    [self.viewContent addSubview:wkWebView];
    
    wkWebView.scrollView.delegate = self;
    wkWebView.navigationDelegate = self;
    
    
    UIFont *font = [UIFont systemFontOfSize:17.0];
    NSString *htmlStr = [NSString stringWithFormat:@"%@<style>body{font-family: '%@'; font-size:%fpx;color:#000000;}</style>",self.dictNotification[@"content"],font.fontName,font.pointSize];
    [wkWebView loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (IBAction)changeInfo:(id)sender {
    
}

#pragma mark WKWebView

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"HungNmg bat dau load wkWeb");
    [SVProgressHUD show];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"HungNmg da load xong wkWeb");
    [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"Error wkWeb: %@",error);
    [SVProgressHUD dismiss];
}

@end
