//
//  ResultMega645TableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ResultMega645TableViewCell.h"

@implementation ResultMega645TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithResult : (NSDictionary *)dict atIndexPath : (NSIndexPath *)indexPath {
    NSString *strResult = [NSString stringWithFormat:@"%@",dict[@"set_of_number"]];
    NSArray *arrayResult = [strResult componentsSeparatedByString:@","];
    
    int i=0;
    if (indexPath.row == 0) {
        for (MyLabel *label in self.arrayLabelNumber) {
            label.textColor = UIColor.whiteColor;
            label.backgroundColor = RGB_COLOR(235, 13, 30);
            label.text = arrayResult[i];
            i++;
        }
    }else{
        for (MyLabel *label in self.arrayLabelNumber) {
            label.textColor = RGB_COLOR(33, 33, 33);
            label.backgroundColor = UIColor.whiteColor;
            label.text = arrayResult[i];
            i++;
        }
    }
    
    self.labelKyQuay.text = [Utils getKyFromDict:dict];
}

@end
