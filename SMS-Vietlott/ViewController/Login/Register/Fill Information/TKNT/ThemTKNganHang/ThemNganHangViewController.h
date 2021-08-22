//
//  ThemNganHangViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/9/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemNganHangViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKNH1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameNH1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberNH1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProvince1;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKNH2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameNH2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberNH2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProvince2;

@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKNH3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameNH3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberNH3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProvince3;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete2;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete3;

@end

NS_ASSUME_NONNULL_END
