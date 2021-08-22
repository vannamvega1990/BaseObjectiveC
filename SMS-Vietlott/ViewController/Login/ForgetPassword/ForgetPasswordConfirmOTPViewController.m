//
//  ForgetPasswordConfirmOTPViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/17/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ForgetPasswordConfirmOTPViewController.h"
#import "Utils.h"
#import "CallAPI.h"
#import "RegisterNotificationViewController.h"

typedef enum {
    left,
    right
} Direction;

@interface ForgetPasswordConfirmOTPViewController ()

@end

@implementation ForgetPasswordConfirmOTPViewController {
    NSTimer *timer;
    int timeProcess;
    int resend;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.phoneNumber) {
        self.labelContent.text = [NSString stringWithFormat:@"Nhập OTP đã được gửi tới số điện thoại\n%@",self.phoneNumber];
    }else{
        self.labelContent.text = @"Nhập OTP đã được gửi tới số điện thoại";
    }
    
    [self startNewTurn];
    resend = 3;
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

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Process Time

- (void)startNewTurn {
    timeProcess = 120;
    [self.textFieldOTP becomeFirstResponder];
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
            [self confirmOTP];
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

- (void)confirmOTP {
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
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultDeviceToken];
    
    NSArray *check_sum = @[@"api0043_confirm_otp_to_reset_pass",
                           self.idNumber,
                           otp,
                           deviceToken?deviceToken:@"",
                           @"1"
                           ];

    NSDictionary *dictParam = @{@"KEY":@"api0043_confirm_otp_to_reset_pass",
                                @"id_number":self.idNumber,
                                @"otp": otp,
                                @"device_token":deviceToken?deviceToken:@"",
                                @"device_type":@"1"
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
        RegisterNotificationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterNotificationViewController"];
        vc.typeView = kResetPass;
        vc.phoneNumber = self.phoneNumber;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)getOTP{
    NSArray *check_sum = @[@"api0009_get_otp_to_forgot_pass",
                           self.idNumber
                           ];
    
    NSDictionary *dictParam = @{
                                @"KEY":@"api0009_get_otp_to_forgot_pass",
                                @"id_number":self.idNumber
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [Utils alertError:@"Thông báo" content:@"Mã OTP đã được gửi thành công, vui lòng kiểm tra tin nhắn SMS" viewController:self completion:^{
            [self startNewTurn];
            [self.textFieldOTP becomeFirstResponder];
        }];
    }];
}

@end
