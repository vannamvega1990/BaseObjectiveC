//
//  FinishRegisterViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "RegisterFinishViewController.h"
#import "Utils.h"

@interface RegisterFinishViewController ()

@end

@implementation RegisterFinishViewController {
    BOOL isSettup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        [self settupView];
    }
}

- (void)settupView {
    self.imageGTCNFront.image = self.dictGTCN[@"imageF"];
    self.imageGTCNBack.image = self.dictGTCN[@"imageB"];
    
    self.labelName.text = self.dictGTCN[@"name"];
    self.labelDob.text = self.dictGTCN[@"dob"];
    self.labelGender.text = self.dictGTCN[@"gender"];
    self.labelNumberGTCN.text = self.dictGTCN[@"number_gtcn"];
    self.labelProvidePlace.text = self.dictGTCN[@"provide_place"];
    self.labelProvideDate.text = self.dictGTCN[@"provide_date"];
    self.labelTGDT.text = self.dictGTCN[@"place_tgdt"];
    self.labelAddress.text = self.dictGTCN[@"add"];
    self.labelEmail.text = self.dictGTCN[@"email"];
    self.labelPhoneNumber.text = self.phoneNumber;
    
    if ([self.dictTKNT[@"type"] intValue] == 1) {
        self.viewInfoEwallet.hidden = YES;
        self.heightEWallet.constant = 0;
        
        self.labelNameTKNH.text = self.dictTKNT[@"name"];
        self.labelNumberTKNH.text = self.dictTKNT[@"number"];
        self.labelNameBank.text = self.dictTKNT[@"bank"];
        self.labelProvince.text = self.dictTKNT[@"province"];
    }else{
        self.viewInfoBank.hidden = YES;
        self.heightViewInfobank.constant = 0;
        
        self.labelNameTKVDT.text = self.dictTKNT[@"name"];
        self.labelNameVDT.text = self.dictTKNT[@"e_wallet"];
        self.labelNumberTKVDT.text = self.dictTKNT[@"number"];
    }
}

- (IBAction)finishRegister:(id)sender {
    NSString *idInit = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultIdInit];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultDeviceToken];
    
    NSArray *arrayCheckSum = @[@"api0006_submit_infor_bonus_account",
                               self.phoneNumber,
                               self.dictGTCN[@"name"],
                               self.dictGTCN[@"dob"],
                               self.dictGTCN[@"gender_id"],
                               self.dictGTCN[@"number_gtcn"],
                               self.dictGTCN[@"provide_place"],
                               self.dictGTCN[@"provide_date"],
                               self.dictGTCN[@"place_tgdt_id"],
                               self.dictGTCN[@"add"],
                               self.dictGTCN[@"email"],
                               self.dictGTCN[@"link_imageF"],
                               self.dictGTCN[@"link_imageB"],
                               self.dictTKNT[@"name"],
                               self.dictTKNT[@"number"],
                               self.dictTKNT[@"bank_id"],
                               self.dictTKNT[@"province_id"],
                               self.dictGTCN[@"gtcn_type"],
                               idInit?idInit:@"",
                               deviceToken?deviceToken:@"",
                               @"1",
                               @"",
                               @"",
                               @"",
                               @"",
                               @"",
                               @"",
                               @"",
                               @""
    ];
    
    NSDictionary *dictFinish = @{@"KEY":@"api0006_submit_infor_bonus_account",
                                 @"mobile": self.phoneNumber,
                                 @"name":self.dictGTCN[@"name"],
                                 @"dob":self.dictGTCN[@"dob"],
                                 @"gender":self.dictGTCN[@"gender_id"],
                                 @"id_number":self.dictGTCN[@"number_gtcn"],
                                 @"poi":self.dictGTCN[@"provide_place"],
                                 @"doi":self.dictGTCN[@"provide_date"],
                                 @"dia_diem_du_thuong":self.dictGTCN[@"place_tgdt_id"],
                                 @"home":self.dictGTCN[@"add"],
                                 @"email":self.dictGTCN[@"email"],
                                 @"front_img":self.dictGTCN[@"link_imageF"],
                                 @"back_img":self.dictGTCN[@"link_imageB"],
                                 @"ten_tai_khoan_tknt":self.dictTKNT[@"name"],
                                 @"so_tai_khoan_tknt":self.dictTKNT[@"number"],
                                 @"bank_id":self.dictTKNT[@"bank_id"],
                                 @"province_id_for_bank_account":self.dictTKNT[@"province_id"],
                                 @"gtcn_type":self.dictGTCN[@"gtcn_type"],
                                 @"device_token_id":idInit?idInit:@"",
                                 @"device_token":deviceToken?deviceToken:@"",
                                 @"device_type":@"1",
                                 @"ten_tai_khoan_tknt2":@"",
                                 @"so_tai_khoan_tknt2":@"",
                                 @"bank_id2":@"",
                                 @"province_id_for_bank_account2":@"",
                                 @"ten_tai_khoan_tknt3":@"",
                                 @"so_tai_khoan_tknt3":@"",
                                 @"bank_id3":@"",
                                 @"province_id_for_bank_account3":@"",
    };
    
    [self.delegate continueFinish:dictFinish :arrayCheckSum ];
}


@end
