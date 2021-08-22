//
//  ResultMax4DTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabel.h"
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultMax4DTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelKyQuay;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhat;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhi1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiNhi2;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa2;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiBa3;

@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK1;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelGiaiKK2;

- (void)setDataWithResult : (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
