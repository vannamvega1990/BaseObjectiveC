//
//  ChangePasswordViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/18/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>

@property NSString *userName;
@property NSString *oldPass;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPassworDefault;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPasswordNew;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPasswordConfirm;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;

@end

NS_ASSUME_NONNULL_END
