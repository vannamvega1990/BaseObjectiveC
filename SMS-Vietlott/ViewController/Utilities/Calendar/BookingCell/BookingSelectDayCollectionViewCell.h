//
//  BookingSelectDayCollectionViewCell.h
//  MyHome
//
//  Created by Macbook on 9/27/19.
//  Copyright © 2019 NeoJSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookingSelectDayCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelLunarDate;
@property (weak, nonatomic) IBOutlet UIView *viewIsFirstEnd;
@property (weak, nonatomic) IBOutlet UIView *viewFirstSelect;
@property (weak, nonatomic) IBOutlet UIView *viewEndSelect;

- (void)setBackGroundSelect : (BookingDate *) bkDate;

@end

NS_ASSUME_NONNULL_END
