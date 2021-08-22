//
//  ReviewSMSViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <CoreData/CoreData.h>
#import "MyButton.h"
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewSMSViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,MFMessageComposeViewControllerDelegate>

@property NSArray *arrayTicket;
@property int typePayment;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelWarning;
@property (weak, nonatomic) IBOutlet UIImageView *imageWarning;
@property (weak, nonatomic) IBOutlet MyButton *btnBuyTicket;


@end

NS_ASSUME_NONNULL_END
