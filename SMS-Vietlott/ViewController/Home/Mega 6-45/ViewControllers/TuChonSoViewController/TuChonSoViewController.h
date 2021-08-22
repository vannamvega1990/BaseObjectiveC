//
//  TuChonSoViewController.h
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

@protocol TuChonSoViewControllerDelegate<NSObject>
@optional
- (void) selectTicketSuccess:(NSMutableArray*) arrTickets;
@end

@interface TuChonSoViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnHelp;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtnBoSo;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayIndicatorView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblChiPhiTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblChiPhiValue;
@property (weak, nonatomic) IBOutlet MyButton *btnTuChon;
@property (weak, nonatomic) IBOutlet MyButton *btnChonLai;
@property (weak, nonatomic) IBOutlet MyButton *btnXacNhan;


@property TicketTypeObj *ticketType;
@property int selectedIndex;
@property NSMutableArray *arrTickets;
@property NSString *strTicket;
@property int type;

@property (assign, nonatomic) id <TuChonSoViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
