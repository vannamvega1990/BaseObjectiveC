//
//  UpdatePhoneComfirmOTPViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/13/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdatePhoneComfirmOTPViewController : BaseViewController<UITextFieldDelegate>

@property NSString *phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UIButton *btnResendOTP;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOTP;
@property (weak, nonatomic) IBOutlet UILabel *labelWrongOTP;

@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *textFieldsOutletCollection;

@end

NS_ASSUME_NONNULL_END
