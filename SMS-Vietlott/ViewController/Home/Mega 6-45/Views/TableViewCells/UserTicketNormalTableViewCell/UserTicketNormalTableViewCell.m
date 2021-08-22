//
//  UserTicketNormalTableViewCell.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "UserTicketNormalTableViewCell.h"

@implementation UserTicketNormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)onClickbtnFavourite:(id)sender {
    if(self.delegate != nil && self.indexPath != nil && [self.ticket isValidNumber]) {
        [self.delegate onFavouriteAction: !self.ticket.isFavorited  atIndexPath:self.indexPath];
    }
}

- (IBAction)onClickBtnDelete:(id)sender {
    if(self.delegate != nil && self.indexPath != nil && [self.ticket isValidNumber]) {
        if (!self.isChonTicketOption) {
            [self.delegate onDeleteAction:TRUE atIndexPath:self.indexPath];
        } else {
            [self.delegate onSelectAction:!self.ticket.isSelected atIndexPath:self.indexPath];
        }
    }else{
        [self.delegate onRandomAction:true atIndexPath:self.indexPath];
    }
}

- (void) setData:(BoSoObj *)ticket {
    
     self.isChonTicketOption = FALSE;
    
    if(ticket != nil) {
        _lblBoSo.text = ticket.name;
        [_btnNumber1 setTitle:ticket.arrNumber[0] forState:UIControlStateNormal];
        [_btnNumber2 setTitle:ticket.arrNumber[1] forState:UIControlStateNormal];
        [_btnNumber3 setTitle:ticket.arrNumber[2] forState:UIControlStateNormal];
        [_btnNumber4 setTitle:ticket.arrNumber[3] forState:UIControlStateNormal];
        [_btnNumber5 setTitle:ticket.arrNumber[4] forState:UIControlStateNormal];
        [_btnNumber6 setTitle:ticket.arrNumber[5] forState:UIControlStateNormal];
     
        // image Favourite
        NSString *imageBtnFavourite = @"ic_heart_unselected";
        if(ticket.isFavorited) {
            imageBtnFavourite = @"ic_heart_selected";
        }
        [_btnFavourite setImage:[UIImage imageNamed:imageBtnFavourite] forState:UIControlStateNormal];
        
        // image delete
        NSString *imageBtnDelete = @"ic_refresh";
        if(![ticket.arrNumber[0] isEqualToString:@""]){
            imageBtnDelete = @"ic_trash_delete";
        }
        [_btnDelete setImage:[UIImage imageNamed:imageBtnDelete] forState:UIControlStateNormal];
        
        self.ticket = ticket;
    }
}

- (void) setDataChonTicket:(BoSoObj *)ticket {
    
    self.isChonTicketOption = TRUE;
    
    if(ticket != nil) {
        _lblBoSo.text = [NSString stringWithFormat:@"%ld",self.indexPath.row+1];
        [_btnNumber1 setTitle:ticket.arrNumber[0] forState:UIControlStateNormal];
        [_btnNumber2 setTitle:ticket.arrNumber[1] forState:UIControlStateNormal];
        [_btnNumber3 setTitle:ticket.arrNumber[2] forState:UIControlStateNormal];
        [_btnNumber4 setTitle:ticket.arrNumber[3] forState:UIControlStateNormal];
        [_btnNumber5 setTitle:ticket.arrNumber[4] forState:UIControlStateNormal];
        [_btnNumber6 setTitle:ticket.arrNumber[5] forState:UIControlStateNormal];
     
        // image Favourite
        NSString *imageBtnFavourite = @"ic_heart_unselected";
        if(ticket.isFavorited) {
            imageBtnFavourite = @"ic_heart_selected";
        }
        [_btnFavourite setImage:[UIImage imageNamed:imageBtnFavourite] forState:UIControlStateNormal];
        
        // image delete
        NSString *imageBtnDelete = @"ic_un_checked";
        if(ticket.isSelected){
            imageBtnDelete = @"ic_checked";
        }
        [_btnDelete setImage:[UIImage imageNamed:imageBtnDelete] forState:UIControlStateNormal];
        
        self.ticket = ticket;
    }
}

@end
