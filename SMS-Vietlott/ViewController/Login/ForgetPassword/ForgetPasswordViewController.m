//
//  ForgetPasswordViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordConfirmOTPViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.textFieldGTCN becomeFirstResponder];
}

- (IBAction)signUp:(id)sender {
    [self.textFieldGTCN resignFirstResponder];
    [self getOTP:self.textFieldGTCN.text];
}

- (IBAction)enterGTCN:(id)sender {
    if (self.textFieldGTCN.text.length < 9) {
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

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark CallAPI

- (void)getOTP : (NSString *)gtcn {
    NSArray *check_sum = @[@"api0009_get_otp_to_forgot_pass",
                           gtcn
                           ];
    
    NSDictionary *dictParam = @{
                                @"KEY":@"api0009_get_otp_to_forgot_pass",
                                @"id_number":gtcn
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [Utils alertError:@"Thông báo" content:@"Mã OTP đã được gửi thành công, vui lòng kiểm tra tin nhắn SMS" viewController:self completion:^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            ForgetPasswordConfirmOTPViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordConfirmOTPViewController"];
            vc.idNumber = self.textFieldGTCN.text;
//            vc.phoneNumber = [NSString stringWithFormat:@"xxxxxx%@",dictData[@"mes"]];
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }];
}

@end
