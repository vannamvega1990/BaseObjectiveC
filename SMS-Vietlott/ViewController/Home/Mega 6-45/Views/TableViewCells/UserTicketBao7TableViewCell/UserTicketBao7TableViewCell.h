//
//  UserTicketBao7TableViewCell.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoSoObj.h"
#import "Mega645ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserTicketBao7TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblBoSo;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber1;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber2;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber3;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber4;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber5;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber6;
@property (weak, nonatomic) IBOutlet UIButton *btnNumber7;
@property (weak, nonatomic) IBOutlet UIButton *btnFavourite;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@property (assign, nonatomic) id <UserTicketCellDelegate>delegate;
@property (assign, nonatomic) NSIndexPath* indexPath;
@property (assign, nonatomic) BoSoObj* ticket;

@property BOOL isChonTicketOption;

-(void) setData: (BoSoObj*) ticket;
-(void) setDataChonTicket: (BoSoObj*) ticket;
@end

NS_ASSUME_NONNULL_END
