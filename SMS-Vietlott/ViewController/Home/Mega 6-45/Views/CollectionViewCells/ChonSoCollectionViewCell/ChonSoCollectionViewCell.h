//
//  ChonSoCollectionViewCell.h
//  SMS-Vietlott
//
//  Created by  Admin on 4/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChonSoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;

@end

NS_ASSUME_NONNULL_END
