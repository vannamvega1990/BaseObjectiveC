//
//  ResultViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManageResultViewController.h"
#import "SubviewResultsViewController.h"
#import "Utils.h"

@interface ManageResultViewController ()

@end

@implementation ManageResultViewController {
    BOOL isSettup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        [self settupView];
    }
    self.viewDisconnect.hidden = ![Utils isDisconnect];
}

- (void)settupView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Results" bundle:nil];
    
    ResultMega645ViewController *vcMega = [storyboard instantiateViewControllerWithIdentifier:@"ResultMega645ViewController"];
    vcMega.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMega.view];
    [self addChildViewController:vcMega];

    ResultPower655ViewController *vcPower = [storyboard instantiateViewControllerWithIdentifier:@"ResultPower655ViewController"];
    vcPower.view.frame = CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcPower.view];
    [self addChildViewController:vcPower];
    
    ResultMax3DViewController *vcMax3D = [storyboard instantiateViewControllerWithIdentifier:@"ResultMax3DViewController"];
    vcMax3D.view.frame = CGRectMake(self.scrollView.frame.size.width*2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMax3D.view];
    [self addChildViewController:vcMax3D];
    
    ResultMax4DViewController *vcMax4D = [storyboard instantiateViewControllerWithIdentifier:@"ResultMax4DViewController"];
    vcMax4D.view.frame = CGRectMake(self.scrollView.frame.size.width*3, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMax4D.view];
    [self addChildViewController:vcMax4D];
    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*4, self.scrollView.frame.size.height)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = (int)scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    [self selectResults:currentPage];
}

- (IBAction)selectResultsWithTag:(UIButton *)sender {
    [self selectResults:(int)sender.tag];
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*sender.tag, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)selectResults:(int)index {
    for (UILabel *label in self.collectionLabelResult) {
        if (label.tag == index) {
            label.textColor = RGB_COLOR(235, 13, 30);
        }else{
            label.textColor = RGB_COLOR(214, 217, 219);
        }
    }
    
    for (UIView *view in self.collectionViewResult) {
        if (view.tag == index) {
            view.backgroundColor = RGB_COLOR(235, 13, 30);
        }else{
            view.backgroundColor = UIColor.whiteColor;
        }
    }
    
    if (index < 2) {
        self.btnMore.hidden = NO;
    }else{
        self.btnMore.hidden = YES;
    }
}

- (IBAction)showSubView:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Results" bundle:nil];
    SubviewResultsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SubviewResultsViewController"];
    [[[self appDelegate] window] addSubview:vc.view];
    [[[self appDelegate] window].rootViewController addChildViewController:vc];
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)tryAgain:(id)sender {
    self.viewDisconnect.hidden = ![Utils isDisconnect];
}

- (IBAction)selectNumber:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectTabbarHome object:nil];
}

@end
