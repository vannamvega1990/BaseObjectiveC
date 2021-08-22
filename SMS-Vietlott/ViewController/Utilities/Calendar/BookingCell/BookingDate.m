//
//  BookingDate.m
//  MyHome
//
//  Created by Macbook on 9/27/19.
//  Copyright © 2019 NeoJSC. All rights reserved.
//

#import "BookingDate.h"
#import "Utils.h"
#import "Lunar.h"

@implementation BookingDate

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)getTextDate {
    if (self.date) {
        NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
        [calender setTimeZone:[NSTimeZone systemTimeZone]];
        NSDateComponents *components = [calender components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:self.date];

        NSInteger day = [components day];
        return [NSString stringWithFormat:@"%ld",(long)day];
    }else{
        return @"";
    }
}

- (NSString *)getTextLunarDate {
    if (self.date) {
        NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
        [calender setTimeZone:[NSTimeZone systemTimeZone]];
        
        unsigned units = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday;
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorian components:units fromDate:self.date];
        NSMutableDictionary *dayInfo = [Lunar getHoroscopeDayInfo:(int)[components day] :(int)[components month] :(int)[components year]];
        if ([components weekday] == 1) {
            [dayInfo setObject:@"Chủ nhật" forKey:@"WeekDay"];
        }
        else{
            [dayInfo setObject:[NSString stringWithFormat:@"Thứ %ld",(long)[components weekday]] forKey:@"WeekDay"];
        }
        NSArray *lunarCalendar = [dayInfo objectForKey:@"Lunar"];
        NSString *lunarDay = [[lunarCalendar objectAtIndex:0] stringValue];
        NSString *lunarMonthYear = [NSString stringWithFormat:@"%@",[lunarCalendar objectAtIndex:1]];
//        NSString *lunarYear = [NSString stringWithFormat:@"%@",[lunarCalendar objectAtIndex:2]];
        
        if ([lunarDay isEqualToString:@"1"]) {
            lunarDay = [NSString stringWithFormat:@"%@/%@",lunarDay,lunarMonthYear];
        }
        
        return lunarDay;
    }else{
        return @"";
    }
}

- (UIColor *)getTextDateColor {
    if (self.isDisable) {
        return RGB_COLOR(214, 217, 219);
    }else if (self.isToday) {
        return RGB_COLOR(3, 106, 225);
    }else{
        return RGB_COLOR(33, 33, 33);
    }
}

@end
