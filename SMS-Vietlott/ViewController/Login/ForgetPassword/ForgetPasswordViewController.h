//
//  ForgetPasswordViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "MyButton.h"
#import "CallAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgetPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldGTCN;
@property (weak, nonatomic) IBOutlet MyButton *btnSignUp;

@end

NS_ASSUME_NONNULL_END
