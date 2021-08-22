//
//  UtilitiesCollectionViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/9/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilitiesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *viewUtility;
@property (weak, nonatomic) IBOutlet UILabel *labelUtility;
@property (weak, nonatomic) IBOutlet UIImageView *imageUtility;

@end

NS_ASSUME_NONNULL_END
