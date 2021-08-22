//
//  ShoppingCartObj.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketTypeObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartObj : NSObject

@property(strong, nonatomic) NSMutableArray *arrNumbers; // danh sach cac bộ số
@property(strong, nonatomic) NSString *date;   // kì quay
@property(strong, nonatomic) TicketTypeObj *type;  //loai vé : vé thường hay bao 5 hay bao 7
@property NSInteger *price;  //giá vé = tổng giá các dãy số

@end

NS_ASSUME_NONNULL_END
