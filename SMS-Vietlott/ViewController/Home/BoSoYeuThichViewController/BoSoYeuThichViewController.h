//
//  BoSoYeuThichViewController.h
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

@protocol BoSoYeuThichViewControllerDelegate<NSObject>

- (void) selectFavouriteTicketGroup:(NSMutableArray*) arrTickets;

@end

@interface BoSoYeuThichViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnHelp;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet MyButton *btnXacNhan;
@property (weak, nonatomic) IBOutlet MyCustomView *viewConfirm;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewConfirm;
@property (weak, nonatomic) IBOutlet UILabel *labelNoti;

@property (strong, nonatomic) TicketTypeObj *ticketType;
@property (assign, nonatomic) id <BoSoYeuThichViewControllerDelegate>delegate;
@property int viTriOm;

@end

NS_ASSUME_NONNULL_END
