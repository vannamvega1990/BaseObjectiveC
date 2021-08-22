//
//  EditPassViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/13/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "EditPassViewController.h"
#import "AESCrypt.h"
#import "RSA.h"

@interface EditPassViewController ()

@end

@implementation EditPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)changePass:(id)sender {
    if ([self checkEnoughInfo]) {
        [self changePassword];
    }
}

- (IBAction)showOldPass:(id)sender {
    if (self.textFieldOldPass.secureTextEntry == YES) {
        self.textFieldOldPass.secureTextEntry = NO;
        [self.btnShowOldPass setImage:[UIImage imageNamed:@"btn_pass_unshow"] forState:UIControlStateNormal];
    }else{
        self.textFieldOldPass.secureTextEntry = YES;
        [self.btnShowOldPass setImage:[UIImage imageNamed:@"btn_pass_show"] forState:UIControlStateNormal];
    }
}

- (IBAction)showNewPass:(id)sender {
    if (self.textFieldNewPass.secureTextEntry == YES) {
        self.textFieldNewPass.secureTextEntry = NO;
        [self.btnShowNewPass setImage:[UIImage imageNamed:@"btn_pass_unshow"] forState:UIControlStateNormal];
    }else{
        self.textFieldNewPass.secureTextEntry = YES;
        [self.btnShowNewPass setImage:[UIImage imageNamed:@"btn_pass_show"] forState:UIControlStateNormal];
    }
}

- (IBAction)showConfirmPass:(id)sender {
    if (self.textFieldConfirmPass.secureTextEntry == YES) {
        self.textFieldConfirmPass.secureTextEntry = NO;
        [self.btnShowConfirmPass setImage:[UIImage imageNamed:@"btn_pass_unshow"] forState:UIControlStateNormal];
    }else{
        self.textFieldConfirmPass.secureTextEntry = YES;
        [self.btnShowConfirmPass setImage:[UIImage imageNamed:@"btn_pass_show"] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldConfirmPass) {
        [self.textFieldConfirmPass resignFirstResponder];
        [self changePass:nil];
        return NO;
    }
    
    return YES;
}

- (BOOL)checkEnoughInfo {
    BOOL isOK = YES;
    
    if ([Utils lenghtText:self.textFieldOldPass.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập mật khẩu cũ" viewController:self completion:^{
            [self.textFieldOldPass becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldNewPass.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập mật khẩu mới" viewController:self completion:^{
            [self.textFieldNewPass becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldConfirmPass.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập lại mật khẩu mới" viewController:self completion:^{
            [self.textFieldConfirmPass becomeFirstResponder];
        }];
    }else if (![self.textFieldNewPass.text isEqualToString:self.textFieldConfirmPass.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Xác thực mật khẩu không chính xác" viewController:self completion:^{
            [self.textFieldConfirmPass becomeFirstResponder];
        }];
    }
    
    return isOK;
}

#pragma mark CallAPI
- (void)changePassword {
    NSString *passwordDefaul = [RSA encryptString:self.textFieldOldPass.text publicKey:kPubkey];
    NSString *passwordNew = [RSA encryptString:self.textFieldNewPass.text publicKey:kPubkey];
    
    NSArray *check_sum = @[@"api0008_change_password",
                           [VariableStatic sharedInstance].phoneNumber,
                           passwordDefaul,
                           passwordNew
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0008_change_password",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"old_pass":passwordDefaul,
                                @"new_pass":passwordNew
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSUserDefaults standardUserDefaults] setValue:[AESCrypt encrypt:self.textFieldNewPass.text password:kAES] forKey:kUserDefaultPassword];
        
        [Utils alertError:@"Thông báo" content:@"Thay đổi mật khẩu thành công!" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

@end
