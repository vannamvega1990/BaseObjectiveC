//
//  ResultMax3DViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ResultMax3DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultMax3DViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelNote;

@end

NS_ASSUME_NONNULL_END
