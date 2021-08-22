//
//  TicketObj.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "BoSoObj.h"

@implementation BoSoObj

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"type": @"type",
        @"name": @"name",
        @"arrNumber": @"arrNumber",
        @"price": @"price",
        @"quantityNumber":@"quantityNumber",
        @"arrNumberCreate":@"arrNumberCreate",
        @"isFavorited": @"isFavorited",
        @"isSelected": @"isSelected",
        @"idFavorite":@"idFavorite"
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrNumber = [NSMutableArray array];
        for (int i=0; i<18; i++) {
            [self.arrNumber addObject:@""];
        }
        
        self.arrNumberCreate = [NSArray array];
        self.quantityNumber = 1;
        self.idFavorite = @"";
    }
    return self;
}

- (void)clearSelectedNumber {
    for(int i =0; i < self.arrNumber.count; i++) {
        self.arrNumber[i] = @"";
    }
}

//Đã được thêm số
- (BOOL)isAddingNumber {
    int maxNumber = self.type.quantitySelectNumber;
    for(int i =0; i < maxNumber; i++) {
        if(![_arrNumber[i] isEqualToString:@""]) {
            return TRUE;
        }
    }

    return FALSE;
}

//Đã thêm đủ số
- (BOOL)isValidNumber {
    int maxNumber = self.type.quantitySelectNumber;
    for(int i =0; i < maxNumber; i++) {
        if(_arrNumber[i] == nil || [_arrNumber[i] isEqualToString:@""]) {
            return FALSE;
        }
    }

    return TRUE;
}

@end
