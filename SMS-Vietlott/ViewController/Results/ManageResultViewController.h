//
//  ResultViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultMega645ViewController.h"
#import "ResultPower655ViewController.h"
#import "ResultMax3DViewController.h"
#import "ResultMax4DViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageResultViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *collectionLabelResult;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *collectionViewResult;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIView *viewDisconnect;

@end

NS_ASSUME_NONNULL_END
