//
//  TKNTViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "RegisterTKNTViewController.h"
#import "Utils.h"
#import "SelectBankViewController.h"
#import "CommonTableViewController.h"
#import "CommonWebViewController.h"

@interface RegisterTKNTViewController ()

@end

@implementation RegisterTKNTViewController {
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectBank object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectEWallet object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectProvince object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        isTKNH = YES;
        [self settupView];
    }
}

- (void)settupView {
    currentHeightViewTKNH = self.heightViewTKNH.constant;
    currentHeightViewVDT = self.heightViewVDT.constant;
    
    self.viewVDT.hidden = YES;
    self.heightViewVDT.constant = 0;
    
    self.textFieldNameTKNH.text = self.dictGTCN[@"name"];
    self.textFieldNameTKVDT.text = self.dictGTCN[@"name"];
    
    self.textFieldNameTKNH.enabled = NO;
    self.textFieldNameTKVDT.enabled = NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textFieldAccNumberNH && (textField.text.length <= 20 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldAccNumberVDT && (textField.text.length <= 20 || string.length == 0)) {
        return YES;
    }else{
        return NO;
    }
}

- (void)showViewTKNH {
    self.viewTKNH.hidden = NO;
    self.heightViewTKNH.constant = currentHeightViewTKNH;
    
    self.viewVDT.hidden = YES;
    self.heightViewVDT.constant = 0;
    
    isTKNH = YES;
}

- (void)showViewVDT {
    self.viewTKNH.hidden = YES;
    self.heightViewTKNH.constant = 0;
    
    self.viewVDT.hidden = NO;
    self.heightViewVDT.constant = currentHeightViewVDT;
    
    isTKNH = NO;
}

- (IBAction)selectTKNH:(id)sender {
    self.imageRadioTKNH.image = [UIImage imageNamed:@"btn_radio_selected"];
    self.imageRadioVDT.image = [UIImage imageNamed:@"btn_radio_unselect"];
    
    [self showViewTKNH];
}

- (IBAction)selectVDT:(id)sender {
    self.imageRadioTKNH.image = [UIImage imageNamed:@"btn_radio_unselect"];
    self.imageRadioVDT.image = [UIImage imageNamed:@"btn_radio_selected"];
    
    [self showViewVDT];
}

- (IBAction)continueRegister:(id)sender {
    if ([self checkEnoughInfo]) {
        NSDictionary *dictTKNT;
        
        if (isTKNH) {
            dictTKNT = @{@"name":self.textFieldNameTKNH.text,
                         @"bank":self.textFieldNameNH.text,
                         @"number":self.textFieldAccNumberNH.text,
                         @"province":self.textFieldProvince.text,
                         @"province_id":dictTP?dictTP[@"pr_code"]:@"",
                         @"bank_id":[NSString stringWithFormat:@"%@",dictBank[@"id"]],
                         @"type":@"1"
            };
        }else{
            dictTKNT = @{@"name":self.textFieldNameTKVDT.text,
                         @"e_wallet":self.textFieldNameVDT.text,
                         @"number":self.textFieldAccNumberVDT.text,
                         @"province":@"",
                         @"province_id":@"",
                         @"bank_id":[NSString stringWithFormat:@"%@",dictVDT[@"id"]],
                         @"type":@"2"
            };
        }
        [self.delegate continueTKNT:dictTKNT];
    }
}

- (IBAction)createNewTKNH:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    CommonWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonWebViewController"];
    vc.titleView = @"Tạo mới tài khoản ngân hàng";
    vc.stringUrl = @"https://www.vpbank.com.vn/";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)createNewVDT:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    CommonWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonWebViewController"];
    vc.titleView = @"Tạo mới tài khoản ví điện tử";
    vc.stringUrl = @"https://momo.vn/";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)selectBank:(id)sender {
    [self dismissKeyboard];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    SelectBankViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectBankViewController"];
    vc.type = bank;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)selectProvince:(id)sender {
    [self getListProvince];
}

- (IBAction)selectEwallet:(id)sender {
    [self dismissKeyboard];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    SelectBankViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectBankViewController"];
    vc.type = eWallet;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)dismissKeyboard {
    [self.textFieldNameNH resignFirstResponder];
    [self.textFieldNameTKVDT resignFirstResponder];
    [self.textFieldNameVDT resignFirstResponder];
    [self.textFieldNameTKNH resignFirstResponder];
    [self.textFieldProvince resignFirstResponder];
    [self.textFieldAccNumberNH resignFirstResponder];
    [self.textFieldAccNumberVDT resignFirstResponder];
}

- (BOOL)checkEnoughInfo {
    BOOL isOK = YES;
    
    if (isTKNH) {
        if ([Utils lenghtText:self.textFieldNameNH.text] == 0) {
            isOK = NO;
            [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Ngân hàng" viewController:self completion:^{
                [self selectBank:nil];
            }];
        }else if ([Utils lenghtText:self.textFieldAccNumberNH.text] == 0) {
            isOK = NO;
            [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Số tài khoản ngân hàng" viewController:self completion:^{
                [self.textFieldAccNumberNH becomeFirstResponder];
            }];
        }else if ([Utils lenghtText:self.textFieldAccNumberNH.text] < 9) {
            isOK = NO;
            [Utils alertError:@"Thông báo" content:@"Số tài khoản ngân hàng không chính xác" viewController:self completion:^{
                [self.textFieldAccNumberNH becomeFirstResponder];
            }];
        }
    }else{
        if ([Utils lenghtText:self.textFieldNameVDT.text] == 0) {
            isOK = NO;
            [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Ví điện tử" viewController:self completion:^{
                [self selectEwallet:nil];
            }];
        }else if ([Utils lenghtText:self.textFieldAccNumberVDT.text] == 0) {
            isOK = NO;
            [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Số tài khoản ví điện tử" viewController:self completion:^{
                [self.textFieldAccNumberVDT becomeFirstResponder];
            }];
        }else if ([Utils lenghtText:self.textFieldAccNumberVDT.text] < 9) {
            isOK = NO;
            [Utils alertError:@"Thông báo" content:@"Số tài khoản ví điện tử không chính xác" viewController:self completion:^{
                [self.textFieldAccNumberVDT becomeFirstResponder];
            }];
        }
    }
    
    return isOK;
}

#pragma mark CallAPI

- (void)getListProvince {
    NSArray *check_sum = @[@"api0040_get_list_provinces"];
    
    NSDictionary *dictParam = @{@"KEY":@"api0040_get_list_provinces"};

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *arrayPorvince = dictData[@"info"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
        CommonTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonTableViewController"];
        vc.arrayItem = arrayPorvince;
        vc.typeView = kProvince;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectBank]) {
        dictBank = notif.object;
        if (dictBank) {
            self.textFieldNameNH.text = dictBank[@"name"];
        }
    }else if ([notif.name isEqualToString:kNotificationNameSelectEWallet]) {
        dictVDT = notif.object;
        if (dictVDT) {
            self.textFieldNameVDT.text = dictVDT[@"name"];
        }
    }else if ([notif.name isEqualToString:kNotificationNameSelectProvince]) {
        dictTP = notif.object;
        if (dictTP) {
            self.textFieldProvince.text = dictTP[@"pr_name"];
        }
    }
}

@end
