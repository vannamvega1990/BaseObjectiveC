//
//  RegisterViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "RegisterViewController.h"
#import "CallAPI.h"
#import "ConfirmOTPViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.textFieldPhoneNumber becomeFirstResponder];
}

- (IBAction)signUp:(id)sender {
    [self.textFieldPhoneNumber resignFirstResponder];
    [self getOTP:self.textFieldPhoneNumber.text];
    
//    ConfirmOTPViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmOTPViewController"];
//    vc.phoneNumber = self.textFieldPhoneNumber.text;
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:vc animated:YES completion:nil];
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

#pragma mark CallAPI

- (void)getOTP : (NSString *)phoneNumber {
    NSArray *check_sum = @[@"api0001_confirm_phone_number",
                           phoneNumber
                           ];
    
    NSDictionary *dictParam = @{@"mobile":phoneNumber,
                                @"KEY":@"api0001_confirm_phone_number"
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [Utils alertError:@"Thông báo" content:[NSString stringWithFormat:@"Mã OTP đã được gửi đến số điện thoại %@",phoneNumber] viewController:self completion:^{
            ConfirmOTPViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmOTPViewController"];
            vc.phoneNumber = self.textFieldPhoneNumber.text;
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }];
}


@end
