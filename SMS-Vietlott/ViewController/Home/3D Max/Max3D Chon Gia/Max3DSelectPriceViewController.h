//
//  Max3DSelectPriceViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Max3DSelectPriceViewControllerDelegate<NSObject>

- (void)onSelectedPrice : (long long) price : (NSIndexPath *_Nonnull)hitIndex;

@end

NS_ASSUME_NONNULL_BEGIN

@interface Max3DSelectPriceViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) id <Max3DSelectPriceViewControllerDelegate>delegate;
@property long long currentPrice;
@property NSIndexPath *selectIndex;

@end

NS_ASSUME_NONNULL_END
