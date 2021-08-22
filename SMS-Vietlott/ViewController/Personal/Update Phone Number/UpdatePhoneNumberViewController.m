//
//  UpdatePhoneNumberViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/13/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "UpdatePhoneNumberViewController.h"
#import "UpdatePhoneComfirmOTPViewController.h"

@interface UpdatePhoneNumberViewController ()

@end

@implementation UpdatePhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewDidAppear:(BOOL)animated {
    [self.textFieldPhoneNumber becomeFirstResponder];
}

- (IBAction)signUp:(id)sender {
    [self.textFieldPhoneNumber resignFirstResponder];
    [self checkNewPhoneNumber];
}

- (IBAction)enterPhoneNumber:(id)sender {
    if (self.textFieldPhoneNumber.text.length < 10) {
        self.btnCheckPhoneNumber.enabled = NO;
        self.btnCheckPhoneNumber.backgroundColor = RGB_COLOR(255, 255, 255);
        self.btnCheckPhoneNumber.borderColor = RGB_COLOR(214, 217, 219);
        [self.btnCheckPhoneNumber setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
    }else{
        self.btnCheckPhoneNumber.enabled = YES;
        self.btnCheckPhoneNumber.backgroundColor = RGB_COLOR(235, 13, 30);
        self.btnCheckPhoneNumber.borderColor = [UIColor clearColor];
        [self.btnCheckPhoneNumber setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

#pragma mark CallAPI

- (void)checkNewPhoneNumber {
    NSArray *check_sum = @[@"api0048_check_phone",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.textFieldPhoneNumber.text
                           ];
    
    NSDictionary *dictParam = @{
                                @"KEY":@"api0048_check_phone",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"mobile":self.textFieldPhoneNumber.text
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        
        [Utils alertError:@"Thông báo" content:@"Mã OTP đã được gửi thành công, vui lòng kiểm tra tin nhắn SMS" viewController:self completion:^{
            UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            UpdatePhoneComfirmOTPViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"UpdatePhoneComfirmOTPViewController"];
            vc.phoneNumber = self.textFieldPhoneNumber.text;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
}

@end
