//
//  EditTKNTViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/12/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "EditTKNTViewController.h"
#import "SelectBankViewController.h"

@interface EditTKNTViewController ()

@end

@implementation EditTKNTViewController {
    NSDictionary *dictBank;
    BOOL isDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fillInfo];
}

- (void)fillInfo {
    self.textFieldChuTaiKhoan.text = [NSString stringWithFormat:@"%@",self.dictTKNT[@"ten_chu_tknt"]];
    self.textFieldSoTaiKhoan.text = [NSString stringWithFormat:@"%@",self.dictTKNT[@"so_tai_khoan_tknt"]];
    self.textFieldTenNganHang.text = [NSString stringWithFormat:@"%@",self.dictTKNT[@"bank_name"]];
    
    dictBank = @{@"id":self.dictTKNT[@"bank_id"],
                 @"name":self.dictTKNT[@"bank_name"]
    };
    
    int status = [self.dictTKNT[@"status"] intValue];
    if (status != 0) {
        isDefault = YES;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_select"];
    }else{
        isDefault = NO;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_unselect"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectEditTKTT object:nil];
}

- (IBAction)selectIsDefault:(id)sender {
    if (isDefault) {
        isDefault = NO;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_unselect"];
    }else{
        isDefault = YES;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_select"];
    }
}

- (IBAction)selectBank:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    SelectBankViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectBankViewController"];
    vc.type = edit_tknt;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)updateTKNT:(id)sender {
    if ([Utils lenghtText:self.textFieldSoTaiKhoan.text] == 0) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập số tài khoản" viewController:self completion:^{
            [self.textFieldSoTaiKhoan resignFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldTenNganHang.text] == 0) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Ngân hàng/Ví điện tử" viewController:self completion:^{
            [self selectBank:nil];
        }];
    }else{
        [self editTKNT];
    }
}

#pragma mark CallAPI

- (void)editTKNT{
    NSArray *check_sum = @[@"api0047_update_bank_account",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%@",self.dictTKNT[@"id"]],
                           self.textFieldSoTaiKhoan.text,
                           @"1",
                           self.textFieldChuTaiKhoan.text,
                           [NSString stringWithFormat:@"%@",dictBank[@"id"]],
                           isDefault ? @"1":@"0"
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0047_update_bank_account",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"id":[NSString stringWithFormat:@"%@",self.dictTKNT[@"id"]],
                                @"so_tai_khoan_tknt":self.textFieldSoTaiKhoan.text,
                                @"loai_tk_nh_vi":@"1",
                                @"ten_chu_tknt":self.textFieldChuTaiKhoan.text,
                                @"bank_id":[NSString stringWithFormat:@"%@",dictBank[@"id"]],
                                @"status":isDefault ? @"1":@"0"
                                };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameCreateTKNTSuccess object:nil];
        [Utils alertError:@"Thông báo" content:@"Sửa thông tin tài khoản nhận thưởng thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectEditTKTT]) {
        dictBank = notif.object;
        if (dictBank) {
            self.textFieldTenNganHang.text = [NSString stringWithFormat:@"%@",dictBank[@"name"]];
            self.textFieldSoTaiKhoan.text = @"";
        }
    }
}

@end
