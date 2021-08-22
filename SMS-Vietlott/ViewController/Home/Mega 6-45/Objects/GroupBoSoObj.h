//
//  GroupTicketObj.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoSoObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupBoSoObj : NSObject

@property(strong, nonatomic) NSString *groupId;
@property(strong, nonatomic) NSMutableArray *arrTickets;
@property BOOL *isSelected;

-(void) setSelected: (BOOL) isSelected;

@end

NS_ASSUME_NONNULL_END
