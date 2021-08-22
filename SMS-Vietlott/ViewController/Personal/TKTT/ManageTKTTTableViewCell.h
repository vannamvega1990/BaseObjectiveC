//
//  ManageTKTTTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/28/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManageTKTTTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelChuTaiKhoan;
@property (weak, nonatomic) IBOutlet UILabel *labelSoTaiKhoan;
@property (weak, nonatomic) IBOutlet UIView *viewDefault;
@property (weak, nonatomic) IBOutlet UIButton *btnSetDefault;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end

NS_ASSUME_NONNULL_END
