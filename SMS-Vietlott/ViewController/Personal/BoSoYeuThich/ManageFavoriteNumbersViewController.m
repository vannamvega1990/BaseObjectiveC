//
//  ManageFavoriteNumbersViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/28/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManageFavoriteNumbersViewController.h"
#import "FavoriteNumbersViewController.h"

@interface ManageFavoriteNumbersViewController ()

@end

@implementation ManageFavoriteNumbersViewController {
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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    
    FavoriteNumbersViewController *vcMega645 = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteNumbersViewController"];
    vcMega645.gameId = idMega645;
    vcMega645.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMega645.view];
    [self addChildViewController:vcMega645];
    
    FavoriteNumbersViewController *vcPower655 = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteNumbersViewController"];
    vcPower655.gameId = idPower655;
    vcPower655.view.frame = CGRectMake(self.scrollView.frame.size.width, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcPower655.view];
    [self addChildViewController:vcPower655];
    
    FavoriteNumbersViewController *vcMax3D = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteNumbersViewController"];
    vcMax3D.gameId = idMax3D;
    vcMax3D.view.frame = CGRectMake(self.scrollView.frame.size.width*2, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMax3D.view];
    [self addChildViewController:vcMax3D];
    
    FavoriteNumbersViewController *vcMax4D = [storyboard instantiateViewControllerWithIdentifier:@"FavoriteNumbersViewController"];
    vcMax4D.gameId = idMax4D;
    vcMax4D.view.frame = CGRectMake(self.scrollView.frame.size.width*3, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMax4D.view];
    [self addChildViewController:vcMax4D];
    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*4, self.scrollView.frame.size.height)];
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

- (IBAction)deleteAll:(id)sender {
    switch (currentViewIndex) {
        case 0:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectAllFavoriteMega object:nil];
        }
            break;
            
        case 1:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectAllFavoritePower object:nil];
        }
            break;
            
        case 2:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectAllFavoriteMax3D object:nil];
        }
            break;
            
        case 3:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectAllFavoriteMax4D object:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)selectNews:(int)index {
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
