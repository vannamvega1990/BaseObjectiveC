//
//  RegisterSuccessViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/27/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "RegisterNotificationViewController.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "LoginViewController.h"

@interface RegisterNotificationViewController ()

@end

@implementation RegisterNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settupView];
}

- (void)settupView {
    switch (self.typeView) {
        case kRegisterSuccess:
        {
            self.labelContent.text = INF0011;
            [self.btn1 setTitle:@"Đăng nhập" forState:UIControlStateNormal];
            [self.btn2 setTitle:@"Tiếp tục sử dụng mà không đăng nhập" forState:UIControlStateNormal];
        }
            break;
            
        case kLoginFail:
        {
            self.labelContent.text = ERR0002;
            [self.btn1 setTitle:[NSString stringWithFormat:@"Đăng nhập bằng SĐT %@",self.phoneNumber] forState:UIControlStateNormal];
            [self.btn2 setTitle:@"Sử dụng SĐT khác để tiếp tục Đăng ký" forState:UIControlStateNormal];
        }
            break;
            
        case kResetPass:
        {
//            self.labelContent.text = [NSString stringWithFormat:@"Quên mật khẩu\nMật khẩu mới của QK đã được gửi đến số điện thoại %@. Vui lòng đăng nhập lại.",self.phoneNumber];
            self.labelContent.text = @"Quên mật khẩu\nMật khẩu mới của QK đã được gửi đến số điện thoại. Vui lòng đăng nhập lại.";
            [self.btn1 setTitle:@"Đăng nhập" forState:UIControlStateNormal];
            [self.btn2 setTitle:@"Tiếp tục sử dụng mà không đăng nhập" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)btn1Click:(id)sender {
    switch (self.typeView) {
        case kRegisterSuccess://Đăng nhập
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            vc.phoneNumber = self.phoneNumber;
            [[self appDelegate].window setRootViewController:vc];
            [[self appDelegate].window makeKeyAndVisible];
        }
            break;
            
        case kLoginFail://Đăng nhập bằng SĐT vừa xác thực
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            vc.phoneNumber = self.phoneNumber;
            [[self appDelegate].window setRootViewController:vc];
            [[self appDelegate].window makeKeyAndVisible];
        }
            break;
            
        case kResetPass://Đăng nhập
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [[self appDelegate].window setRootViewController:vc];
            [[self appDelegate].window makeKeyAndVisible];
        }
            break;
            
        default:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            vc.phoneNumber = self.phoneNumber;
            [[self appDelegate].window setRootViewController:vc];
            [[self appDelegate].window makeKeyAndVisible];
        }
            break;
    }
    
}

- (IBAction)btn2Click:(id)sender {
    switch (self.typeView) {
        case kRegisterSuccess://Tiếp tục sử dụng mà không đăng nhập
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [[[self appDelegate] window] setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"tabbarController"]];
            [[self appDelegate].window makeKeyAndVisible];
        }
            break;
            
        case kLoginFail://Sử dụng số điện thoại khác để đăng ký
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        case kResetPass://Tiếp tục sử dụng mà không đăng nhập
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [[[self appDelegate] window] setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"tabbarController"]];
            [[self appDelegate].window makeKeyAndVisible];
        }
            break;
            
        default:
            break;
    }
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
