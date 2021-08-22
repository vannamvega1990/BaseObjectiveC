//
//  LoginViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property NSString *phoneNumber;
@property BOOL isInTabbar;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnShowPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnUseUnLogin;

@end

NS_ASSUME_NONNULL_END
