//
//  Max3DTableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "Max3DTableViewCell.h"

@implementation Max3DTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setData:(BoSoObj *)ticket {
    if(ticket != nil) {
        self.labelName.text = ticket.name;
        self.labelNumber1.text = ticket.arrNumber[0];
        self.labelNumber2.text = ticket.arrNumber[1];
        self.labelNumber3.text = ticket.arrNumber[2];
        
        self.labelPrice.text = [NSString stringWithFormat:@"%lldk",ticket.price/1000];
     
        // image Favourite
        NSString *imageBtnFavourite = @"ic_heart_unselected";
        if(ticket.isFavorited) {
            imageBtnFavourite = @"ic_heart_selected";
        }
        [self.btnFavorite setImage:[UIImage imageNamed:imageBtnFavourite] forState:UIControlStateNormal];
        
        // image delete
        NSString *imageBtnDelete = @"ic_refresh";
        if(![ticket.arrNumber[0] isEqualToString:@""]){
            imageBtnDelete = @"ic_trash_delete";
        }
        [self.btnRandom setImage:[UIImage imageNamed:imageBtnDelete] forState:UIControlStateNormal];
        
        self.ticket = ticket;
    }
}

@end
