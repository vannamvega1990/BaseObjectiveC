//
//  TKNTViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RegisterTKNTViewControllerDelegate <NSObject>

- (void)continueTKNT : (NSDictionary *)dictTKNT;

@end

@interface RegisterTKNTViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) id<RegisterTKNTViewControllerDelegate> delegate;
@property NSDictionary *dictGTCN;

@property (weak, nonatomic) IBOutlet UIImageView *imageRadioTKNH;
@property (weak, nonatomic) IBOutlet UIImageView *imageRadioVDT;

@property (weak, nonatomic) IBOutlet UIView *viewTKNH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewTKNH;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKNH;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameNH;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberNH;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProvince;

@property (weak, nonatomic) IBOutlet UIView *viewVDT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewVDT;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameTKVDT;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameVDT;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccNumberVDT;

@end

NS_ASSUME_NONNULL_END
