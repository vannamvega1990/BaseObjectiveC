//
//  ChonKyQuayDialogViewController.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CommonSelectionObj.h"

@protocol ChonKyQuayDialogViewControllerDelegate<NSObject>

- (void)onSelectedKyQuay : (CommonSelectionObj*_Nonnull) selectedItem;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ChonKyQuayDialogViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) id <ChonKyQuayDialogViewControllerDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *arrItems;
@property (strong, nonatomic) CommonSelectionObj *selectedItem;
@end

NS_ASSUME_NONNULL_END
