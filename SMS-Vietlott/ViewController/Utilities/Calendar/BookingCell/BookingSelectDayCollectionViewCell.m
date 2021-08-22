//
//  BookingSelectDayCollectionViewCell.m
//  MyHome
//
//  Created by Macbook on 9/27/19.
//  Copyright © 2019 NeoJSC. All rights reserved.
//

#import "BookingSelectDayCollectionViewCell.h"
#import "Utils.h"

@implementation BookingSelectDayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    
}

- (void)setBackGroundSelect : (BookingDate *) bkDate {
    if (bkDate.date) {
        if (bkDate.isFirstDate == YES || bkDate.isEndDate == YES) {
            self.viewIsFirstEnd.hidden = NO;
        }else{
            self.viewIsFirstEnd.hidden = YES;
        }
        
        if (bkDate.isSelect) {
            self.viewFirstSelect.hidden = bkDate.isFirstDate;
            self.viewEndSelect.hidden = bkDate.isEndDate;
        }else{
            self.viewFirstSelect.hidden = YES;
            self.viewEndSelect.hidden = YES;
        }
    }else{
        self.viewIsFirstEnd.hidden = YES;
        self.viewFirstSelect.hidden = YES;
        self.viewEndSelect.hidden = YES;
    }
}

@end
