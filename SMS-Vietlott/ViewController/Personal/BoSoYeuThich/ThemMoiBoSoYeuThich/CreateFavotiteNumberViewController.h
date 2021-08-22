//
//  CreateFavotiteNumberViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/29/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SelectTypePlayViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateFavotiteNumberViewController : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SelectTypePlayViewControllerDelegate>

@property int type;
@property NSDictionary *dictEdit;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *labelCachChoi;
@property (weak, nonatomic) IBOutlet UIView *viewBtn;

@end

NS_ASSUME_NONNULL_END
