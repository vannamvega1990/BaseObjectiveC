//
//  ManagePersonalViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/9/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManagePersonalViewController.h"
#import "PersonalViewController.h"
#import "LoginViewController.h"
#import "CallAPI.h"
#import "ListNotificationViewController.h"

@interface ManagePersonalViewController ()

@end

@implementation ManagePersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    if ([Utils isLogin]) {
        [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
        
        UIButton *btnNotification  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnNotification setImage:[[UIImage imageNamed:@"notification.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btnNotification.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [btnNotification addTarget:self action:@selector(onClickbtnNotification:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarBtnNotification = [[UIBarButtonItem alloc] initWithCustomView:btnNotification];

        self.navigationItem.rightBarButtonItems = @[rightBarBtnNotification];
        
        UIButton *btnLeft  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnLeft setImage:[[UIImage imageNamed:@"logo_small.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btnLeft.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [btnLeft addTarget:self action:@selector(changeService:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
        
        self.navigationItem.leftBarButtonItems = @[leftBarBtn];
        
        [self getListNotification];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationReadNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationLoginSuccess object:nil];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PersonalViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PersonalViewController"];
        [self.view addSubview:vc.view];
        [self addChildViewController:vc];
    }else{
        [self.navigationController.navigationBar setHidden:true];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
        LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        vc.isInTabbar = YES;
        [self.view addSubview:vc.view];
        [self addChildViewController:vc];
    }
}

- (void)changeService:(id)sender {
    if ([[VariableStatic sharedInstance].kService  isEqual: kServiceVDI]) {
        [VariableStatic sharedInstance].kService = kServicePublic;
    }else{
        [VariableStatic sharedInstance].kService = kServiceVDI;
    }
//    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultDeviceToken];
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = token;
//
//    [Utils alertError:@"Thông báo" content:token  viewController:nil completion:^{
//
//    }];
}

- (void)onClickbtnNotification:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    ListNotificationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ListNotificationViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark CallAPI

- (void)getListNotification {
    NSArray *check_sum = @[@"API0025_get_list_notify",
                           [VariableStatic sharedInstance].phoneNumber,
                           @"1",
                           @"100"
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0025_get_list_notify",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"page":@"1",
                                @"line_in_page":@"100"
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *arrayNotification = dictData[@"info"];
        int unread = 0;
        for (NSDictionary *dict in arrayNotification) {
            if (![[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
                unread++;
            }
        }
        self.navigationItem.rightBarButtonItems[0].badgeValue = [NSString stringWithFormat:@"%d",unread];
    }];
}


#pragma mark Recive Notification
- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationReadNotification]) {
        [self getListNotification];
    }else if ([notif.name isEqualToString:kNotificationLoginSuccess]) {
        [self settupView];
    }
}

@end
