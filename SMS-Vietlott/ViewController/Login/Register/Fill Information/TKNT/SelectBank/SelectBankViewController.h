//
//  SelectBankViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/26/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    bank,
    eWallet,
    tktt,
    tknt,
    edit_tknt
} TKNT;

NS_ASSUME_NONNULL_BEGIN

@interface SelectBankViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property TKNT type;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


@end

NS_ASSUME_NONNULL_END
