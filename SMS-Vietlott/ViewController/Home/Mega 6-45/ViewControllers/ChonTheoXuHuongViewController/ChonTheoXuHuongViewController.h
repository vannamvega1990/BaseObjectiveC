//
//  ChonTheoXuHuongViewController.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
#import "TicketTypeObj.h"
#import "BoSoObj.h"
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChonTheoXuHuongViewControllerDelegate<NSObject>

@optional
- (void) selectTicketSuccess:(NSMutableArray*) arrTickets;
@end

@interface ChonTheoXuHuongViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnHelp;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet MyButton *btnXacNhan;

@property (strong, nonatomic) NSMutableArray *arrTickets;
@property (strong, nonatomic) TicketTypeObj *ticketType;
@property (assign, nonatomic) id <ChonTheoXuHuongViewControllerDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *arrSelectedTickets;

@end

NS_ASSUME_NONNULL_END
