//
//  CreateTKTTViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/28/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "CreateTKTTViewController.h"
#import "PolicyTKTTViewController.h"

@interface CreateTKTTViewController ()

@end

@implementation CreateTKTTViewController {
    BOOL isDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fillInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:false];
}

- (void)fillInfo {
    isDefault = YES;
    self.dictTKTT = [Utils converDictRemoveNullValue:self.dictTKTT];
    
    self.labelName.text = self.dictTKTT[@"name"];
    
    int type = [[NSString stringWithFormat:@"%@",self.dictTKTT[@"type"]] intValue];
    self.labelType.text = type == 1 ? @"Ngân hàng" : @"Ví điện tử";
    
    NSString *linkImage = [NSString stringWithFormat:@"%@",self.dictTKTT[@"image"]];
    linkImage = [Utils convertStringUrl:linkImage];
    [self.imageAvatar sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"bank_vpbank"]];
    
    self.textFieldChuTaiKhoan.text = [VariableStatic sharedInstance].dictUserInfo[@"name"];
    self.textFieldChuTaiKhoan.enabled = NO;
}

- (IBAction)onClickBtnCheckBox:(id)sender {
    if (isDefault) {
        isDefault = NO;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_unselect"];
    }else{
        isDefault = YES;
        self.imageCheckBox.image = [UIImage imageNamed:@"checkbox_select"];
    }
}

- (IBAction)onClickBtnDangKy:(id)sender {
    if ([Utils lenghtText:self.textFieldSoTaiKhoan.text] == 0) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập số tài khoản" viewController:self completion:^{
            [self.textFieldSoTaiKhoan becomeFirstResponder];
        }];
    }if ([Utils lenghtText:self.textFieldSoTaiKhoan.text] < 9 || [Utils lenghtText:self.textFieldSoTaiKhoan.text] > 20) {
        [Utils alertError:@"Thông báo" content:@"Số tài khoản không chính xác" viewController:self completion:^{
            [self.textFieldSoTaiKhoan becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldChuTaiKhoan.text] == 0) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập tên chủ tài khoản" viewController:self completion:^{
            [self.textFieldChuTaiKhoan becomeFirstResponder];
        }];
    }else{
        NSArray *check_sum = @[@"api0017_add_bank_account",
                               [VariableStatic sharedInstance].phoneNumber,
                               self.textFieldSoTaiKhoan.text,
                               @"0",
                               self.textFieldChuTaiKhoan.text,
                               [NSString stringWithFormat:@"%@",self.dictTKTT[@"id"]],
                               isDefault ? @"1":@"0"
                               ];
        
        NSDictionary *dictParam = @{@"KEY":@"api0017_add_bank_account",
                                    @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                    @"so_tai_khoan_tknt":self.textFieldSoTaiKhoan.text,
                                    @"loai_tk_nh_vi":@"0",
                                    @"ten_chu_tknt":self.textFieldChuTaiKhoan.text,
                                    @"bank_id":[NSString stringWithFormat:@"%@",self.dictTKTT[@"id"]],
                                    @"status":isDefault ? @"1":@"0"
                                    };
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
        PolicyTKTTViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PolicyTKTTViewController"];
        vc.checkSum = check_sum;
        vc.param = dictParam;
        vc.isDefault = isDefault;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
