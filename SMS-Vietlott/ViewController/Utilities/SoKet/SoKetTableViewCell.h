//
//  SoKetTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SoKetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelPercent;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;

@end

NS_ASSUME_NONNULL_END
