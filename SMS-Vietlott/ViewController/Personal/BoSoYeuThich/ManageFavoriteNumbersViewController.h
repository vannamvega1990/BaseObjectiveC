//
//  ManageFavoriteNumbersViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/28/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageFavoriteNumbersViewController : BaseViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtn;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayViewLine;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
