//
//  FavoriteTicketBao12TableViewCell.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "FavoriteTicketBao12TableViewCell.h"

@implementation FavoriteTicketBao12TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)onClickBtnDelete:(id)sender {
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
        
        
        if([ticket.type.typeId isEqualToString:@"8"]) { //type bao 8
            [_btnNumber9 setHidden:TRUE];
            [_btnNumber10 setHidden:TRUE];
            [_btnNumber11 setHidden:TRUE];
            [_btnNumber12 setHidden:TRUE];
        } else if([ticket.type.typeId isEqualToString:@"9"]) { //type bao 9
            [_btnNumber9 setHidden:FALSE];
            [_btnNumber10 setHidden:TRUE];
            [_btnNumber11 setHidden:TRUE];
            [_btnNumber12 setHidden:TRUE];
        } else if([ticket.type.typeId isEqualToString:@"10"]) { //type bao 10
            [_btnNumber9 setHidden:FALSE];
            [_btnNumber10 setHidden:FALSE];
            [_btnNumber11 setHidden:TRUE];
            [_btnNumber12 setHidden:TRUE];
        } else if([ticket.type.typeId isEqualToString:@"11"]) { //type bao 11
            [_btnNumber9 setHidden:FALSE];
            [_btnNumber10 setHidden:FALSE];
            [_btnNumber11 setHidden:FALSE];
            [_btnNumber12 setHidden:TRUE];
        } else {
            [_btnNumber9 setHidden:FALSE];
            [_btnNumber10 setHidden:FALSE];
            [_btnNumber11 setHidden:FALSE];
            [_btnNumber12 setHidden:FALSE];
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
