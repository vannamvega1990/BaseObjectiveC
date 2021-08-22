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
@optional
- (void) selectFavouriteTicketGroup:(NSMutableArray*) arrTickets;
@end

@interface BoSoYeuThichViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnHelp;
@property (weak, nonatomic) IBOutlet UIButton *tabMuaNhieu;
@property (weak, nonatomic) IBOutlet UIView *indicatorMuaNhieu;
@property (weak, nonatomic) IBOutlet UIButton *tabYeuThich;
@property (weak, nonatomic) IBOutlet UIView *indicatorYeuThich;
@property (weak, nonatomic) IBOutlet UIButton *tabTyleTrung;
@property (weak, nonatomic) IBOutlet UIView *indicatorTyleTrung;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet MyButton *btnXacNhan;

@property (strong, nonatomic) NSMutableArray *arrTicketGroups;
@property (strong, nonatomic) TicketTypeObj *ticketType;
@property (assign, nonatomic) id <BoSoYeuThichViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
