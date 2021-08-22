//
//  Register3TKNTViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "Register3TKNTViewController.h"
#import "Utils.h"
#import "ThemNganHangViewController.h"
#import "ThemViDienTuViewController.h"
#import "CommonWebViewController.h"

@interface Register3TKNTViewController ()

@end

@implementation Register3TKNTViewController {
    BOOL isSettup;
    float currentHeightViewTKNH;
    float currentHeightViewVDT;
    
    BOOL isTKNH;
    NSDictionary *dictBank;
    NSDictionary *dictVDT;
    NSDictionary *dictTP;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        isTKNH = YES;
        [self settupView];
    }
}

- (void)settupView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    
    ThemNganHangViewController *vcBank = [storyboard instantiateViewControllerWithIdentifier:@"ThemNganHangViewController"];
    vcBank.view.frame = CGRectMake(self.scrollView.frame.size.width*0, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcBank.view];
    [self addChildViewController:vcBank];
    
    ThemViDienTuViewController *vcWallet = [storyboard instantiateViewControllerWithIdentifier:@"ThemViDienTuViewController"];
    vcWallet.view.frame = CGRectMake(self.scrollView.frame.size.width*1, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcWallet.view];
    [self addChildViewController:vcWallet];
    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*2, self.scrollView.frame.size.height)];
}

- (IBAction)selectTKNH:(id)sender {
    isTKNH = YES;
    
    self.imageRadioTKNH.image = [UIImage imageNamed:@"btn_radio_selected"];
    self.imageRadioVDT.image = [UIImage imageNamed:@"btn_radio_unselect"];
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*0, 0);
    [self.scrollView setContentOffset:point animated:YES];
    
    [self.btnCreateNew setTitle:@"Tạo mới tài khoản ngân hàng" forState:UIControlStateNormal];
}

- (IBAction)selectVDT:(id)sender {
    isTKNH = NO;
    
    self.imageRadioTKNH.image = [UIImage imageNamed:@"btn_radio_unselect"];
    self.imageRadioVDT.image = [UIImage imageNamed:@"btn_radio_selected"];
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*1, 0);
    [self.scrollView setContentOffset:point animated:YES];
    
    [self.btnCreateNew setTitle:@"Tạo mới tài khoản ví điện tử" forState:UIControlStateNormal];
}

- (IBAction)continueRegister:(id)sender {
//    if ([self checkEnoughInfo]) {
//        NSDictionary *dictTKNT;
//
//        if (isTKNH) {
//            dictTKNT = @{@"name":self.textFieldNameTKNH.text,
//                         @"bank":self.textFieldNameNH.text,
//                         @"number":self.textFieldAccNumberNH.text,
//                         @"province":self.textFieldProvince.text,
//                         @"province_id":dictTP?dictTP[@"pr_code"]:@"",
//                         @"bank_id":[NSString stringWithFormat:@"%@",dictBank[@"id"]],
//                         @"type":@"1"
//            };
//        }else{
//            dictTKNT = @{@"name":self.textFieldNameTKVDT.text,
//                         @"e_wallet":self.textFieldNameVDT.text,
//                         @"number":self.textFieldAccNumberVDT.text,
//                         @"province":@"",
//                         @"province_id":@"",
//                         @"bank_id":[NSString stringWithFormat:@"%@",dictVDT[@"id"]],
//                         @"type":@"2"
//            };
//        }
//        [self.delegate continueTKNT:dictTKNT];
//    }
}

- (IBAction)btnCreatNewClick:(id)sender {
    if (isTKNH) {
        [self createNewTKNH];
    }else{
        [self createNewVDT];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = (int)scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    if (currentPage == 0) {
        self.imageRadioTKNH.image = [UIImage imageNamed:@"btn_radio_selected"];
        self.imageRadioVDT.image = [UIImage imageNamed:@"btn_radio_unselect"];
    }else{
        self.imageRadioTKNH.image = [UIImage imageNamed:@"btn_radio_unselect"];
        self.imageRadioVDT.image = [UIImage imageNamed:@"btn_radio_selected"];
    }
}

- (void)createNewTKNH {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    CommonWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonWebViewController"];
    vc.titleView = @"Tạo mới tài khoản ngân hàng";
    vc.stringUrl = @"https://www.vpbank.com.vn/";
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)createNewVDT {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    CommonWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonWebViewController"];
    vc.titleView = @"Tạo mới tài khoản ví điện tử";
    vc.stringUrl = @"https://momo.vn/";
    [self presentViewController:vc animated:YES completion:nil];
}

@end

