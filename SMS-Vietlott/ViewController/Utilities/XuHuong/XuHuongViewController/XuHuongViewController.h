//
//  XuHuongViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/5/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XuHuongViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property NSDictionary *dictGame;
@property NSString *strKyQuay;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelNotice;

@end

NS_ASSUME_NONNULL_END
