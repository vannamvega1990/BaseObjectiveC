//
//  XuHuongTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/5/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XuHuongTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelSerial;
@property (weak, nonatomic) IBOutlet UIImageView *imageGame;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightView3;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtnNumber;

- (void)setData : (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
