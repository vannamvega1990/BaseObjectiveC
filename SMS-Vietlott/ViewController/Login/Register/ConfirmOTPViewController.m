//
//  ConfirmOTPViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/23/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ConfirmOTPViewController.h"
#import "ManagerFillInfoViewController.h"
#import "Utils.h"
#import "CallAPI.h"

typedef enum {
    left,
    right
} Direction;

@interface ConfirmOTPViewController ()

@end

@implementation ConfirmOTPViewController {
    NSTimer *timer;
    int timeProcess;
    int resend;
    int wrongOTP;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labelContent.text = [NSString stringWithFormat:@"Nhập OTP vừa được gửi tới số điện thoại\n%@",self.phoneNumber];
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
    wrongOTP = 0;
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
    
    NSArray *check_sum = @[@"api0002_confirm_otp",
                           self.phoneNumber,
                           otp
                           ];

    NSDictionary *dictParam = @{@"KEY":@"api0002_confirm_otp",
                                @"mobile":self.phoneNumber,
                                @"otp": otp
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
                ManagerFillInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ManagerFillInfoViewController"];
                vc.phoneNumber = self.phoneNumber;
                vc.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:vc animated:YES completion:nil];
            }else if ([dictData[@"error"]  isEqual:@"0005"]) {
                self->wrongOTP++;
                if (self->wrongOTP > 3) {
                    [Utils alertError:@"Thông báo" content:@"Nhập mã OTP sai quá 3 lần." viewController:self completion:^{
                        [self goBack:nil];
                    }];
                }else{
                    [Utils alertError:@"Thông báo" content:[NSString stringWithFormat:@"%@",dictData[@"mes"]] viewController:self completion:^{
                        self.labelWrongOTP.hidden = NO;
                        for (UITextField *textF in self.textFieldsOutletCollection) {
                            textF.text = @"";
                        }
                        [self.textFieldOTP becomeFirstResponder];
                    }];
                }
            }else {
                NSString *mes = [NSString stringWithFormat:@"%@",dictData[@"mes"]];
                if (mes.length == 0) {
                    mes = @"Hệ thống đang bận vui lòng thử lại sau";
                }
                [Utils alertError:@"Thông báo" content:mes viewController:self completion:^{
                    self.labelWrongOTP.hidden = NO;
                    for (UITextField *textF in self.textFieldsOutletCollection) {
                        textF.text = @"";
                    }
                    [self.textFieldOTP becomeFirstResponder];
                }];
            }
        }else{
            [Utils alertError:@"Lỗi kết nối" content:@"Đề nghị kiểm tra wifi hoặc kết nối dữ liệu của thiết bị" viewController:self completion:^{
                
            }];
        }
    }];
}

- (void)getOTP{
    NSArray *check_sum = @[@"api0001_confirm_phone_number",
                           self.phoneNumber
                           ];
    
    NSDictionary *dictParam = @{
                                @"KEY":@"api0001_confirm_phone_number",
                                @"mobile":self.phoneNumber
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [Utils alertError:@"Thông báo" content:@"Mã OTP đã được gửi thành công, vui lòng kiểm tra tin nhắn SMS" viewController:self completion:^{
            [self startNewTurn];
            [self.textFieldOTP becomeFirstResponder];
        }];
    }];
}

@end
