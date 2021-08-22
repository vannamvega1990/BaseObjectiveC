//
//  ManageTKTTViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageTKTTViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewNoBank;
@property (weak, nonatomic) IBOutlet UIButton *btnAddNew;

@end

NS_ASSUME_NONNULL_END
