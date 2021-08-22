//
//  Register3TKNTViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RegisterTKNTViewControllerDelegate <NSObject>

- (void)continueTKNT : (NSDictionary *)dictTKNT;

@end

@interface Register3TKNTViewController : UIViewController

@property (weak, nonatomic) id<RegisterTKNTViewControllerDelegate> delegate;
@property NSDictionary *dictGTCN;

@property (weak, nonatomic) IBOutlet UIImageView *imageRadioTKNH;
@property (weak, nonatomic) IBOutlet UIImageView *imageRadioVDT;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateNew;

@end

NS_ASSUME_NONNULL_END
