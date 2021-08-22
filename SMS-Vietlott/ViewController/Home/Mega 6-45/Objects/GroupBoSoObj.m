//
//  GroupTicketObj.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "GroupBoSoObj.h"

@implementation GroupBoSoObj
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrTickets = [NSMutableArray array];
    }
    return self;
}

- (void)setSelected:(BOOL)isSelected {
    self.isSelected = isSelected;
    
    for(int i=0;i < self.arrTickets.count; i++ ){
        BoSoObj *ticket = self.arrTickets[i];
        ticket.isSelected = isSelected;
    }
}

@end
