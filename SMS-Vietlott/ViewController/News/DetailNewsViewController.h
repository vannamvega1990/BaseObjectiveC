//
//  DetailNewsViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailNewsViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, WKNavigationDelegate>

@property NSDictionary *dictNews;

@property (weak, nonatomic) IBOutlet UILabel *labelTitleNews;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeNews;
@property (weak, nonatomic) IBOutlet UIImageView *imageNews;
@property (weak, nonatomic) IBOutlet WKWebView *webview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightWebview;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

NS_ASSUME_NONNULL_END
