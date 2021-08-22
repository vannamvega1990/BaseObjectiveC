//
//  TicketObj.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "BoSoObj.h"

@implementation BoSoObj

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrNumber = [NSMutableArray array];
        for (int i=0; i<18; i++) {
            [self.arrNumber addObject:@""];
        }
    }
    return self;
}

- (void)clearSelectedNumber {
    for(int i =0; i < self.arrNumber.count; i++) {
        self.arrNumber[i] = @"";
    }
}

- (BOOL)isAddingNumber {
    int maxNumber = self.type.number;
    for(int i =0; i < maxNumber; i++) {
        if(![_arrNumber[i] isEqualToString:@""]) {
            return TRUE;
        }
    }

    return FALSE;
}

- (BOOL)isValidNumber {
    int maxNumber = self.type.number;
    for(int i =0; i < maxNumber; i++) {
        if(_arrNumber[i] == nil || [_arrNumber[i] isEqualToString:@""]) {
            return FALSE;
        }
    }

    return TRUE;
}

@end
