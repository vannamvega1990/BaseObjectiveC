//
//  GTCNViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GTCNViewControllerDelegate <NSObject>

- (void)continueGTCN : (NSDictionary *)dictGTCN;

@end

@interface RegisterGTCNViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id<GTCNViewControllerDelegate> delegate;
@property NSString *phoneNumber;

@property (weak, nonatomic) IBOutlet UIImageView *imageRadioCMND;
@property (weak, nonatomic) IBOutlet UIImageView *imageRadioCCCD;
@property (weak, nonatomic) IBOutlet UIImageView *imageRadioMale;
@property (weak, nonatomic) IBOutlet UIImageView *imageRadioFemale;
@property (weak, nonatomic) IBOutlet UIImageView *imageGTCNFront;
@property (weak, nonatomic) IBOutlet UIImageView *imageGTCNBack;

@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNumberGTCN;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDoB;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPlaceProvide;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDateProvide;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPlaceDKDT;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAddress;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;


@property (weak, nonatomic) IBOutlet UIView *viewInstructorTakePicture;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewInstructorTakePicture;

@property (weak, nonatomic) IBOutlet UIView *viewTTCN;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewTTCN;

@end

NS_ASSUME_NONNULL_END
