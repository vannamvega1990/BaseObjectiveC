//
//  ReviewSMSTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewSMSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelNumberSMS;
@property (weak, nonatomic) IBOutlet UILabel *labelContentSMS;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@end

NS_ASSUME_NONNULL_END
