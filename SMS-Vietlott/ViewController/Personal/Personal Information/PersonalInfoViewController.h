//
//  PersonalInfoViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalInfoViewController : BaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imageRadioCMND;
@property (weak, nonatomic) IBOutlet UIImageView *imageRadioCCCD;
@property (weak, nonatomic) IBOutlet UIImageView *imageGTCN1;
@property (weak, nonatomic) IBOutlet UIImageView *imageGTCN2;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldSoGTCN;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldDoB;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldNoiCap;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldNgayCap;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldAdd;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldDDDT;

@end

NS_ASSUME_NONNULL_END
