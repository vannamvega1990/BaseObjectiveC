//
//  ThemViDienTuViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/9/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ThemViDienTuViewController.h"
#import "Utils.h"
#import "CallAPI.h"
#import "CommonTableViewController.h"

@interface ThemViDienTuViewController ()

@end

@implementation ThemViDienTuViewController {
    float currentHeightView2;
    float currentHeightView3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    currentHeightView2 = self.heightView2.constant;
    currentHeightView3 = self.heightView3.constant;
    
    self.heightView2.constant = 0;
    self.heightView3.constant = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectBank object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectEWallet object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectProvince object:nil];
}

- (IBAction)addMore:(id)sender {
    if (self.heightView2.constant == 0) {
        self.heightView2.constant = currentHeightView2;
        self.view2.hidden = NO;
    }else{
        if (self.heightView3.constant == 0) {
            self.heightView3.constant = currentHeightView3;
            self.view3.hidden = NO;
            self.btnAdd.hidden = YES;
            self.btnDelete2.hidden = YES;
        }
    }
}

- (IBAction)deleteView2:(id)sender {
    self.heightView2.constant = 0;
    self.view2.hidden = YES;
}

- (IBAction)deleteView3:(id)sender {
    self.heightView3.constant = 0;
    self.view3.hidden = YES;
    self.btnAdd.hidden = NO;
    self.btnDelete2.hidden = NO;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField == self.textFieldAccNumberNH && (textField.text.length <= 20 || string.length == 0)) {
//        return YES;
//    }else iheightViewVDTd == self.textFieldAccNumberVDT && (textField.text.length <= 20 || string.length == 0)) {
//        return YES;
//    }else{
//        return NO;
//    }
//}

//- (void)dismissKeyboard {
//    [self.textFieldNameNH resignFirstResponder];
//    [self.textFieldNameTKVDT resignFirstResponder];
//    [self.textFieldNameVDT resignFirstResponder];
//    [self.textFieldNameTKNH resignFirstResponder];
//    [self.textFieldProvince resignFirstResponder];
//    [self.textFieldAccNumberNH resignFirstResponder];
//    [self.textFieldAccNumberVDT resignFirstResponder];
//}

//- (IBAction)selectBank:(id)sender {
//    [self dismissKeyboard];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
//    SelectBankViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectBankViewController"];
//    vc.type = bank;
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:vc animated:YES completion:nil];
//}
//
//- (IBAction)selectProvince:(id)sender {
//    [self getListProvince];
//}
//
//- (IBAction)selectEwallet:(id)sender {
//    [self dismissKeyboard];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
//    SelectBankViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectBankViewController"];
//    vc.type = eWallet;
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:vc animated:YES completion:nil];
//}
//
//- (BOOL)checkEnoughInfo {
//    BOOL isOK = YES;
//    
//    if (isTKNH) {
//        if ([Utils lenghtText:self.textFieldNameNH.text] == 0) {
//            isOK = NO;
//            [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Ngân hàng" viewController:self completion:^{
//                [self selectBank:nil];
//            }];
//        }else if ([Utils lenghtText:self.textFieldAccNumberNH.text] == 0) {
//            isOK = NO;
//            [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Số tài khoản ngân hàng" viewController:self completion:^{
//                [self.textFieldAccNumberNH becomeFirstResponder];
//            }];
//        }else if ([Utils lenghtText:self.textFieldAccNumberNH.text] < 9) {
//            isOK = NO;
//            [Utils alertError:@"Thông báo" content:@"Số tài khoản ngân hàng không chính xác" viewController:self completion:^{
//                [self.textFieldAccNumberNH becomeFirstResponder];
//            }];
//        }
//    }else{
//        if ([Utils lenghtText:self.textFieldNameVDT.text] == 0) {
//            isOK = NO;
//            [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Ví điện tử" viewController:self completion:^{
//                [self selectEwallet:nil];
//            }];
//        }else if ([Utils lenghtText:self.textFieldAccNumberVDT.text] == 0) {
//            isOK = NO;
//            [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Số tài khoản ví điện tử" viewController:self completion:^{
//                [self.textFieldAccNumberVDT becomeFirstResponder];
//            }];
//        }else if ([Utils lenghtText:self.textFieldAccNumberVDT.text] < 9) {
//            isOK = NO;
//            [Utils alertError:@"Thông báo" content:@"Số tài khoản ví điện tử không chính xác" viewController:self completion:^{
//                [self.textFieldAccNumberVDT becomeFirstResponder];
//            }];
//        }
//    }
//    
//    return isOK;
//}

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
//    if ([notif.name isEqualToString:kNotificationNameSelectBank]) {
//        dictBank = notif.object;
//        if (dictBank) {
//            self.textFieldNameNH.text = dictBank[@"name"];
//        }
//    }else if ([notif.name isEqualToString:kNotificationNameSelectEWallet]) {
//        dictVDT = notif.object;
//        if (dictVDT) {
//            self.textFieldNameVDT.text = dictVDT[@"name"];
//        }
//    }else if ([notif.name isEqualToString:kNotificationNameSelectProvince]) {
//        dictTP = notif.object;
//        if (dictTP) {
//            self.textFieldProvince.text = dictTP[@"pr_name"];
//        }
//    }
}

@end
