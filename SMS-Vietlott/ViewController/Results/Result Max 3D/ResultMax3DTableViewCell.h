//
//  ResultMax3DTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabel.h"
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultMax3DTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelKyQuay;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhat1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhat2;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhi1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhi2;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhi3;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhi4;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa2;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa3;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa4;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa5;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa6;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK2;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK3;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK4;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK5;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK6;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK7;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK8;

- (void)setDataWithResult : (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
