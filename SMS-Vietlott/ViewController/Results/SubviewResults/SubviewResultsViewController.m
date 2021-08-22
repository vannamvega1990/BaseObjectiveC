//
//  SubviewResultsViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SubviewResultsViewController.h"

@interface SubviewResultsViewController ()

@end

@implementation SubviewResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)closeView:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)showNguHanh:(id)sender {
}

- (IBAction)showSoMo:(id)sender {
}

- (IBAction)showSoKet:(id)sender {
}

- (IBAction)showThongKe:(id)sender {
}

@end
