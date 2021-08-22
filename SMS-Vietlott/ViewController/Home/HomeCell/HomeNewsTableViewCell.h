//
//  HomeNewTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/6/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *labelImageNews;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UILabel *labelDateTime;
@property (weak, nonatomic) IBOutlet UIButton *btnBookmark;

@end

NS_ASSUME_NONNULL_END
