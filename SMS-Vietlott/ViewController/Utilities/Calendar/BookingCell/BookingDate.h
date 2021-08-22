//
//  BookingDate.h
//  MyHome
//
//  Created by Macbook on 9/27/19.
//  Copyright © 2019 NeoJSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookingDate : NSObject

@property NSDate *date;
@property BOOL isDisable;
@property BOOL isToday;
@property BOOL isSelect;
@property BOOL isFirstDate;
@property BOOL isEndDate;

- (NSString *)getTextDate;
- (NSString *)getTextLunarDate;
- (UIColor *)getTextDateColor;

@end

NS_ASSUME_NONNULL_END
