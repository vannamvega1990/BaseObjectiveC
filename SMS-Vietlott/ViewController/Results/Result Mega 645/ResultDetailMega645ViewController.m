//
//  ResultDetailMega645ViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ResultDetailMega645ViewController.h"
#import "Mega645ViewController.h"

@interface ResultDetailMega645ViewController ()

@end

@implementation ResultDetailMega645ViewController {
    NSArray *arrayNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDataWithResult];
}

- (void)setDataWithResult {
    NSString *strResult = [NSString stringWithFormat:@"%@",self.dictResult[@"set_of_number"]];
    NSArray *arrayResult = [strResult componentsSeparatedByString:@","];
    
    for (int i=0; i<arrayResult.count; i++) {
        for (MyLabel *label in self.arrayLabelNumber) {
            if (label.tag == i) {
                label.text = arrayResult[i];
            }
        }
    }
    
    self.labelKyQuay.text = [Utils getKyFromDict:self.dictResult];
    
    [self getListNumberHistory];
}

- (void)settupView {
    if (arrayNumber.count == 0) {
        self.viewNoTicket.hidden = NO;
        
        self.viewWinningTicket.hidden = YES;
        self.heightWinningTicket.constant = 0;
        
        self.viewHaveTicket.hidden = YES;
    }else{
        self.viewNoTicket.hidden = YES;
        self.heightViewNoTicket.constant = 0;
        
        self.viewWinningTicket.hidden = YES;
        self.heightWinningTicket.constant = 0;
        
        self.viewHaveTicket.hidden = NO;
    }
}

- (IBAction)selectNumberForNextTimes:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    Mega645ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Mega645ViewController"];
    vc.type = 0;
    vc.dictGame = @{@"id":idMega645,
                    @"game_image":@"home_mega645",
                    @"next_period_time":@""
                    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showHistorySelectNumber:(id)sender {
    
}

- (IBAction)buyAgainThisNumber:(id)sender {
    
}

#pragma mark CallAPI

- (void)getListNumberHistory {
    NSArray *check_sum = @[@"API0033_get_ticket_in_period",
                           [VariableStatic sharedInstance].phoneNumber,
                           idMega645,
                           [NSString stringWithFormat:@"%@",self.dictResult[@"cycle_code"]]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0033_get_ticket_in_period",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"game_id":idMega645,
                                @"id":[NSString stringWithFormat:@"%@",self.dictResult[@"cycle_code"]]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        self->arrayNumber = dictData[@"info"];
        [self settupView];
    }];
}

@end
