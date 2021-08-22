//
//  Max3DViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/6/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
#import "ChonKyQuayDialogViewController.h"
#import "SelectTypePlayViewController.h"
#import "ChonTheoXuHuongViewController.h"
#import "BoSoYeuThichViewController.h"
#import "BaseViewController.h"
#import "Max3DSelectNumberViewController.h"
#import "Max3DSelectPriceViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Max3DViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,ChonKyQuayDialogViewControllerDelegate, SelectTypePlayViewControllerDelegate, ChonTheoXuHuongViewControllerDelegate, BoSoYeuThichViewControllerDelegate,Max3DSelectNumberViewControllerDelegate,Max3DSelectPriceViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

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


@property (weak, nonatomic) IBOutlet UIView *viewBoSoTaoRa;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewBoSoTaoRa;

@property (weak, nonatomic) IBOutlet UIView *viewChonViTriOm;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewChonViTriOm;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtnChonjViTriOm;

@property NSDictionary *dictGame;

@end

NS_ASSUME_NONNULL_END
