//
//  LoginViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "CallAPI.h"
#import "ForgetPasswordViewController.h"
#import "RSA.h"
#import "ChangePasswordViewController.h"
#import "AESCrypt.h"
#import "CommonWebViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.phoneNumber) {
        self.textFieldPhoneNumber.text = self.phoneNumber;
    }else{
        self.textFieldPhoneNumber.text = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultUserName];
    }
    
    self.btnUseUnLogin.hidden = self.isInTabbar;
}

- (IBAction)showPassword:(id)sender {
    if (self.textFieldPassword.secureTextEntry == YES) {
        self.textFieldPassword.secureTextEntry = NO;
        [self.btnShowPassword setImage:[UIImage imageNamed:@"btn_pass_unshow"] forState:UIControlStateNormal];
    }else{
        self.textFieldPassword.secureTextEntry = YES;
        [self.btnShowPassword setImage:[UIImage imageNamed:@"btn_pass_show"] forState:UIControlStateNormal];
    }
}

- (IBAction)forgetPassword:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    ForgetPasswordViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordViewController"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)instruction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    CommonWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonWebViewController"];
    vc.titleView = @"Hướng dẫn sử dụng";
    vc.stringUrl = @"https://policies.google.com/terms?fg=1";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    if ([self checkEnoughInfo]) {
        [self login];
    }
}

- (IBAction)goHome:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[[self appDelegate] window] setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"tabbarController"]];
    [[self appDelegate].window makeKeyAndVisible];
}

- (IBAction)onClickBtnRegister:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    [[[self appDelegate] window] setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"CheckPhoneNumberViewController"]];
    [[self appDelegate].window makeKeyAndVisible];
}

- (IBAction)showFB:(id)sender {
    [Utils showFB];
}

- (IBAction)showYouTobe:(id)sender {
    [Utils showYoutube];
}

- (IBAction)showGroup:(id)sender {
    [Utils showGroup];
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)checkEnoughInfo {
    BOOL isOK = YES;
    
    if ([Utils lenghtText:self.textFieldPhoneNumber.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập số điện thoại" viewController:nil completion:^{
            [self.textFieldPhoneNumber becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldPassword.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập mật khẩu" viewController:nil completion:^{
            [self.textFieldPassword becomeFirstResponder];
        }];
    }
    
    return isOK;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldPassword) {
        [self.textFieldPassword resignFirstResponder];
        [self login:nil];
        return NO;
    }
    
    return YES;
}

#pragma mark CallAPI

- (void)login {
    NSString *password = [RSA encryptString:self.textFieldPassword.text publicKey:kPubkey];
    
    NSArray *check_sum = @[@"api0007_login",
                           self.textFieldPhoneNumber.text,
                           password
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0007_login",
                                @"user_name":self.textFieldPhoneNumber.text,
                                @"password":password
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        
        NSDictionary *dictUserInfo = dictData[@"info"];
        if ([dictUserInfo isKindOfClass:[NSDictionary class]] && dictUserInfo.count > 0) {
            NSString *strStatus = [NSString stringWithFormat:@"%@",dictUserInfo[@"tkdt_status"]];
            int status = [strStatus intValue];
            
            [VariableStatic sharedInstance].isLogin = YES;
            [VariableStatic sharedInstance].accessToken = dictData[@"jwt"];
            [VariableStatic sharedInstance].phoneNumber = self.textFieldPhoneNumber.text;
            [VariableStatic sharedInstance].dictUserInfo = dictData[@"info"];
            
            switch (status) {
                case 4:
                {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
                    ChangePasswordViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                    vc.userName = self.textFieldPhoneNumber.text;
                    vc.oldPass = self.textFieldPassword.text;
                    vc.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:vc animated:YES completion:nil];
                }
                    break;
                    
                case 5:
                {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserDefaultIsLogin];
                    [[NSUserDefaults standardUserDefaults] setValue:self.textFieldPhoneNumber.text forKey:kUserDefaultUserName];
                    [[NSUserDefaults standardUserDefaults] setValue:[AESCrypt encrypt:self.textFieldPassword.text password:kAES] forKey:kUserDefaultPassword];
                    
                    [[[self appDelegate] window] setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"tabbarController"]];
                    [[self appDelegate].window makeKeyAndVisible];
                }
                    break;
                    
                case 6:
                {
                    [Utils alertError:@"Thông báo" content:@"Tài khoản đang bị tạm khóa" viewController:self completion:^{
                        
                    }];
                }
                    break;
                    
                case 10:
                {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
                    ChangePasswordViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                    vc.userName = self.textFieldPhoneNumber.text;
                    vc.oldPass = self.textFieldPassword.text;
                    vc.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:vc animated:YES completion:nil];
                }
                    break;
                    
                default:
                    break;
            }
        }else{
            [Utils alertError:@"Thông báo" content:@"Đã có lỗi bất thường xẩy ra. Vui lòng thử lại sau" viewController:self completion:^{
                
            }];
        }
    }];
}

@end
