//
//  InstructionTakePhotoSubViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/25/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "InstructionTakePhotoSubViewController.h"

@interface InstructionTakePhotoSubViewController ()

@end

@implementation InstructionTakePhotoSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)closeView:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
