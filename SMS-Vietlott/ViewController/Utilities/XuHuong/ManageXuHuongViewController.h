//
//  ManageXuHuongViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/5/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SelectGameViewController.h"
#import "ChonKyQuayDialogViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageXuHuongViewController : BaseViewController<UIScrollViewDelegate,SelectGameViewControllerDelegate,ChonKyQuayDialogViewControllerDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtn;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayViewLine;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
