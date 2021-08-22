//
//  SelectTypePaymentViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/23/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectTypePaymentViewController : BaseViewController

@property NSArray *arrayTickets;

@property (weak, nonatomic) IBOutlet UILabel *labelHMUT;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelectHMUT;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelectOther;
@property (weak, nonatomic) IBOutlet UIView *viewOther;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewOther;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalPrice;

@property (weak, nonatomic) IBOutlet UILabel *labelNameOther;
@property (weak, nonatomic) IBOutlet UILabel *labelBenefitOther;
@property (weak, nonatomic) IBOutlet UIImageView *imageAvatarOther;

@end

NS_ASSUME_NONNULL_END
