//
//  ManagerFillInfoViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterGTCNViewController.h"
#import "RegisterTKNTViewController.h"
#import "RegisterFinishViewController.h"
#import "PolicyViewController.h"
#import "MyLabel.h"
#import "Utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagerFillInfoViewController : UIViewController<GTCNViewControllerDelegate,RegisterTKNTViewControllerDelegate,FinishRegisterViewControllerDelegate,PolicyViewControllerDelegate>

@property NSString *phoneNumber;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelCollectionTKNT;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelCollectionFinish;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewGTCN;
@property (weak, nonatomic) IBOutlet UIView *viewTKNT;
@property (weak, nonatomic) IBOutlet UIView *viewFinish;

@property (weak, nonatomic) IBOutlet MyLabel *labelNumberTwo;
@property (weak, nonatomic) IBOutlet MyLabel *labelNumberThree;


@end

NS_ASSUME_NONNULL_END
