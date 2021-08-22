//
//  XuHuongTableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/5/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "XuHuongTableViewCell.h"
#import "Utils.h"

@implementation XuHuongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setData : (NSDictionary *)dict {
    NSString *ticketType = [NSString stringWithFormat:@"%@",dict[@"type_play_id"]];
    
    if ([ticketType isEqualToString:idMegaCoBan] ||
        [ticketType isEqualToString:idPowerCoBan] ||
        [ticketType isEqualToString:idMegaBao5] ||
        [ticketType isEqualToString:idPowerBao5] ||
        [ticketType isEqualToString:idMegaBao7] ||
        [ticketType isEqualToString:idPowerBao7] ||
        [ticketType isEqualToString:idMax3DCoBan] ||
        [ticketType isEqualToString:idMax3DOm] ||
        [ticketType isEqualToString:idMax3DDao] ||
        [ticketType isEqualToString:idMax4DCoBan] ||
        [ticketType isEqualToString:idMax4DToHop] ||
        [ticketType isEqualToString:idMax4DBao] ||
        [ticketType isEqualToString:idMax4DCuon1] ||
        [ticketType isEqualToString:idMax4DCuon4]) {
        self.view1.hidden = NO;
        self.view2.hidden = YES;
        self.view3.hidden = YES;
        
        self.heightView1.constant = 50;
        self.heightView2.constant = 0;
        self.heightView3.constant = 0;
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
        self.view1.hidden = NO;
        self.view2.hidden = NO;
        self.view3.hidden = YES;
        
        self.heightView1.constant = 50;
        self.heightView2.constant = 50;
        self.heightView3.constant = 0;
    }else if ([ticketType isEqualToString:idMegaBao13] ||
              [ticketType isEqualToString:idMegaBao14] ||
              [ticketType isEqualToString:idMegaBao15] ||
              [ticketType isEqualToString:idMegaBao18] ||
              [ticketType isEqualToString:idPowerBao13] ||
              [ticketType isEqualToString:idPowerBao14] ||
              [ticketType isEqualToString:idPowerBao15] ||
              [ticketType isEqualToString:idPowerBao18] ) {
        self.view1.hidden = NO;
        self.view2.hidden = NO;
        self.view3.hidden = NO;
        
        self.heightView1.constant = 50;
        self.heightView2.constant = 50;
        self.heightView3.constant = 50;
    }
    
    [self fillNumber:dict];
}

- (void)fillNumber : (NSDictionary *)dict {
    int range = 2;
    NSString *ticketType = [NSString stringWithFormat:@"%@",dict[@"type_play_id"]];
    NSString *strNumber = [NSString stringWithFormat:@"%@",dict[@"favorite_numbers"]];
    if ([ticketType isEqualToString:idMax3DCoBan] ||
        [ticketType isEqualToString:idMax3DOm] ||
        [ticketType isEqualToString:idMax3DDao] ||
        [ticketType isEqualToString:idMax4DCoBan] ||
        [ticketType isEqualToString:idMax4DToHop] ||
        [ticketType isEqualToString:idMax4DBao] ||
        [ticketType isEqualToString:idMax4DCuon1] ||
        [ticketType isEqualToString:idMax4DCuon4]) {
        range = 1;
    }
    
    NSMutableArray *arrNumber = [NSMutableArray array];
    for (int i=0; i < strNumber.length; i=i+range) {
        @try {
            NSString *tmp_str = [strNumber substringWithRange:NSMakeRange(i, range)];
            [arrNumber addObject:tmp_str];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    for (int i=0; i < arrNumber.count; i++) {
        for (UIButton *btn in self.arrayBtnNumber) {
            if (btn.tag == i) {
                btn.hidden = NO;
                [btn setTitle:arrNumber[i] forState:UIControlStateNormal];
            }
        }
    }
}

@end
