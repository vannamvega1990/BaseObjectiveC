//
//  CommonSelectionObj.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonSelectionObj : JSONModel

@property(strong, nonatomic) NSString *idKyQuay;
@property(strong, nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
