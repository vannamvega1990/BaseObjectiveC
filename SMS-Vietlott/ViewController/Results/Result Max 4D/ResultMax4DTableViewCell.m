//
//  ResultMax4DTableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ResultMax4DTableViewCell.h"

@implementation ResultMax4DTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithResult : (NSDictionary *)dict {
    @try {
        self.labelKyQuay.text = [Utils getKyFromDict:dict];
        
        NSString *strGiaiNhat = [NSString stringWithFormat:@"%@",dict[@"first_prize"]];
        [self fillDataWithResult:strGiaiNhat  toArrayLabel:self.arrayLabelGiaiNhat];
        
        NSArray *arrayGiaiNhi = [[NSString stringWithFormat:@"%@",dict[@"second_prize"]] componentsSeparatedByString:@","] ;
        NSArray *arrayArGiaiNhi = @[self.arrayLabelGiaiNhi1,self.arrayLabelGiaiNhi2];
        for (int i=0; i<arrayGiaiNhi.count; i++) {
            [self fillDataWithResult:arrayGiaiNhi[i]  toArrayLabel:arrayArGiaiNhi[i]];
        }
        
        NSArray *arrayGiaiBa = [[NSString stringWithFormat:@"%@",dict[@"thirt_prize"]] componentsSeparatedByString:@","] ;
        NSArray *arrayArGiaiBa = @[self.arrayLabelGiaiBa1,self.arrayLabelGiaiBa2,self.arrayLabelGiaiBa3];
        for (int i=0; i<arrayGiaiBa.count; i++) {
            [self fillDataWithResult:arrayGiaiBa[i]  toArrayLabel:arrayArGiaiBa[i]];
        }
        
        NSString *strGiaiKK1 = [NSString stringWithFormat:@"%@",dict[@"one_consulation_prize"]];
        [self fillDataWithResult:strGiaiKK1  toArrayLabel:self.arrayLabelGiaiKK1];
        
        NSString *strGiaiKK2 = [NSString stringWithFormat:@"%@",dict[@"second_consulation_prize"]];
        [self fillDataWithResult:strGiaiKK2  toArrayLabel:self.arrayLabelGiaiKK2];
        
    } @catch (NSException *exception) {
        
    } @finally {
            
    }
}

- (void)fillDataWithResult : (NSString *)strResult toArrayLabel : (NSArray *)arrayLabel {
    for (int i=0; i < strResult.length; i++) {
        NSString *number = [strResult substringWithRange:NSMakeRange(i, 1)];
        UILabel *label = arrayLabel[i];
        label.text = number;
    }
}

@end
