//
//  ResultMax3DTableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ResultMax3DTableViewCell.h"


@implementation ResultMax3DTableViewCell

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
        
        NSArray *arrayGiaiNhat = [[NSString stringWithFormat:@"%@",dict[@"first_prize"]] componentsSeparatedByString:@","] ;
        NSArray *arrayArGiaiNhat = @[self.arrayLabelGiaiNhat1,self.arrayLabelGiaiNhat2];
        for (int i=0; i<arrayGiaiNhat.count; i++) {
            [self fillDataWithResult:arrayGiaiNhat[i]  toArrayLabel:arrayArGiaiNhat[i]];
        }
        
        NSArray *arrayGiaiNhi = [[NSString stringWithFormat:@"%@",dict[@"second_prize"]] componentsSeparatedByString:@","] ;
        NSArray *arrayArGiaiNhi = @[self.arrayLabelGiaiNhi1,self.arrayLabelGiaiNhi2,self.arrayLabelGiaiNhi3,self.arrayLabelGiaiNhi4];
        for (int i=0; i<arrayGiaiNhi.count; i++) {
            [self fillDataWithResult:arrayGiaiNhi[i]  toArrayLabel:arrayArGiaiNhi[i]];
        }
        
        NSArray *arrayGiaiBa = [[NSString stringWithFormat:@"%@",dict[@"thirt_prize"]] componentsSeparatedByString:@","] ;
        NSArray *arrayArGiaiBa = @[self.arrayLabelGiaiBa1,self.arrayLabelGiaiBa2,self.arrayLabelGiaiBa3,self.arrayLabelGiaiBa4,self.arrayLabelGiaiBa5,self.arrayLabelGiaiBa6];
        for (int i=0; i<arrayGiaiBa.count; i++) {
            [self fillDataWithResult:arrayGiaiBa[i]  toArrayLabel:arrayArGiaiBa[i]];
        }
        
        NSArray *arrayGiaiKK = [[NSString stringWithFormat:@"%@",dict[@"one_consulation_prize"]] componentsSeparatedByString:@","] ;
        NSArray *arrayArGiaiKK = @[self.arrayLabelGiaiKK1,self.arrayLabelGiaiKK2,self.arrayLabelGiaiKK3,self.arrayLabelGiaiKK4,self.arrayLabelGiaiKK5,self.arrayLabelGiaiKK6,self.arrayLabelGiaiKK7,self.arrayLabelGiaiKK8];
        for (int i=0; i<arrayGiaiKK.count; i++) {
            [self fillDataWithResult:arrayGiaiKK[i]  toArrayLabel:arrayArGiaiKK[i]];
        }
        
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
