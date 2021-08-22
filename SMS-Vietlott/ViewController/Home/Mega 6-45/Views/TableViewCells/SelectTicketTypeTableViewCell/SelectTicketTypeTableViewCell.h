//
//  SelectTicketTypeTableViewCell.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketTypeObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectTicketTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgRadio;

@end

NS_ASSUME_NONNULL_END
