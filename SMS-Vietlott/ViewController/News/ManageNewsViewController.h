//
//  ManageNewsViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFiledChoseDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageNewsViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet TextFiledChoseDate *textFieldDate;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *collectionLabelNews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *collectionViewNews;
@property (weak, nonatomic) IBOutlet UIView *viewDisconnect;


@end

NS_ASSUME_NONNULL_END
