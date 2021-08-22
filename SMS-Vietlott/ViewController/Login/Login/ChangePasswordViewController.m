//
//  ChangePasswordViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/18/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Utils.h"
#import "CallAPI.h"
#import "RSA.h"
#import "SelectBankViewController.h"
#import "AESCrypt.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int status = [[VariableStatic sharedInstance].dictUserInfo[@"tkdt_status"] intValue];
    switch (status) {
        case 4:
            self.textFieldPassworDefault.text = self.oldPass;
            break;
            
        case 5:
            self.labelContent.text = @"Thay đổi mật khẩu";
            break;
            
        case 10:
            self.textFieldPassworDefault.text = self.oldPass;
            self.labelContent.text = @"Vui lòng thay đổi mật khẩu để tiếp tục sử dụng dịch vụ";
            break;
            
        default:
            break;
    }
}

- (IBAction)changePass:(id)sender {
    if ([self checkEnoughInfo]) {
        [self changeFirstPassword];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldPasswordConfirm) {
        [self.textFieldPasswordConfirm resignFirstResponder];
        [self changePass:nil];
        return NO;
    }
    
    return YES;
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)checkEnoughInfo {
    BOOL isOK = YES;
    
    if ([Utils lenghtText:self.textFieldPassworDefault.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập mật khẩu cũ" viewController:self completion:^{
            [self.textFieldPassworDefault becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldPasswordNew.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập mật khẩu mới" viewController:self completion:^{
            [self.textFieldPasswordNew becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldPasswordConfirm.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng xác thực mật khẩu mới" viewController:self completion:^{
            [self.textFieldPasswordConfirm becomeFirstResponder];
        }];
    }else if (![self.textFieldPasswordNew.text isEqualToString:self.textFieldPasswordConfirm.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Xác thực mật khẩu không chính xác" viewController:self completion:^{
            [self.textFieldPasswordConfirm becomeFirstResponder];
        }];
    }
    
    return isOK;
}

#pragma mark CallAPI
- (void)changeFirstPassword {
    //HungNM
    NSString *passwordDefaul = [RSA encryptString:self.textFieldPassworDefault.text publicKey:kPubkey];
    NSString *passwordNew = [RSA encryptString:self.textFieldPasswordNew.text publicKey:kPubkey];
    
    NSArray *check_sum = @[@"api0008_change_password",
                           self.userName,
                           passwordDefaul,
                           passwordNew
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0008_change_password",
                                @"user_name":self.userName,
                                @"old_pass":passwordDefaul,
                                @"new_pass":passwordNew
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSString *content;
        
        int status = [[VariableStatic sharedInstance].dictUserInfo[@"tkdt_status"] intValue];
        switch (status) {
            case 4:
                content = @"Kích hoạt tài khoản dự thưởng thành công!";
                [VariableStatic sharedInstance].isFirstLogin = YES;
                break;
                
            case 10:
                content = @"Thay đổi mật khẩu thành công";
                break;
                
            default:
                content = @"";
                break;
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserDefaultIsLogin];
        [[NSUserDefaults standardUserDefaults] setValue:self.userName forKey:kUserDefaultUserName];
        [[NSUserDefaults standardUserDefaults] setValue:[AESCrypt encrypt:self.textFieldPasswordNew.text password:kAES] forKey:kUserDefaultPassword];
        
        [Utils alertError:@"Thông báo" content:content viewController:self completion:^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [[[self appDelegate] window] setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"tabbarController"]];
            [[self appDelegate].window makeKeyAndVisible];
        }];
    }];
}

@end
