//
//  UtiliesViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtiliesViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
