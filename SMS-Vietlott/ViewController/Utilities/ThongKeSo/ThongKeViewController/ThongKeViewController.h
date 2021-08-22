//
//  ThongKeViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThongKeViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property NSString *gameId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelNotice;

@end

NS_ASSUME_NONNULL_END
