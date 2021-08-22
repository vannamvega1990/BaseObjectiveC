//
//  HomeNewNewsCollectionViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNewNewsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageNews;
@property (weak, nonatomic) IBOutlet UILabel *labelNews;
@property (weak, nonatomic) IBOutlet UILabel *labelTimes;

@end

NS_ASSUME_NONNULL_END
