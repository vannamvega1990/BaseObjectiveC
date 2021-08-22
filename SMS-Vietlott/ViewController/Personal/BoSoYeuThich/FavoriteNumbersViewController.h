//
//  FavoriteNumbersViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteNumbersViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelNotice;
@property (weak, nonatomic) IBOutlet MyButton *btnDelete;

@property NSString *gameId;

@end

NS_ASSUME_NONNULL_END
