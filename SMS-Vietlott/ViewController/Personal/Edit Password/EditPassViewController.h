//
//  EditPassViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/13/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditPassViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldOldPass;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPass;
@property (weak, nonatomic) IBOutlet UITextField *textFieldConfirmPass;

@property (weak, nonatomic) IBOutlet UIButton *btnShowOldPass;
@property (weak, nonatomic) IBOutlet UIButton *btnShowNewPass;
@property (weak, nonatomic) IBOutlet UIButton *btnShowConfirmPass;

@end

NS_ASSUME_NONNULL_END
