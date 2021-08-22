//
//  ResultPower655TableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabel.h"
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultPower655TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelKyQuay;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelNumber;
@property (weak, nonatomic) IBOutlet MyLabel *labelNumberSpecial;

- (void)setDataWithResult : (NSDictionary *)dict atIndexPath : (NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
