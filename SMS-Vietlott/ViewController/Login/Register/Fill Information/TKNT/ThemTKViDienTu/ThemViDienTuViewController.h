//
//  ThemViDienTuViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/9/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemViDienTuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKVDT1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameVDT1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberVDT1;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKVDT2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameVDT2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberVDT2;

@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKVDT3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameVDT3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberVDT3;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete2;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete3;

@end

NS_ASSUME_NONNULL_END
