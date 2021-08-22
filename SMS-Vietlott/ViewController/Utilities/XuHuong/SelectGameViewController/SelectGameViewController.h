//
//  SelectGameViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SelectGameViewControllerDelegate <NSObject>

- (void)selectGameFinish : (NSDictionary *)dictGame;

@end

@interface SelectGameViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelNotice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTableView;

@property (weak, nonatomic) id<SelectGameViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
