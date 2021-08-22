//
//  PolicyTKTTViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/28/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "PolicyTKTTViewController.h"

@interface PolicyTKTTViewController ()

@end

@implementation PolicyTKTTViewController {
    BOOL isAgree1;
    BOOL isAgree2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)selectViewWithTag:(UIButton *)sender {
    [self selectView:sender.tag];
}

- (IBAction)selectCheckBox1:(id)sender {
    if (isAgree1) {
        isAgree1 = NO;
        self.imageCheckBox1.image = [UIImage imageNamed:@"checkbox_unselect"];
    }else{
        isAgree1 = YES;
        self.imageCheckBox1.image = [UIImage imageNamed:@"checkbox_select"];
    }
    [self enableBtnRegister];
}

//- (IBAction)selectCheckBox2:(id)sender {
//    if (isAgree2) {
//        isAgree2 = NO;
//        self.imageCheckBox2.image = [UIImage imageNamed:@"checkbox_unselect"];
//    }else{
//        isAgree2 = YES;
//        self.imageCheckBox2.image = [UIImage imageNamed:@"checkbox_select"];
//    }
//    [self enableBtnRegister];
//}

- (void)enableBtnRegister {
    if (isAgree1 == YES) {
        self.btnRegister.enabled = YES;
        self.btnRegister.backgroundColor = RGB_COLOR(235, 13, 30);
        self.btnRegister.borderColor = [UIColor clearColor];
        [self.btnRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.btnRegister.enabled = NO;
        self.btnRegister.backgroundColor = RGB_COLOR(255, 255, 255);
        self.btnRegister.borderColor = RGB_COLOR(214, 217, 219);
        [self.btnRegister setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
    }
}

- (void)selectView : (NSInteger) index {
    for (UILabel *label in self.arrayLabel) {
        if (label.tag == index) {
            label.textColor = RGB_COLOR(235, 13, 30);
        }else{
            label.textColor = RGB_COLOR(214, 217, 219);
        }
    }
    
    for (UIView *view in self.arrayViewLine) {
        if (view.tag == index) {
            view.backgroundColor = RGB_COLOR(235, 13, 30);
        }else{
            view.backgroundColor = UIColor.clearColor;
        }
    }
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*index, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = (int)scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    [self selectView:currentPage];
}

- (IBAction)onClickBtnContinue:(id)sender {
    if (isAgree1 == NO) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng đồng ý ủy quyền sử dụng dịch vụ Vietlott" viewController:self completion:^{
            CGPoint point = CGPointMake(self.scrollView.bounds.size.width*0, 0);
            [self.scrollView setContentOffset:point animated:YES];
        }];
    }else{
        [self registerTKTT];
    }
}

#pragma mark CallAPI

- (void)registerTKTT{
    [CallAPI callApiService:kServiceWithToken dictParam:self.param arrayCheckSum:self.checkSum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameCreateTKTTSuccess object:nil];
        [Utils alertError:@"Thông báo" content:@"Đăng ký tài khoản thanh toán thành công!" viewController:self completion:^{
            NSArray *array = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
        }];
    }];
}

@end
