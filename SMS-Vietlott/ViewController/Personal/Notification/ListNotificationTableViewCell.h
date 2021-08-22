//
//  ListNotificationTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/14/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListNotificationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageNotifi;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end

NS_ASSUME_NONNULL_END
