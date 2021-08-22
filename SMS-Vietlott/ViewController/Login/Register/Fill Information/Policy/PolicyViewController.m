//
//  PolicyViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/27/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "PolicyViewController.h"
#import "Utils.h"

@interface PolicyViewController ()

@end

@implementation PolicyViewController {
    BOOL isAgree;
    WKWebView *wkWebView;
    NSTimer *timer;
    int timeProcess;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelTitle.text = self.title;
}

- (void)viewDidAppear:(BOOL)animated {
    [self settupWebView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopTime];
}

- (void)startCallTime{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(showTimeProcess:)
                                               userInfo:nil
                                                repeats:YES];
    }
}

- (void)stopTime{
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
    timeProcess = 0;
}

- (void)showTimeProcess:(NSTimer *)timer{
    timeProcess++;
    NSLog(@"thoi gian xu ly : %d",timeProcess);
    if (timeProcess > 30) {
        [self stopTime];
        [SVProgressHUD dismiss];
    }
}

- (void)settupWebView {
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    theConfiguration.allowsInlineMediaPlayback = YES;
    
    wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.viewWeb.frame.size.width, self.viewWeb.frame.size.height) configuration:theConfiguration];
    wkWebView.navigationDelegate = self;
    
    [self.viewWeb addSubview:wkWebView];
    
    wkWebView.scrollView.delegate = self;
    wkWebView.navigationDelegate = self;
    
    //URL Requst Object
    NSURL *url = [NSURL URLWithString:self.urlPolicy];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the WebView.
    [wkWebView loadRequest:requestObj];
}

- (IBAction)selectCheckBox:(id)sender {
    if (isAgree) {
        isAgree = NO;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_unselect"];
        
        self.btnOK.enabled = NO;
        self.btnOK.backgroundColor = RGB_COLOR(255, 255, 255);
        self.btnOK.borderColor = RGB_COLOR(214, 217, 219);
        [self.btnOK setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
    }else{
        isAgree = YES;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_select"];
        
        self.btnOK.enabled = YES;
        self.btnOK.backgroundColor = RGB_COLOR(235, 13, 30);
        self.btnOK.borderColor = [UIColor clearColor];
        [self.btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)agree:(id)sender {
    [self closeView:nil];
    [self.delegate agreePolicy];
}

- (IBAction)closeView:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark WKWebView

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"HungNmg bat dau load wkWeb");
    [SVProgressHUD show];
    [self startCallTime];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"HungNmg da load xong wkWeb");
    [SVProgressHUD dismiss];
    [self stopTime];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"Error wkWeb: %@",error);
    [SVProgressHUD dismiss];
    [self stopTime];
}

@end
