//
//  RegisterSuccessViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/27/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    kRegisterSuccess = 0,
    kLoginFail = 1,
    kResetPass = 2
} TypeViewRegisterNotification;

@interface RegisterNotificationViewController : UIViewController

@property TypeViewRegisterNotification typeView;
@property NSString *phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end

NS_ASSUME_NONNULL_END
