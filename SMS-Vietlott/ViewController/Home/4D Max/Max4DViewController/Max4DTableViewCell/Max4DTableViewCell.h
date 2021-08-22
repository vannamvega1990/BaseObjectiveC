//
//  Max4DTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/11/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoSoObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface Max4DTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber1;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber2;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber3;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber4;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
@property (weak, nonatomic) IBOutlet UIButton *btnRandom;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnPrice;

@property (assign, nonatomic) BoSoObj* ticket;

- (void) setData: (BoSoObj*) ticket;

@end

NS_ASSUME_NONNULL_END
