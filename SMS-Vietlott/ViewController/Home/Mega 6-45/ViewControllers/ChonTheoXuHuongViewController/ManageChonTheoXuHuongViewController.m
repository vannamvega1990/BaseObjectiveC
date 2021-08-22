//
//  ManageChonTheoXuHuongViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/15/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManageChonTheoXuHuongViewController.h"

@interface ManageChonTheoXuHuongViewController ()

@end

@implementation ManageChonTheoXuHuongViewController {
    BOOL isSettup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        [self settupView];
    }
}

- (void)settupView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    
    ChonTheoXuHuongViewController *vcNews_0 = [storyboard instantiateViewControllerWithIdentifier:@"ChonTheoXuHuongViewController"];
    vcNews_0.ticketType = self.ticketType;
    vcNews_0.delegate = self;
    vcNews_0.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcNews_0.view];
    [self addChildViewController:vcNews_0];
    
    ChonTheoXuHuongViewController *vcNews_1 = [storyboard instantiateViewControllerWithIdentifier:@"ChonTheoXuHuongViewController"];
    vcNews_1.ticketType = self.ticketType;
    vcNews_1.delegate = self;
    vcNews_1.view.frame = CGRectMake(self.scrollView.frame.size.width, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcNews_1.view];
    [self addChildViewController:vcNews_1];
    
    ChonTheoXuHuongViewController *vcNews_2 = [storyboard instantiateViewControllerWithIdentifier:@"ChonTheoXuHuongViewController"];
    vcNews_2.ticketType = self.ticketType;
    vcNews_2.delegate = self;
    vcNews_2.view.frame = CGRectMake(self.scrollView.frame.size.width*2, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcNews_2.view];
    [self addChildViewController:vcNews_2];
    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*3, self.scrollView.frame.size.height)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = (int)scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    [self selectNews:currentPage];
}

- (IBAction)selectType:(UIButton *)sender {
    [self selectNews:(int)sender.tag];
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*sender.tag, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)selectNews:(int)index {
    for (UIButton *btn in self.arrayBtn) {
        if (btn.tag == index) {
            [btn setTitleColor:RGB_COLOR(235, 13, 30) forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:RGB_COLOR(117, 117, 117) forState:UIControlStateNormal];
        }
    }
    
    for (UIView *view in self.arrayViewLine) {
        if (view.tag == index) {
            view.backgroundColor = RGB_COLOR(235, 13, 30);
        }else{
            view.backgroundColor = UIColor.whiteColor;
        }
    }
}

- (void)selectTicketSuccess:(NSMutableArray *)arrTickets {
//    [self.delegate manageSelectTicketSuccess:arrTickets];
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
