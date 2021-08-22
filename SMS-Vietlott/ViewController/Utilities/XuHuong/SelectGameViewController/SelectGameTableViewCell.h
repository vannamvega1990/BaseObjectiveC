//
//  SelectGameTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectGameTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageGame;
@property (weak, nonatomic) IBOutlet UILabel *labelNameGame;

@end

NS_ASSUME_NONNULL_END
