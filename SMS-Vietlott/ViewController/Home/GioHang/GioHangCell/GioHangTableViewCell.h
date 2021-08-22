//
//  GioHang645TableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/23/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
#import <CoreData/CoreData.h>
#import "UserTicketNormalTableViewCell.h"
#import "UserTicketBao5TableViewCell.h"
#import "UserTicketBao7TableViewCell.h"
#import "UserTicketBao18TableViewCell.h"
#import "UserTicketBao12TableViewCell.h"
#import "UserTicketNormalTableViewCell.h"
#import "Max3DTableViewCell.h"
#import "Max4DTableViewCell.h"
#import "GioHangViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GioHangTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource,UserTicketCellDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageVietlott;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberTicket;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet MyButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIView *viewTicket;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewTicket;

@property (assign, nonatomic) id <GioHangCellDelegate>delegate;
@property (assign, nonatomic) NSIndexPath* indexPath;

- (void) setData:(NSManagedObject *) obj;

@end

NS_ASSUME_NONNULL_END
