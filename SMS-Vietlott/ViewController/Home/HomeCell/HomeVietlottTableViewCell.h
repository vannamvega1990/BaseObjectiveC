//
//  HomeVietlottTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/6/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeVietlottTableViewCell : UITableViewCell

@property (nonatomic) NSString *time;

@property (weak, nonatomic) IBOutlet UIImageView *imageVietlott;
@property (weak, nonatomic) IBOutlet UILabel *labelKyQuay;
@property (weak, nonatomic) IBOutlet UILabel *labelJackpot;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end

NS_ASSUME_NONNULL_END
