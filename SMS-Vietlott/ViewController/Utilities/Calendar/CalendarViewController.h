//
//  CalendarViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BookingSelectDayCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "BookingDate.h"
#import "MyButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CalendarViewControllerDelegate <NSObject>

- (void)confirmSelectFirstDate : (NSDate *)firstDate endDate : (NSDate *)endDate;

@end


@interface CalendarViewController : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) id<CalendarViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet MyButton *btnConfirm;

@end

NS_ASSUME_NONNULL_END
