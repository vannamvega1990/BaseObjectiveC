//
//  BoSoYeuThichTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/26/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketTypeObj.h"

NS_ASSUME_NONNULL_BEGIN

@interface BoSoYeuThichTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (weak, nonatomic) IBOutlet UIView *viewBao5;
@property (weak, nonatomic) IBOutlet UIView *viewBao7;
@property (weak, nonatomic) IBOutlet UIView *viewCoBan;
@property (weak, nonatomic) IBOutlet UIView *viewCoBan2;
@property (weak, nonatomic) IBOutlet UIView *viewCoBan3;
@property (weak, nonatomic) IBOutlet UIView *viewMax;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighViewBao5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighViewBao7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighViewCoBan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighViewCoBan2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighViewCoBan3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewMax;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *arrayHeightView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtn;

@property (weak, nonatomic) IBOutlet UIView *viewBtnMax4D;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthViewMax4D;

- (void)setData : (NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
