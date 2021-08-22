//
//  TabbarViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "TabbarViewController.h"
#import "Utils.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.selectedIndex = 2;
    
    [Utils checkAppVersion];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectTabbarHome object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectTabbarNewNews object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectTabbarActionNews object:nil];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 4) {
        NSLog(@"HungNM 0");
    }else{
        NSLog(@"HungNM");
    }
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectTabbarHome]) {
        self.selectedIndex = 2;
    }else if ([notif.name isEqualToString:kNotificationNameSelectTabbarNewNews] || [notif.name isEqualToString:kNotificationNameSelectTabbarActionNews]) {
        self.selectedIndex = 1;
    }
}


@end
