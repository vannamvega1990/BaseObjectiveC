//
//  OtherSettingViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OtherSettingViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelVersion;

@end

NS_ASSUME_NONNULL_END
