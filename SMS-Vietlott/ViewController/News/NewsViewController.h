//
//  NewsViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum : NSUInteger {
    kTinMoiNhat = 366,
    kTinHoatDong = 358,
    kTinTrungThuong = 359,
} TypeNews;

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property TypeNews typeNews;
@property NSString *date;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *viewFirstNews;
@property (weak, nonatomic) IBOutlet UILabel *labelTitleFirstNews;
@property (weak, nonatomic) IBOutlet UIImageView *imageFirstNews;
@property (weak, nonatomic) IBOutlet UILabel *labelContentFirstNews;
@property (weak, nonatomic) IBOutlet UILabel *labelDateFirstNews;

@end

NS_ASSUME_NONNULL_END
