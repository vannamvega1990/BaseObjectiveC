//
//  TabbarViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabbarViewController : UITabBarController<UITabBarControllerDelegate,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *tabbar;

@end

NS_ASSUME_NONNULL_END
