//
//  UpdatePhoneComfirmOTPViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/13/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "UpdatePhoneComfirmOTPViewController.h"
#import "RSA.h"
#import "AESCrypt.h"

typedef enum {
    left,
    right
} Direction;

@interface UpdatePhoneComfirmOTPViewController ()

@end

@implementation UpdatePhoneComfirmOTPViewController {
    NSTimer *timer;
    int timeProcess;
    int resend;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self startNewTurn];
    resend = 3;
}

- (void)viewDidAppear:(BOOL)animated {
    [self.textFieldOTP becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self stopTime];
}

- (IBAction)resendOTP:(id)sender {
    if (resend >= 1) {
        for (UITextField *textF in self.textFieldsOutletCollection) {
            textF.text = @"";
        }
        resend = resend-1;
        
        [self getOTP];
    }
}

#pragma mark Process Time

- (void)startNewTurn {
    timeProcess = 120;
    self.btnResendOTP.enabled = NO;
    self.btnResendOTP.hidden = YES;
    self.labelTime.hidden = NO;
    [self startCallTime];
}

- (void)startCallTime{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(showTimeProcess:)
                                               userInfo:nil
                                                repeats:YES];
        
    }
}

- (void)stopTime{
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
}

- (void)showTimeProcess:(NSTimer *)timer{
    timeProcess--;
    if (timeProcess <= 0) {
        [self stopTime];
        self.labelTime.hidden = YES;
        
        if (resend >= 1) {
            [self.btnResendOTP setTitle:[NSString stringWithFormat:@"Gửi lại mã (%d)",resend] forState:UIControlStateNormal];
            self.btnResendOTP.enabled = YES;
            self.btnResendOTP.hidden = NO;
        }
    }else{
        self.labelTime.text = [NSString stringWithFormat:@"%d",timeProcess];
    }
}

#pragma mark Auto Fill OTP

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 0) {
        if (string.length > 0) {
            textField.text = string;
            [self setNextResponder:(int)textField.tag :right];
            return YES;
        }
    }else if (range.length == 1){
        textField.text = @"";
        [self setNextResponder:(int)textField.tag :left];
        return NO;
    }
    self.labelWrongOTP.hidden = YES;
    return NO;
}

- (void)setNextResponder : (int)index : (Direction)direction {
    if (direction == left) {
        if (index == 0) {
            [[self getTextFieldWithTag:0] resignFirstResponder];
        }else{
            [[self getTextFieldWithTag:(index-1)] becomeFirstResponder];
        }
    }else{
        if (index == self.textFieldsOutletCollection.count - 1) {
            [[self getTextFieldWithTag:5] resignFirstResponder];
            [self changePhoneNumber];
        }else{
            [[self getTextFieldWithTag:(index+1)] becomeFirstResponder];
        }
    }
}

- (UITextField *)getTextFieldWithTag : (int)tag {
    for (UITextField *tf in self.textFieldsOutletCollection) {
        if (tf.tag == tag) {
            return tf;
        }
    }
    return nil;
}

#pragma mark CallAPI

- (void)changePhoneNumber {
    NSString *otp = @"";
    for (UITextField *textF in self.textFieldsOutletCollection) {
        if (textF.text.length == 0) {
            [textF becomeFirstResponder];
            return;
        }else{
            otp = [otp stringByAppendingString:textF.text];
        }
    }
    
    NSLog(@"%@",otp);
    
    NSArray *check_sum = @[@"api0012_update_phone_number",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.phoneNumber,
                           otp
                           ];
    
    NSDictionary *dictParam = @{
                                @"KEY":@"api0012_update_phone_number",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"new_mobile":self.phoneNumber,
                                @"otp":otp
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [self login];
    }];
}

- (void)getOTP {
    NSArray *check_sum = @[@"api0048_check_phone",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.phoneNumber
                           ];
    
    NSDictionary *dictParam = @{
                                @"KEY":@"api0048_check_phone",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"mobile":self.phoneNumber
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        
        [Utils alertError:@"Thông báo" content:@"Mã OTP đã được gửi thành công, vui lòng kiểm tra tin nhắn SMS" viewController:self completion:^{
            [self startNewTurn];
            [self.textFieldOTP becomeFirstResponder];
        }];
    }];
}

- (void)login {
    NSString *username = self.phoneNumber;
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultPassword];
    password = [AESCrypt decrypt:password password:kAES];
    password = [RSA encryptString:password publicKey:kPubkey];
    
    NSArray *check_sum = @[@"api0007_login",
                           username,
                           password
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0007_login",
                                @"user_name":username,
                                @"password":password
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [VariableStatic sharedInstance].isLogin = YES;
        [VariableStatic sharedInstance].accessToken = dictData[@"jwt"];
        [VariableStatic sharedInstance].dictUserInfo = dictData[@"info"];
        [VariableStatic sharedInstance].phoneNumber = self.phoneNumber;
        [[NSUserDefaults standardUserDefaults] setValue:self.phoneNumber forKey:kUserDefaultUserName];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameEditPhoneNumberSuccess object:nil];
        [Utils alertError:@"Thông báo" content:@"Thay đổi số điện thoại thành công" viewController:self completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }];
}

@end
