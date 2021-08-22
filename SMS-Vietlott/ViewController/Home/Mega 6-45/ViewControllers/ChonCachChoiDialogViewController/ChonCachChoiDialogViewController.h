//
//  ChonCachChoiDialogViewController.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TicketTypeObj.h"

@protocol ChonCachChoiDialogViewControllerDelegate<NSObject>
@optional
- (void)onSelectedLoaiVe : (TicketTypeObj*_Nonnull) selectedItem from: (UIViewController*) sender;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ChonCachChoiDialogViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) id <ChonCachChoiDialogViewControllerDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *arrItems;
@property (strong, nonatomic) TicketTypeObj *selectedTicketType;
@end

NS_ASSUME_NONNULL_END
