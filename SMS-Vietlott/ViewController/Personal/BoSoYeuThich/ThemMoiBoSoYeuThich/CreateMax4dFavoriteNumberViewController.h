//
//  CreateMax4dFavoriteNumberViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/29/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SelectTypePlayViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateMax4dFavoriteNumberViewController : BaseViewController<SelectTypePlayViewControllerDelegate>

@property NSDictionary *dictEdit;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberOne;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberTwo;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberThree;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberFour;
@property (weak, nonatomic) IBOutlet UILabel *labelCachChoi;

@end

NS_ASSUME_NONNULL_END
