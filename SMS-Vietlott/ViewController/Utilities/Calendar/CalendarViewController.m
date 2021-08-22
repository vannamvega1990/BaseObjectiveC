//
//  CalendarViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController {
    NSCalendar *calendar;
    NSMutableArray *arrayMonth;
    NSMutableDictionary *listBookingDate;
    
    BOOL isSelectStartDate;
    NSDate *startDate;
    NSDate *endDate;
    NSMutableArray *arraySelectDate;
    NSMutableArray *arrayDisableDate;
    
    int previousMonth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    isSelectStartDate = YES;
    previousMonth = 6;
    
    self.btnConfirm.enabled = NO;
    self.btnConfirm.backgroundColor = RGB_COLOR(255, 255, 255);
    self.btnConfirm.borderColor = RGB_COLOR(214, 217, 219);
    [self.btnConfirm setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
    
    calendar = [NSCalendar autoupdatingCurrentCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    [self settupCalendar];
}

- (IBAction)confirmSelectDate:(id)sender {
    [self.delegate confirmSelectFirstDate:startDate endDate:endDate];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)checkSelectDate : (NSDate *)dateSelect {
    BOOL isOK = YES;
    
    if ([self _numberOfDaysFromDate:startDate toDate:dateSelect] < 0) {
        isOK = NO;
        [Utils alertError:@"Ngày kết thúc không hợp lệ" content:@"Ngày kết thúc phải sau ngày bắt đầu. Mời chọn lại" viewController:nil completion:^{
            
        }];
    }
    
    return isOK;
}

- (void)getArraySelectDate {
    arraySelectDate = [NSMutableArray array];
    [arraySelectDate addObject:startDate];
    NSDate *nextDate = startDate;
    while ([Utils _numberOfDaysFromDate:nextDate toDate:endDate] >= 0) {
        [arraySelectDate addObject:nextDate];
        nextDate = [Utils _nextDay:nextDate];
    }
    [self.collectionView reloadData];
}

#pragma mark CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return arrayMonth.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BookingSelectDayCollectionViewCell";
    
    BookingSelectDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDateComponents *comps = arrayMonth[indexPath.section];
    NSArray *arrayBookingDate = [listBookingDate objectForKey:[NSString stringWithFormat:@"Tháng %ld, %ld",(long)comps.month,(long)comps.year]];
    BookingDate *bkDate = arrayBookingDate[indexPath.row];
    bkDate.isSelect = [arraySelectDate containsObject:bkDate.date];
    bkDate.isFirstDate = bkDate.date == startDate;
    bkDate.isEndDate = bkDate.date == endDate;
    
    cell.labelDate.text = [bkDate getTextDate];
    cell.labelLunarDate.text = [bkDate getTextLunarDate];
    cell.labelDate.textColor = [bkDate getTextDateColor];
    
    [cell setBackGroundSelect:bkDate];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int width = (int)([UIScreen mainScreen].bounds.size.width)/7;
    int height = width;
    
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDateComponents *comps = arrayMonth[indexPath.section];
    NSArray *arrayBookingDate = [listBookingDate objectForKey:[NSString stringWithFormat:@"Tháng %ld, %ld",(long)comps.month,(long)comps.year]];
    BookingDate *bkDate = arrayBookingDate[indexPath.row];
    if (bkDate.date) {
        if (isSelectStartDate) {
            arraySelectDate = [NSMutableArray array];
            startDate = bkDate.date;
            isSelectStartDate = NO;
            endDate = nil;
            
            self.btnConfirm.enabled = NO;
            self.btnConfirm.backgroundColor = RGB_COLOR(255, 255, 255);
            self.btnConfirm.borderColor = RGB_COLOR(214, 217, 219);
            [self.btnConfirm setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            });
        }else{
            if ([self checkSelectDate:bkDate.date]) {
                endDate = bkDate.date;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                });
                isSelectStartDate = YES;
                [self getArraySelectDate];
                
                self.btnConfirm.enabled = YES;
                self.btnConfirm.backgroundColor = RGB_COLOR(235, 13, 30);
                self.btnConfirm.borderColor = [UIColor clearColor];
                [self.btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    [self.collectionView reloadData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSDateComponents *comps = arrayMonth[indexPath.section];
        
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView" forIndexPath:indexPath];
        headerView.labelTitle.text = [NSString stringWithFormat:@"Tháng %ld, %ld",(long)comps.month,(long)comps.year];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

#pragma mark Calendar

- (BOOL)_dateIsToday:(NSDate *)date {
    return [self date:[NSDate date] isSameDayAsDate:date];
}

- (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2 {
    // Both dates must be defined, or they're not the same
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSDateComponents *day = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date1];
    NSDateComponents *day2 = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date2];
    return ([day2 day] == [day day] &&
            [day2 month] == [day month] &&
            [day2 year] == [day year] &&
            [day2 era] == [day era]);
}

- (NSDate *)_firstDayOfNextMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comps.day = 1;
    comps.month = comps.month + 1;
    return [calendar dateFromComponents:comps];
}

- (NSDate *)_nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}

- (NSInteger)_numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    return [endDate timeIntervalSinceDate:startDate];
}

- (void)settupCalendar {
    listBookingDate = [NSMutableDictionary dictionary];
    arrayMonth = [NSMutableArray array];
    
    NSDateComponents *comps = [NSDateComponents new];
    comps.month = -previousMonth;
    comps.day   = -1;
    NSDate *currentDate = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    
    NSDateComponents *thisComps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:currentDate];
    thisComps.day = 1;
    [arrayMonth addObject:thisComps];
    [listBookingDate setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"Tháng %ld, %ld",(long)thisComps.month,(long)thisComps.year]];
    
    for (int i=0; i<previousMonth; i++) {
        NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:currentDate];
        comps.day = 1;
        if (comps.month + 1 == 13) {
            comps.month = 1;
            comps.year = comps.year + 1;
        }else{
            comps.month = comps.month + 1;
        }
        [arrayMonth addObject:comps];
        
        [listBookingDate setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"Tháng %ld, %ld",(long)comps.month,(long)comps.year]];
        
        currentDate = [self _firstDayOfNextMonthContainingDate:currentDate];
    }
    
    for (NSDateComponents *comps in arrayMonth) {
        NSDate *firstDate = [calendar dateFromComponents:comps];
        
        int start = [Utils placeInWeekForDate:firstDate];
        
        for (int i=0; i<42; i++) {
            if (i<start) {
                BookingDate *bkDate = [[BookingDate alloc] init];
                [[listBookingDate objectForKey:[NSString stringWithFormat:@"Tháng %ld, %ld",(long)comps.month,(long)comps.year]] addObject:bkDate];
            }else{
                NSDateComponents *day = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:firstDate];
                
                if (day.month == comps.month) {
                    BookingDate *bkDate = [[BookingDate alloc] init];
                    bkDate.isDisable = NO;
                    bkDate.date = firstDate;
                    bkDate.isToday = [self _dateIsToday:firstDate];
                    
                    [[listBookingDate objectForKey:[NSString stringWithFormat:@"Tháng %ld, %ld",(long)comps.month,(long)comps.year]] addObject:bkDate];
                    firstDate = [self _nextDay:firstDate];
                }else{
                    BookingDate *bkDate = [[BookingDate alloc] init];
                    [[listBookingDate objectForKey:[NSString stringWithFormat:@"Tháng %ld, %ld",(long)comps.month,(long)comps.year]] addObject:bkDate];
                }
            }
        }
    }
    
    
    
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:41 inSection:self->arrayMonth.count-1] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    });
}

@end
