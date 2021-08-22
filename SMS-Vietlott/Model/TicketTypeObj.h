//
//  TicketTypeObj.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTypeObj : JSONModel

@property(strong, nonatomic) NSString *gameId;
@property(strong, nonatomic) NSString *typeId;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *des;
@property int quantitySelectNumber;
@property int numberTicketofGroup;
@property long long price; //gia vé theo loai
@property BOOL activate;

@end

NS_ASSUME_NONNULL_END
