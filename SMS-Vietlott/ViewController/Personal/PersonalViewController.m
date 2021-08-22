//
//  PersonalViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "PersonalViewController.h"
#import "Utils.h"
#import "AppDelegate.h"
#import "OtherSettingViewController.h"
#import "ManageTKTTViewController.h"
#import "PersonalInfoViewController.h"
#import "ManageTKNTViewController.h"
#import "EditPassViewController.h"
#import "UpdatePhoneNumberViewController.h"
#import "ListNotificationViewController.h"
#import "ManageFavoriteNumbersViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController {
    NSArray *arrayItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    
    [self settupView];
}

- (void)settupView {
    arrayItem = @[@{@"name":@"Thông tin cá nhân",
                    @"image":@"personal_user_change_info",
                    @"id":@"0"
                    },
                  @{@"name":@"Tài khoản nhận thưởng",
                    @"image":@"personal_credit_card",
                    @"id":@"1"
                  },
                  @{@"name":@"Tài khoản thanh toán",
                    @"image":@"personal_credit_card",
                    @"id":@"2"
                  },
                  @{@"name":@"Bộ số yêu thích",
                    @"image":@"personal_head_active",
                    @"id":@"3"
                  },
                  @{@"name":@"Thay đổi mật khẩu",
                    @"image":@"personal_lock",
                    @"id":@"4"
                  },
                  @{@"name":@"Cập nhật số điện thoại",
                    @"image":@"personal_call",
                    @"id":@"5"
                  },
//                  @{@"name":@"Địa điểm dự thưởng",
//                    @"image":@"personal_pin",
//                    @"id":@"6"
//                  },
                  @{@"name":@"Cài đặt khác",
                    @"image":@"personal_setting",
                    @"id":@"7"
                  },];
    
    UIImage *image = [[UIImage imageNamed:@"logo_small.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.btnLeft setImage:image];
    
    UIButton *btnNotification  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnNotification setImage:[[UIImage imageNamed:@"notification.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btnNotification.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [btnNotification addTarget:self action:@selector(onClickbtnNotification:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtnNotification = [[UIBarButtonItem alloc] initWithCustomView:btnNotification];
    
    self.navigationItem.rightBarButtonItems = @[rightBarBtnNotification];
    
    if ([Utils isLogin]) {
        [self fillPersonalInfo];
        [self getListNotification];
    }else{
        self.labelName.text = @"Họ tên: ";
        self.labelPhoneNumber.text = @"Số điện thoại: ";
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameEditPhoneNumberSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationReadNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameUpdatePersonalInfoSuccess object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([VariableStatic sharedInstance].isLogin == NO) {
        [Utils showAlertLogin];
    }
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)chargeHMUT:(id)sender {
    [Utils alertError:@"Thông báo" content:@"Chức năng đang xây dựng" viewController:nil completion:^{
        
    }];
}

- (IBAction)showHistoryChoseNumber:(id)sender {
    if ([VariableStatic sharedInstance].isLogin == NO) {
        [Utils showAlertLogin];
    }else{
        [Utils alertError:@"Thông báo" content:@"Chức năng đang xây dựng" viewController:nil completion:^{
            
        }];
    }
}

- (IBAction)showHistoryPayment:(id)sender {
    if ([VariableStatic sharedInstance].isLogin == NO) {
        [Utils showAlertLogin];
    }else{
        [Utils alertError:@"Thông báo" content:@"Chức năng đang xây dựng" viewController:nil completion:^{
            
        }];
    }
}

- (IBAction)changeService:(id)sender {
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

- (void)showLoginView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    [[self appDelegate].window setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]];
    [[self appDelegate].window makeKeyAndVisible];
}

- (void)fillPersonalInfo {
    @try {
        self.labelName.text = [VariableStatic sharedInstance].dictUserInfo[@"name"];
        self.labelPhoneNumber.text = [NSString stringWithFormat:@"Số điện thoại: %@",[VariableStatic sharedInstance].dictUserInfo[@"mobile"]];
        
        NSString *hmut = [NSString stringWithFormat:@"%@",[VariableStatic sharedInstance].dictUserInfo[@"tkdt_han_muc"]];
        self.labelHMUT.text = [[Utils strCurrency: hmut] stringByAppendingString:@"đ"];
        
        NSString *avatar = [NSString stringWithFormat:@"%@",[VariableStatic sharedInstance].dictUserInfo[@"avatar"]];
        [self.imageAvatar sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
        
        NSString *loyalty = [NSString stringWithFormat:@"%@",[VariableStatic sharedInstance].dictUserInfo[@"loyalty_rank"]];
        loyalty = loyalty.length > 0 ? loyalty : @"Tiêu chuẩn";
        self.labelLevel.text = [NSString stringWithFormat:@"%@",loyalty];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dict = [arrayItem objectAtIndex:indexPath.row];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = dict[@"name"];
    cell.imageView.image = [UIImage imageNamed:dict[@"image"]];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayItem.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([VariableStatic sharedInstance].isLogin == NO) {
        [Utils showAlertLogin];
    }else{
        NSDictionary *dict = [arrayItem objectAtIndex:indexPath.row];
        
        int type = [dict[@"id"] intValue];
        switch (type) {
            case 0:
            {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                PersonalInfoViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"PersonalInfoViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 1:
            {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                ManageTKNTViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"ManageTKNTViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 2:
            {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                ManageTKTTViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"ManageTKTTViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 3:
            {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                ManageFavoriteNumbersViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"ManageFavoriteNumbersViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 4:
            {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                EditPassViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"EditPassViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 5:
            {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                UpdatePhoneNumberViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"UpdatePhoneNumberViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 7:
            {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                OtherSettingViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"OtherSettingViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
            {
                [Utils alertError:@"Thông báo" content:@"Chức năng đang xây dựng" viewController:nil completion:^{
                    
                }];
            }
                break;
        }
    }
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

- (void)getProfile {
    NSArray *check_sum = @[@"api0010_get_profile",
                           [VariableStatic sharedInstance].phoneNumber
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0010_get_profile",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [VariableStatic sharedInstance].dictUserInfo = [Utils converDictRemoveNullValue:dictData[@"info"]];
        [self fillPersonalInfo];
    }];
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameEditPhoneNumberSuccess]) {
        self.labelPhoneNumber.text = [VariableStatic sharedInstance].phoneNumber;
    }else if ([notif.name isEqualToString:kNotificationReadNotification]) {
        [self getListNotification];
    }else if ([notif.name isEqualToString:kNotificationNameUpdatePersonalInfoSuccess]) {
        [self getProfile];
    }
}

@end
