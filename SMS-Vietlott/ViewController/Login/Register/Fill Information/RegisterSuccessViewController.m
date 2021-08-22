//
//  RegisterSuccessViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/27/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "AppDelegate.h"

@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)goHome:(id)sender {
    [self appDelegate].tabbarController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarController"];
    [[[self appDelegate] window] setRootViewController:[[self appDelegate] tabbarController]];
    [[self appDelegate].window makeKeyAndVisible];
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
