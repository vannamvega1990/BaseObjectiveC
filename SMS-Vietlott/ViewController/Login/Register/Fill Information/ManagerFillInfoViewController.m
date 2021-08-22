//
//  ManagerFillInfoViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManagerFillInfoViewController.h"
#import "RegisterNotificationViewController.h"

@interface ManagerFillInfoViewController ()

@end

@implementation ManagerFillInfoViewController {
    BOOL isSettup;
    BOOL canTouchTwo;
    BOOL canTouchThree;
    
    NSDictionary *mDictGTCN;
    NSDictionary *mDictTKNT;
    NSDictionary *mDictFinish;
    NSArray *mArrayCheckSum;
    
    RegisterTKNTViewController *vcTKNT;
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    RegisterGTCNViewController *vcGTCN = [storyboard instantiateViewControllerWithIdentifier:@"GTCNViewController"];
    vcGTCN.view.frame = CGRectMake(0, 0, self.viewGTCN.frame.size.width, self.viewGTCN.frame.size.height);
    vcGTCN.delegate = self;
    vcGTCN.phoneNumber = self.phoneNumber;
    [self.viewGTCN addSubview:vcGTCN.view];
    [self addChildViewController:vcGTCN];
}

- (IBAction)selectGTCN:(id)sender {
    CGPoint point = CGPointMake(self.scrollView.bounds.size.width*0, 0);
    [self.scrollView setContentOffset:point animated:YES];
    
    [self unselectTKNT];
    [self unselectFinish];
    
    canTouchTwo = NO;
    canTouchThree = NO;
}

- (IBAction)selectTKNT:(id)sender {
    if (canTouchTwo) {
        if (vcTKNT == nil) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            vcTKNT = [storyboard instantiateViewControllerWithIdentifier:@"TKNTViewController"];
            vcTKNT.view.frame = CGRectMake(0, 0, self.viewTKNT.frame.size.width, self.viewGTCN.frame.size.height);
            vcTKNT.dictGTCN = mDictGTCN;
            vcTKNT.delegate = self;
            [self.viewTKNT addSubview:vcTKNT.view];
            [self addChildViewController:vcTKNT];
        }
        
        CGPoint point = CGPointMake(self.scrollView.bounds.size.width*1, 0);
        [self.scrollView setContentOffset:point animated:YES];
        
        [self selectTKNT];
        [self unselectFinish];
        
        canTouchThree = NO;
    }
}

- (IBAction)selectFinish:(id)sender {
    if (canTouchThree) {
        for (UIView *v in [self.viewFinish subviews]) {
            [v removeFromSuperview];
        }
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
        RegisterFinishViewController *vcFinish = [storyboard instantiateViewControllerWithIdentifier:@"FinishRegisterViewController"];
        vcFinish.view.frame = CGRectMake(0, 0, self.viewFinish.frame.size.width, self.viewFinish.frame.size.height);
        vcFinish.dictGTCN = mDictGTCN;
        vcFinish.dictTKNT = mDictTKNT;
        vcFinish.phoneNumber = self.phoneNumber;
        vcFinish.delegate = self;
        [self.viewFinish addSubview:vcFinish.view];
        [self addChildViewController:vcFinish];
        
        CGPoint point = CGPointMake(self.scrollView.bounds.size.width*2, 0);
        [self.scrollView setContentOffset:point animated:YES];
        
        [self selectTKNT];
        [self selectFinish];
    }
}

- (void)selectTKNT {
    for (UILabel *label in self.labelCollectionTKNT) {
        label.textColor = RGB_COLOR(235, 13, 30);
    }
    self.labelNumberTwo.borderColor = RGB_COLOR(235, 13, 30);
    self.labelNumberTwo.backgroundColor = RGB_COLOR(235, 13, 30);
    self.labelNumberTwo.textColor = UIColor.whiteColor;
}

- (void)unselectTKNT {
    for (UILabel *label in self.labelCollectionTKNT) {
        label.textColor = RGB_COLOR(214, 217, 219);
    }
    self.labelNumberTwo.borderColor = RGB_COLOR(214, 217, 219);
    self.labelNumberTwo.backgroundColor = UIColor.whiteColor;
    self.labelNumberTwo.textColor = RGB_COLOR(214, 217, 219);
}

- (void)selectFinish {
    for (UILabel *label in self.labelCollectionFinish) {
        label.textColor = RGB_COLOR(235, 13, 30);
    }
    self.labelNumberThree.borderColor = RGB_COLOR(235, 13, 30);
    self.labelNumberThree.backgroundColor = RGB_COLOR(235, 13, 30);
    self.labelNumberThree.textColor = UIColor.whiteColor;
}

- (void)unselectFinish {
    for (UILabel *label in self.labelCollectionFinish) {
        label.textColor = RGB_COLOR(214, 217, 219);
    }
    self.labelNumberThree.borderColor = RGB_COLOR(214, 217, 219);
    self.labelNumberThree.backgroundColor = UIColor.whiteColor;
    self.labelNumberThree.textColor = RGB_COLOR(214, 217, 219);
}

#pragma mark SubviewDelegate

- (void)continueGTCN:(NSDictionary *)dictGTCN {
    canTouchTwo = YES;
    mDictGTCN = dictGTCN;
    [self selectTKNT:nil];
}

- (void)continueTKNT:(NSDictionary *)dictTKNT {
    canTouchTwo = YES;
    canTouchThree = YES;
    mDictTKNT = dictTKNT;
    [self selectFinish:nil];
}

- (void)continueFinish:(NSDictionary *)dictFinish : (NSArray *)arrayCheckSum {
    mDictFinish = dictFinish;
    mArrayCheckSum = arrayCheckSum;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    PolicyViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PolicyViewController"];
    vc.urlPolicy = @"https://vietlott.vn/vi/vietlott/lien-he";
    vc.strTitle = @"Điều khoản và điều kiện sử dụng dịch vụ Vietlott SMS";
    vc.delegate = self;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
}

- (void)agreePolicy {
    [self registerTKDT];
}

#pragma mark CallAPI

- (void)registerTKDT {
    [CallAPI callApiService:kServiceWithNoToken dictParam:mDictFinish arrayCheckSum:mArrayCheckSum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
        RegisterNotificationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterNotificationViewController"];
        vc.typeView = kRegisterSuccess;
        vc.phoneNumber = self.phoneNumber;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

@end
