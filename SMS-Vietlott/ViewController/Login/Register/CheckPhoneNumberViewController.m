//
//  RegisterViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "CheckPhoneNumberViewController.h"
#import "CallAPI.h"
#import "ConfirmOTPViewController.h"
#import "RegisterNotificationViewController.h"

@interface CheckPhoneNumberViewController ()

@end

@implementation CheckPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultUserName];
    self.textFieldPhoneNumber.text = username;
    [self.textFieldPhoneNumber becomeFirstResponder];
    [self enterPhoneNumber:nil];
}

- (IBAction)signUp:(id)sender {
    [self.textFieldPhoneNumber resignFirstResponder];
    [self getOTP:self.textFieldPhoneNumber.text];
}

- (IBAction)enterPhoneNumber:(id)sender {
    if (self.textFieldPhoneNumber.text.length < 10) {
        self.btnSignUp.enabled = NO;
        self.btnSignUp.backgroundColor = RGB_COLOR(255, 255, 255);
        self.btnSignUp.borderColor = RGB_COLOR(214, 217, 219);
        [self.btnSignUp setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
    }else{
        self.btnSignUp.enabled = YES;
        self.btnSignUp.backgroundColor = RGB_COLOR(235, 13, 30);
        self.btnSignUp.borderColor = [UIColor clearColor];
        [self.btnSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
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

#pragma mark CallAPI

- (void)getOTP : (NSString *)phoneNumber {
    NSArray *check_sum = @[@"api0001_confirm_phone_number",
                           phoneNumber
                           ];
    
    NSDictionary *dictParam = @{@"mobile":phoneNumber,
                                @"KEY":@"api0001_confirm_phone_number"
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                [Utils alertError:@"Thông báo" content:@"Mã OTP đã được gửi thành công, vui lòng kiểm tra tin nhắn SMS" viewController:self completion:^{
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
                    ConfirmOTPViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ConfirmOTPViewController"];
                    vc.phoneNumber = self.textFieldPhoneNumber.text;
                    vc.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:vc animated:YES completion:nil];
                }];
            }else{
                if ([dictData[@"error"]  isEqual:@"0002"]) {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
                    RegisterNotificationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterNotificationViewController"];
                    vc.typeView = kLoginFail;
                    vc.phoneNumber = self.textFieldPhoneNumber.text;
                    vc.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:vc animated:YES completion:nil];
                }else{
                    NSString *mes = [NSString stringWithFormat:@"%@",dictData[@"mes"]];
                    if (mes.length == 0) {
                        mes = @"Hệ thống đang bận vui lòng thử lại sau";
                    }
                    [Utils alertError:@"Thông báo" content:mes viewController:nil completion:^{
                        
                    }];
                }
            }
        }else{
            [Utils alertError:@"Lỗi kết nối" content:@"Đề nghị kiểm tra wifi hoặc kết nối dữ liệu của thiết bị" viewController:nil completion:^{
                
            }];
        }
    }];
}


@end
