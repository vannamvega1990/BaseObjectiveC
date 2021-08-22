//
//  DetailNotificationOtherViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/15/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailNotificationOtherViewController : BaseViewController<UIScrollViewDelegate,WKNavigationDelegate>

@property NSDictionary *dictNotification;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageNotification;

@end

NS_ASSUME_NONNULL_END
