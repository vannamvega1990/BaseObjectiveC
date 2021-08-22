//
//  UpdatePhoneNumberViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/13/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdatePhoneNumberViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet MyButton *btnCheckPhoneNumber;
@property (weak, nonatomic) IBOutlet UIView *viewEnterPhoneNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewEnterPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelNotice;

@end

NS_ASSUME_NONNULL_END
