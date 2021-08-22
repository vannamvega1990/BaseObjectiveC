//
//  ManageTKNTTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/12/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManageTKNTTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelChuTaiKhoan;
@property (weak, nonatomic) IBOutlet UILabel *labelSoTaiKhoan;
@property (weak, nonatomic) IBOutlet UIView *viewDefault;
@property (weak, nonatomic) IBOutlet UIButton *btnSetDefault;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@end

NS_ASSUME_NONNULL_END
