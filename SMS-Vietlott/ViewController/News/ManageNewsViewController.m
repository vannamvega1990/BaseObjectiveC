//
//  ManageNewsViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManageNewsViewController.h"
#import "SearchNewsViewController.h"
#import "NewsViewController.h"
#import "Utils.h"

@interface ManageNewsViewController ()

@end

@implementation ManageNewsViewController {
    BOOL isSettup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectTabbarNewNews object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectTabbarActionNews object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        [self settupView];
    }
    
    self.viewDisconnect.hidden = ![Utils isDisconnect];
}

- (IBAction)searchNews:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SearchNewsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SearchNewsViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)selectNewsWithTag:(UIButton *)sender {
    [self selectNews:(int)sender.tag];
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*sender.tag, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)selectNews:(int)index {
    for (UILabel *label in self.collectionLabelNews) {
        if (label.tag == index) {
            label.textColor = RGB_COLOR(235, 13, 30);
        }else{
            label.textColor = RGB_COLOR(214, 217, 219);
        }
    }
    
    for (UIView *view in self.collectionViewNews) {
        if (view.tag == index) {
            view.backgroundColor = RGB_COLOR(235, 13, 30);
        }else{
            view.backgroundColor = UIColor.whiteColor;
        }
    }
}

- (IBAction)tryAgain:(id)sender {
    self.viewDisconnect.hidden = ![Utils isDisconnect];
}

- (IBAction)selectNumber:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectTabbarHome object:nil];
}

- (IBAction)selectDate:(id)sender {
//    [self.textFieldDate becomeFirstResponder];
}

- (IBAction)didSelectDate:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectDateNews object:self.textFieldDate.text];
}

- (void)settupView {
    self.textFieldDate.text = [Utils getDateFromDate:[NSDate date]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewsViewController *vcNews_0 = [storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    vcNews_0.date = @"";
    vcNews_0.typeNews = kTinMoiNhat;
    vcNews_0.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcNews_0.view];
    [self addChildViewController:vcNews_0];
    
    NewsViewController *vcNews_1 = [storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    vcNews_1.date = @"";
    vcNews_1.typeNews = kTinHoatDong;
    vcNews_1.view.frame = CGRectMake(self.scrollView.frame.size.width, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcNews_1.view];
    [self addChildViewController:vcNews_1];
    
    NewsViewController *vcNews_2 = [storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    vcNews_2.date = @"";
    vcNews_2.typeNews = kTinTrungThuong;
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

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectTabbarNewNews]) {
        [self selectNews:0];
        
        CGPoint point = CGPointMake(self.scrollView.bounds.size.width*0, 0);
        [self.scrollView setContentOffset:point animated:YES];
    }else if ([notif.name isEqualToString:kNotificationNameSelectTabbarActionNews]) {
        [self selectNews:1];
        
        CGPoint point = CGPointMake(self.scrollView.bounds.size.width*1, 0);
        [self.scrollView setContentOffset:point animated:YES];
    }
}

@end
