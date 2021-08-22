//
//  TicketObj.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketTypeObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoSoObj : NSObject
@property(strong, nonatomic) TicketTypeObj *type;
@property(strong, nonatomic) NSString *name;
@property int *price;
@property NSMutableArray* arrNumber;

@property BOOL *isFavorited;
@property BOOL *isSelected; //su dung khi chon ticket co san numbet

-(void) clearSelectedNumber;
-(BOOL) isAddingNumber;
-(BOOL) isValidNumber;

@end

NS_ASSUME_NONNULL_END
