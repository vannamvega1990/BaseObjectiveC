//
//  ResultMax4DViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ResultMax4DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultMax4DViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelNote;

@end

NS_ASSUME_NONNULL_END
