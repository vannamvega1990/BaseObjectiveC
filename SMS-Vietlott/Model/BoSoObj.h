//
//  TicketObj.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketTypeObj.h"
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoSoObj : JSONModel

@property (strong, nonatomic) TicketTypeObj *type;
@property (strong, nonatomic) NSString *name;
@property (retain, nonatomic) NSMutableArray* arrNumber;
@property long long price;
@property int quantityNumber;//số bộ số có thể tạo ra từ arrNumber đã chọn
@property (retain, nonatomic) NSArray* arrNumberCreate;//các bộ số được tạo ra từ arrNumber đã chọn (dùng cho 3D,4D)
@property (strong, nonatomic) NSString *idFavorite;

@property BOOL isFavorited;
@property BOOL isSelected; //su dung khi chon ticket co san number

- (void) clearSelectedNumber;
- (BOOL) isAddingNumber;
- (BOOL) isValidNumber;

@end

NS_ASSUME_NONNULL_END
