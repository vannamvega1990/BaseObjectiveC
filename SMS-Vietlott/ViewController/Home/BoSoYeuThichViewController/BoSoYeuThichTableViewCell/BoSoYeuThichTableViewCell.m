//
//  BoSoYeuThichTableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/26/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "BoSoYeuThichTableViewCell.h"
#import "Utils.h"

@implementation BoSoYeuThichTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData: (NSDictionary *) dict {
    NSString *ticketType = [NSString stringWithFormat:@"%@",dict[@"type_play_id"]];
    NSString *strNumber = [NSString stringWithFormat:@"%@",dict[@"favorite_numbers"]];
    
    if ([ticketType isEqualToString:idMegaCoBan] || [ticketType isEqualToString:idPowerCoBan]) {
        self.viewBao5.hidden = YES;
        self.viewBao7.hidden = YES;
        self.viewCoBan.hidden = NO;
        self.viewCoBan2.hidden = YES;
        self.viewCoBan3.hidden = YES;
        self.viewMax.hidden = YES;
        
        self.heighViewBao5.constant = 0;
        self.heighViewBao7.constant = 0;
        self.heighViewCoBan.constant = 50;
        self.heighViewCoBan2.constant = 0;
        self.heighViewCoBan3.constant = 0;
        self.heightViewMax.constant = 0;
        
        [self fillNumber:strNumber];
    }else if ([ticketType isEqualToString:idMegaBao5] || [ticketType isEqualToString:idPowerBao5]) {
        self.viewBao5.hidden = NO;
        self.viewBao7.hidden = YES;
        self.viewCoBan.hidden = YES;
        self.viewCoBan2.hidden = YES;
        self.viewCoBan3.hidden = YES;
        self.viewMax.hidden = YES;
        
        self.heighViewBao5.constant = 50;
        self.heighViewBao7.constant = 0;
        self.heighViewCoBan.constant = 0;
        self.heighViewCoBan2.constant = 0;
        self.heighViewCoBan3.constant = 0;
        self.heightViewMax.constant = 0;
        
        [self fillNumber:strNumber];
    }else if ([ticketType isEqualToString:idMegaBao7] || [ticketType isEqualToString:idPowerBao7]) {
        self.viewBao5.hidden = YES;
        self.viewBao7.hidden = NO;
        self.viewCoBan.hidden = YES;
        self.viewCoBan2.hidden = YES;
        self.viewCoBan3.hidden = YES;
        self.viewMax.hidden = YES;
        
        self.heighViewBao5.constant = 0;
        self.heighViewBao7.constant = 50;
        self.heighViewCoBan.constant = 0;
        self.heighViewCoBan2.constant = 0;
        self.heighViewCoBan3.constant = 0;
        self.heightViewMax.constant = 0;
        
        [self fillNumber:strNumber];
    }else if ([ticketType isEqualToString:idMegaBao8] ||
              [ticketType isEqualToString:idMegaBao9] ||
              [ticketType isEqualToString:idMegaBao10] ||
              [ticketType isEqualToString:idMegaBao11] ||
              [ticketType isEqualToString:idMegaBao12] ||
              [ticketType isEqualToString:idPowerBao8] ||
              [ticketType isEqualToString:idPowerBao9] ||
              [ticketType isEqualToString:idPowerBao10] ||
              [ticketType isEqualToString:idPowerBao11] ||
              [ticketType isEqualToString:idPowerBao12]  ) {
        self.viewBao5.hidden = YES;
        self.viewBao7.hidden = YES;
        self.viewCoBan.hidden = NO;
        self.viewCoBan2.hidden = NO;
        self.viewCoBan3.hidden = YES;
        self.viewMax.hidden = YES;
        
        self.heighViewBao5.constant = 0;
        self.heighViewBao7.constant = 0;
        self.heighViewCoBan.constant = 50;
        self.heighViewCoBan2.constant = 50;
        self.heighViewCoBan3.constant = 0;
        self.heightViewMax.constant = 0;
        
        [self fillNumber:strNumber];
    }else if ([ticketType isEqualToString:idMegaBao13] ||
              [ticketType isEqualToString:idMegaBao14] ||
              [ticketType isEqualToString:idMegaBao15] ||
              [ticketType isEqualToString:idMegaBao18] ||
              [ticketType isEqualToString:idPowerBao13] ||
              [ticketType isEqualToString:idPowerBao14] ||
              [ticketType isEqualToString:idPowerBao15] ||
              [ticketType isEqualToString:idPowerBao18] ) {
        self.viewBao5.hidden = YES;
        self.viewBao7.hidden = YES;
        self.viewCoBan.hidden = NO;
        self.viewCoBan2.hidden = NO;
        self.viewCoBan3.hidden = NO;
        self.viewMax.hidden = YES;
        
        self.heighViewBao5.constant = 0;
        self.heighViewBao7.constant = 0;
        self.heighViewCoBan.constant = 50;
        self.heighViewCoBan2.constant = 50;
        self.heighViewCoBan3.constant = 50;
        self.heightViewMax.constant = 0;
        
        [self fillNumber:strNumber];
    }else if ([ticketType isEqualToString:idMax3DCoBan] ||
              [ticketType isEqualToString:idMax3DOm] ||
              [ticketType isEqualToString:idMax3DDao] ) {
        self.viewBao5.hidden = YES;
        self.viewBao7.hidden = YES;
        self.viewCoBan.hidden = YES;
        self.viewCoBan2.hidden = YES;
        self.viewCoBan3.hidden = YES;
        self.viewMax.hidden = NO;
        
        self.heighViewBao5.constant = 0;
        self.heighViewBao7.constant = 0;
        self.heighViewCoBan.constant = 0;
        self.heighViewCoBan2.constant = 0;
        self.heighViewCoBan3.constant = 0;
        self.heightViewMax.constant = 50;
        
        self.viewBtnMax4D.hidden = YES;
        self.widthViewMax4D.constant = 0;
        
        [self fillNumberMax:strNumber];
    }else if ([ticketType isEqualToString:idMax4DCoBan] ||
              [ticketType isEqualToString:idMax4DToHop] ||
              [ticketType isEqualToString:idMax4DBao] ||
              [ticketType isEqualToString:idMax4DCuon1] ||
              [ticketType isEqualToString:idMax4DCuon4] ) {
        self.viewBao5.hidden = YES;
        self.viewBao7.hidden = YES;
        self.viewCoBan.hidden = YES;
        self.viewCoBan2.hidden = YES;
        self.viewCoBan3.hidden = YES;
        self.viewMax.hidden = NO;
        
        self.heighViewBao5.constant = 0;
        self.heighViewBao7.constant = 0;
        self.heighViewCoBan.constant = 0;
        self.heighViewCoBan2.constant = 0;
        self.heighViewCoBan3.constant = 0;
        self.heightViewMax.constant = 50;
        
        self.viewBtnMax4D.hidden = NO;
        self.widthViewMax4D.constant = 50;
        
        [self fillNumberMax:strNumber];
    }
}

- (void)fillNumber : (NSString *)strNumber {
    NSMutableArray *arrNumber = [NSMutableArray array];
    for (int i=0; i < strNumber.length; i=i+2) {
        @try {
            NSString *tmp_str = [strNumber substringWithRange:NSMakeRange(i, 2)];
            [arrNumber addObject:tmp_str];
        } @catch (NSException *exception) {
            
        } @finally {
                
        }
    }
    
    for (int i=0; i < arrNumber.count; i++) {
        for (UIButton *btn in self.arrayBtn) {
            if (btn.tag == i) {
                btn.hidden = NO;
                [btn setTitle:arrNumber[i] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)fillNumberMax : (NSString *)strNumber {
    NSMutableArray *arrNumber = [NSMutableArray array];
    for (int i=0; i < strNumber.length; i++) {
        NSString *tmp_str = [strNumber substringWithRange:NSMakeRange(i, 1)];
        [arrNumber addObject:tmp_str];
    }
    
    for (int i=0; i < arrNumber.count; i++) {
        for (UIButton *btn in self.arrayBtn) {
            if (btn.tag == i) {
                btn.hidden = NO;
                [btn setTitle:arrNumber[i] forState:UIControlStateNormal];
            }
        }
    }
}

@end
