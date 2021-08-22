//
//  TicketTypeObj.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TicketTypeObj : NSObject
@property(strong, nonatomic) NSString *typeId;
@property(strong, nonatomic) NSString *name;
@property int number;
@property int numberTicketofGroup;
@property int price; //gia vé theo loai
@end

NS_ASSUME_NONNULL_END
