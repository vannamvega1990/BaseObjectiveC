//
//  RegisterViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "MyButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet MyButton *btnSignUp;


@end

NS_ASSUME_NONNULL_END
