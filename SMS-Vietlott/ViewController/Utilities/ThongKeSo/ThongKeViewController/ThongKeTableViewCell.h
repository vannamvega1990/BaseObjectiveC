//
//  ThongKeTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThongKeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;

@end

NS_ASSUME_NONNULL_END
