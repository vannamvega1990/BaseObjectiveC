//
//  ManageThongKeViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManageThongKeViewController.h"
#import "ThongKeViewController.h"

@interface ManageThongKeViewController ()

@end

@implementation ManageThongKeViewController {
    BOOL isSettup;
    int currentViewIndex;
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
    currentViewIndex = 0;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
    
    ThongKeViewController *vcMega645 = [storyboard instantiateViewControllerWithIdentifier:@"ThongKeViewController"];
    vcMega645.gameId = idMega645;
    vcMega645.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMega645.view];
    [self addChildViewController:vcMega645];
    
    ThongKeViewController *vcPower655 = [storyboard instantiateViewControllerWithIdentifier:@"ThongKeViewController"];
    vcPower655.gameId = idPower655;
    vcPower655.view.frame = CGRectMake(self.scrollView.frame.size.width, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcPower655.view];
    [self addChildViewController:vcPower655];
    
    ThongKeViewController *vcMax3D = [storyboard instantiateViewControllerWithIdentifier:@"ThongKeViewController"];
    vcMax3D.gameId = idMax3D;
    vcMax3D.view.frame = CGRectMake(self.scrollView.frame.size.width*2, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMax3D.view];
    [self addChildViewController:vcMax3D];
    
    ThongKeViewController *vcMax4D = [storyboard instantiateViewControllerWithIdentifier:@"ThongKeViewController"];
    vcMax4D.gameId = idMax4D;
    vcMax4D.view.frame = CGRectMake(self.scrollView.frame.size.width*3, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMax4D.view];
    [self addChildViewController:vcMax4D];
    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*4, self.scrollView.frame.size.height)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = (int)scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    [self selectGame:currentPage];
}

- (IBAction)selectType:(UIButton *)sender {
    [self selectGame:(int)sender.tag];
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*sender.tag, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (IBAction)selectDate:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
       
    CalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CalendarViewController"];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)confirmSelectFirstDate:(NSDate *)firstDate endDate:(NSDate *)endDate {
    NSDictionary *dict = @{@"start":[Utils getDateFromDate:firstDate],
                           @"end":[Utils getDateFromDate:endDate]
    };
    switch (currentViewIndex) {
        case 0:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectDateThongKeMega object:nil userInfo:dict];
        }
            break;
            
        case 1:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectDateThongKePower object:nil userInfo:dict];
        }
            break;
            
        case 2:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectDateThongKeMax3D object:nil userInfo:dict];
        }
            break;
            
        case 3:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectDateThongKeMax4D object:nil userInfo:dict];
        }
            break;
            
        default:
            break;
    }
}

- (void)selectGame:(int)index {
    currentViewIndex = index;
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

@end
