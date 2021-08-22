//
//  CreateTKNTViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/12/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateTKNTViewController : BaseViewController

@property NSDictionary *dictTKTT;

@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldSoTaiKhoan;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textFieldChuTaiKhoan;

@property (weak, nonatomic) IBOutlet UIImageView *imageCheckBox;

@end

NS_ASSUME_NONNULL_END
