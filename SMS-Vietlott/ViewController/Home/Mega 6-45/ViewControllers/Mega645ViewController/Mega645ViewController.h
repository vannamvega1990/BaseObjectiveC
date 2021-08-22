//
//  Mega645ViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyButton.h"
#import "TicketTypeObj.h"
#import "CommonSelectionObj.h"
#import "SelectTypePlayViewController.h"
#import "CommonSelectionObj.h"
#import "ChonKyQuayDialogViewController.h"
#import "BoSoObj.h"
#import "TuChonSoViewController.h"
#import "ChonTheoXuHuongViewController.h"
#import "BoSoYeuThichViewController.h"
#import "ManageChonTheoXuHuongViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UserTicketCellDelegate<NSObject>
@optional
- (void)onFavouriteAction : (BOOL) isFavourite atIndexPath:(NSIndexPath*) indexPath;
- (void)onDeleteAction : (BOOL) isDeleted atIndexPath:(NSIndexPath*) indexPath;
- (void)onSelectAction : (BOOL) isSelected atIndexPath:(NSIndexPath*) indexPath;
- (void)onRandomAction : (BOOL) isSelected atIndexPath:(NSIndexPath*) indexPath;
@end

@interface Mega645ViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,SelectTypePlayViewControllerDelegate, ChonKyQuayDialogViewControllerDelegate, TuChonSoViewControllerDelegate, UserTicketCellDelegate, ManageChonTheoXuHuongViewControllerDelegate, BoSoYeuThichViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnHelp;
@property (weak, nonatomic) IBOutlet UIButton *btnShoppingCart;
@property (weak, nonatomic) IBOutlet UILabel *lblChonCachChoiTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblChonKyQuayTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblChonCachChoiValue;
@property (weak, nonatomic) IBOutlet UILabel *lblChonKyMuaValue;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelValueShoppingCart;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTableViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *lblChiPhiTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblChiPhiValue;

@property (weak, nonatomic) IBOutlet MyButton *btnTuChon;
@property (weak, nonatomic) IBOutlet MyButton *btnChonXuHuong;
@property (weak, nonatomic) IBOutlet MyButton *btnBoSoYeuThich;
@property (weak, nonatomic) IBOutlet MyButton *btnKhac;

@property (weak, nonatomic) IBOutlet MyButton *btnAddCart;
@property (weak, nonatomic) IBOutlet MyButton *btnPayment;

@property int type;
@property NSDictionary *dictGame;

@end

NS_ASSUME_NONNULL_END
