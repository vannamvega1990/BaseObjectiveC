//
//  ThemNganHangViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/9/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ThemNganHangViewController.h"

@interface ThemNganHangViewController ()

@end

@implementation ThemNganHangViewController {
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

@end
