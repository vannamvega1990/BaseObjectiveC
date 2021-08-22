//
//  PolicyTKTTViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/28/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PolicyTKTTViewController : BaseViewController<UIScrollViewDelegate>

@property NSDictionary *param;
@property NSArray *checkSum;
@property BOOL isDefault;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayViewLine;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *arrayLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageCheckBox1;
@property (weak, nonatomic) IBOutlet MyButton *btnRegister;

@end

NS_ASSUME_NONNULL_END
