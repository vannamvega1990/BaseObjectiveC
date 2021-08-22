//
//  HomeViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "PolicyViewController.h"
#import "NewsViewController.h"
#import "HomeNewNewsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,PolicyViewControllerDelegate,HomeNewNewsTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelHMUT;
@property (weak, nonatomic) IBOutlet UILabel *labelLoyalty;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;

@property (weak, nonatomic) IBOutlet UIView *viewUnlogin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewUnlogin;

@property (weak, nonatomic) IBOutlet UIView *viewLogin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewLogin;

@property (weak, nonatomic) IBOutlet UIView *viewDisconnect;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewDisconnect;

@end

NS_ASSUME_NONNULL_END
