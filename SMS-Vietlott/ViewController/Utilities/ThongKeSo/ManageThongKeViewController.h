//
//  ManageThongKeViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CalendarViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageThongKeViewController : BaseViewController<UIScrollViewDelegate,CalendarViewControllerDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtn;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayViewLine;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end

NS_ASSUME_NONNULL_END
