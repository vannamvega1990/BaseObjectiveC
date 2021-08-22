//
//  SelectTypePlayViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/21/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TicketTypeObj.h"

@protocol SelectTypePlayViewControllerDelegate<NSObject>

- (void)onSelectedLoaiVe : (TicketTypeObj *_Nullable) selectedItem ;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SelectTypePlayViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *arrItems;
@property TicketTypeObj *selectedTicketType;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) id <SelectTypePlayViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
