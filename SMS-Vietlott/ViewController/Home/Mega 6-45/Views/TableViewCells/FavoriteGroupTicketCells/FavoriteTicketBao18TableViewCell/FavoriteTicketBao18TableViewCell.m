//
//  FavoriteTicketBao18TableViewCell.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "FavoriteTicketBao18TableViewCell.h"

@implementation FavoriteTicketBao18TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)onClickCheckbox:(id)sender {
    if(self.delegate != nil && self.indexPath != nil && [self.ticket isValidNumber]) {
        [self.delegate onSelectAction:!self.ticket.isSelected atIndexPath:self.indexPath];
    }
}

- (void) setData:(BoSoObj *)ticket {
    
    self.isChonTicketOption = TRUE;
    
    if(ticket != nil) {
        _lblBoSo.text = ticket.name;
        [_btnNumber1 setTitle:ticket.arrNumber[0] forState:UIControlStateNormal];
        [_btnNumber2 setTitle:ticket.arrNumber[1] forState:UIControlStateNormal];
        [_btnNumber3 setTitle:ticket.arrNumber[2] forState:UIControlStateNormal];
        [_btnNumber4 setTitle:ticket.arrNumber[3] forState:UIControlStateNormal];
        [_btnNumber5 setTitle:ticket.arrNumber[4] forState:UIControlStateNormal];
        [_btnNumber6 setTitle:ticket.arrNumber[5] forState:UIControlStateNormal];
        [_btnNumber7 setTitle:ticket.arrNumber[6] forState:UIControlStateNormal];
        [_btnNumber8 setTitle:ticket.arrNumber[7] forState:UIControlStateNormal];
        [_btnNumber9 setTitle:ticket.arrNumber[8] forState:UIControlStateNormal];
        [_btnNumber10 setTitle:ticket.arrNumber[9] forState:UIControlStateNormal];
        [_btnNumber11 setTitle:ticket.arrNumber[10] forState:UIControlStateNormal];
        [_btnNumber12 setTitle:ticket.arrNumber[11] forState:UIControlStateNormal];
        [_btnNumber13 setTitle:ticket.arrNumber[12] forState:UIControlStateNormal];
        [_btnNumber14 setTitle:ticket.arrNumber[13] forState:UIControlStateNormal];
        [_btnNumber15 setTitle:ticket.arrNumber[14] forState:UIControlStateNormal];
        [_btnNumber16 setTitle:ticket.arrNumber[15] forState:UIControlStateNormal];
        [_btnNumber17 setTitle:ticket.arrNumber[16] forState:UIControlStateNormal];
        [_btnNumber18 setTitle:ticket.arrNumber[17] forState:UIControlStateNormal];
        
        
        if([ticket.type.typeId isEqualToString:@"13"]) { //type bao 13
            [_btnNumber14 setHidden:TRUE];
            [_btnNumber15 setHidden:TRUE];
            [_btnNumber16 setHidden:TRUE];
            [_btnNumber17 setHidden:TRUE];
            [_btnNumber18 setHidden:TRUE];
        } else if([ticket.type.typeId isEqualToString:@"14"]) { //type bao 14
            [_btnNumber14 setHidden:FALSE];
            [_btnNumber15 setHidden:TRUE];
            [_btnNumber16 setHidden:TRUE];
            [_btnNumber17 setHidden:TRUE];
            [_btnNumber18 setHidden:TRUE];
        } else if([ticket.type.typeId isEqualToString:@"15"]) { //type bao 15
            [_btnNumber14 setHidden:FALSE];
            [_btnNumber15 setHidden:FALSE];
            [_btnNumber16 setHidden:TRUE];
            [_btnNumber17 setHidden:TRUE];
            [_btnNumber18 setHidden:TRUE];
        } else {
            [_btnNumber14 setHidden:FALSE];
            [_btnNumber15 setHidden:FALSE];
            [_btnNumber16 setHidden:FALSE];
            [_btnNumber17 setHidden:FALSE];
            [_btnNumber18 setHidden:FALSE];
        }
       
        
        // image delete
        NSString *imageBtnDelete = @"ic_un_checked";
        if(ticket.isSelected){
            imageBtnDelete = @"ic_checked";
        }
        [_btnCheckbox setImage:[UIImage imageNamed:imageBtnDelete] forState:UIControlStateNormal];
        
        if(self.indexPath.row == 0){
            [_btnCheckbox setHidden:FALSE];
        } else {
            [_btnCheckbox setHidden:TRUE];
        }
        
        self.ticket = ticket;
    }
}

@end
