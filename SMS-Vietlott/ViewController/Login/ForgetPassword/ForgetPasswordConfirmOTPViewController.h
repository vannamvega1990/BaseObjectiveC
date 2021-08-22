//
//  ForgetPasswordConfirmOTPViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/17/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForgetPasswordConfirmOTPViewController : UIViewController<UITextFieldDelegate>

@property NSString *idNumber;
@property NSString *phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UIButton *btnResendOTP;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOTP;

@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *textFieldsOutletCollection;

@end

NS_ASSUME_NONNULL_END
