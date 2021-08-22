//
//  Max4DSelectNumberViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/11/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Max4DSelectNumberViewControllerDelegate <NSObject>

- (void)completeSelectNumber:(NSArray *)arraySelectNumbers;

@end

@interface Max4DSelectNumberViewController : BaseViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtnBoSo;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayIndicatorView;
@property (strong, nonatomic) IBOutletCollection(MyButton) NSArray *arrayBtnPrice;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberOne;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberTwo;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberThree;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayNumberFour;

@property (weak, nonatomic) id<Max4DSelectNumberViewControllerDelegate> delegate;

@property int selectedIndex;
@property NSString *strTicket;
@property TicketTypeObj *ticketType;

@end

NS_ASSUME_NONNULL_END
