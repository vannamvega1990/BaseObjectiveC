//
//  ManageXuHuongViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/5/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManageXuHuongViewController.h"
#import "XuHuongViewController.h"

@interface ManageXuHuongViewController ()

@end

@implementation ManageXuHuongViewController {
    BOOL isSettup;
    int currentViewIndex;
    
    NSDictionary *dictGameVietlott;
    
    NSMutableArray *arrKyquay;
    CommonSelectionObj *selectedKyQuay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        [self selectGame];
    }
}

- (IBAction)selectKy:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    ChonKyQuayDialogViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:@"ChonKyQuayDialogViewController"];
    dialogVC.delegate = self;
    dialogVC.selectedItem = selectedKyQuay;
    dialogVC.arrItems = arrKyquay;
    [self.navigationController.view addSubview:dialogVC.view];
    [self.navigationController addChildViewController:dialogVC];
}

- (void)onSelectedKyQuay:(CommonSelectionObj * _Nonnull)selectedItem {
    
}

- (void)createKyQuayOnLine : (NSArray *)array {
    if (array.count > 0) {
        arrKyquay = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            CommonSelectionObj *item = [[CommonSelectionObj alloc] init];
            item.idKyQuay = [NSString stringWithFormat:@"#%@",dict[@"code"]];
            item.name = [[[NSString stringWithFormat:@"%@",dict[@"time_play"]] componentsSeparatedByString:@" "] firstObject];
            [arrKyquay addObject:item];
        }
        
        //set ki quay mac dinh
        selectedKyQuay = arrKyquay[0];
    }
}

- (IBAction)selectGameVietlott:(id)sender {
    [self selectGame];
}

- (IBAction)selectType:(UIButton *)sender {
    [self selectGame:(int)sender.tag];
    
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*sender.tag, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)selectGame {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
    
    SelectGameViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectGameViewController"];
    vc.delegate = self;
    [self.navigationController.view addSubview:vc.view];
    [self.navigationController addChildViewController:vc];
}

- (void)selectGameFinish:(NSDictionary *)dictGame {
    if (dictGame.count > 0) {
        dictGameVietlott = dictGame;;
        [self settupView];
        [self getListKyQuay];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)settupView {
    currentViewIndex = 0;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
    
    XuHuongViewController *vcMuaNhieu = [storyboard instantiateViewControllerWithIdentifier:@"XuHuongViewController"];
    vcMuaNhieu.dictGame = dictGameVietlott;
    vcMuaNhieu.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcMuaNhieu.view];
    [self addChildViewController:vcMuaNhieu];
    
    XuHuongViewController *vcYeuThich = [storyboard instantiateViewControllerWithIdentifier:@"XuHuongViewController"];
    vcYeuThich.dictGame = dictGameVietlott;
    vcYeuThich.view.frame = CGRectMake(self.scrollView.frame.size.width, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcYeuThich.view];
    [self addChildViewController:vcYeuThich];
    
    XuHuongViewController *vcTyLeTrung = [storyboard instantiateViewControllerWithIdentifier:@"XuHuongViewController"];
    vcTyLeTrung.dictGame = dictGameVietlott;
    vcTyLeTrung.view.frame = CGRectMake(self.scrollView.frame.size.width*2, 0 , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vcTyLeTrung.view];
    [self addChildViewController:vcTyLeTrung];
    
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*3, self.scrollView.frame.size.height)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = (int)scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    [self selectGame:currentPage];
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

- (void)getListKyQuay {
    NSArray *check_sum = @[@"api0055_get_ten_period_of_game",
                           [NSString stringWithFormat:@"%@",dictGameVietlott[@"id"]]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0055_get_ten_period_of_game",
                                @"id":[NSString stringWithFormat:@"%@",dictGameVietlott[@"id"]]
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *array = dictData[@"info"];
        [self createKyQuayOnLine:array];
    }];
}

@end
