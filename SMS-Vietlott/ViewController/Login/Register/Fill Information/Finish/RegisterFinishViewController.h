//
//  FinishRegisterViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FinishRegisterViewControllerDelegate <NSObject>

- (void)continueFinish : (NSDictionary *)dictFinish : (NSArray *)arrayCheckSum ;

@end

@interface RegisterFinishViewController : UIViewController

@property (weak, nonatomic) id<FinishRegisterViewControllerDelegate> delegate;
@property NSString *phoneNumber;
@property NSDictionary *dictGTCN;
@property NSDictionary *dictTKNT;

@property (weak, nonatomic) IBOutlet UIView *viewInfoBank;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewInfobank;

@property (weak, nonatomic) IBOutlet UIView *viewInfoEwallet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightEWallet;

@property (weak, nonatomic) IBOutlet UIImageView *imageGTCNFront;
@property (weak, nonatomic) IBOutlet UIImageView *imageGTCNBack;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDob;
@property (weak, nonatomic) IBOutlet UILabel *labelGender;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberGTCN;
@property (weak, nonatomic) IBOutlet UILabel *labelProvidePlace;
@property (weak, nonatomic) IBOutlet UILabel *labelProvideDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTGDT;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *labelNameTKNH;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberTKNH;
@property (weak, nonatomic) IBOutlet UILabel *labelNameBank;
@property (weak, nonatomic) IBOutlet UILabel *labelProvince;

@property (weak, nonatomic) IBOutlet UILabel *labelNameTKVDT;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberTKVDT;
@property (weak, nonatomic) IBOutlet UILabel *labelNameVDT;

@end

NS_ASSUME_NONNULL_END
