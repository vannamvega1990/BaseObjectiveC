//
//  PolicyViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/27/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "MyButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PolicyViewControllerDelegate <NSObject>

- (void)agreePolicy;

@end

@interface PolicyViewController : UIViewController<UIScrollViewDelegate,WKNavigationDelegate>

@property (weak, nonatomic) id<PolicyViewControllerDelegate> delegate;
@property NSString *urlPolicy;
@property NSString *strTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imageCheckBox;
@property (weak, nonatomic) IBOutlet MyButton *btnOK;
@property (weak, nonatomic) IBOutlet UIView *viewWeb;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end

NS_ASSUME_NONNULL_END
