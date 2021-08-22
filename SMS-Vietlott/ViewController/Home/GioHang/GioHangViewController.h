//
//  GioHangViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/23/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Max3DSelectPriceViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GioHangCellDelegate<NSObject>

- (void)onDeleteActionIndexPath : (NSIndexPath*) indexPath atSubIndexPath:(NSIndexPath*) subIndexPath;
- (void)onSelectPriceActionIndexPath : (NSIndexPath*) indexPath atSubIndexPath:(NSIndexPath*) subIndexPath;

@end

@interface GioHangViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,GioHangCellDelegate,Max3DSelectPriceViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@property (weak, nonatomic) IBOutlet UILabel *labelNotice;

@end

NS_ASSUME_NONNULL_END
