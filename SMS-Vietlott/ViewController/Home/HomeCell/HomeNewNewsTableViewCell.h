//
//  HomeNewNewsTableViewCell.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeNewNewsTableViewCellDelegate <NSObject>

- (void)pushViewControllerShowDetailItem : (NSDictionary *)dictSkill;

@end

@interface HomeNewNewsTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property NSArray *arrayItem;
@property (weak, nonatomic) id<HomeNewNewsTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
