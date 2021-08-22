//
//  ResultDetailMega645ViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultDetailMega645ViewController : BaseViewController

@property NSDictionary *dictResult;

@property (weak, nonatomic) IBOutlet UILabel *labelKyQuay;
@property (strong, nonatomic) IBOutletCollection(MyLabel) NSArray *arrayLabelNumber;
@property (weak, nonatomic) IBOutlet UIView *viewNoTicket;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewNoTicket;

@property (weak, nonatomic) IBOutlet UIView *viewWinningTicket;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightWinningTicket;

@property (weak, nonatomic) IBOutlet UIView *viewHaveTicket;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
