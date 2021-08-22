//
//  FavoriteTicketBao5TableViewCell.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "FavoriteTicketBao5TableViewCell.h"

@implementation FavoriteTicketBao5TableViewCell

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
