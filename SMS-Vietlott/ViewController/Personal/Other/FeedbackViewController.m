//
//  FeedbackViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.textViewContent becomeFirstResponder];
}

- (IBAction)sendFeedback:(id)sender {
    if ([Utils lenghtText:self.textViewContent.text] == 0) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập khiếu nạy, góp ý" viewController:self completion:^{
            [self.textViewContent becomeFirstResponder];
        }];
    }else{
        [self send];
    }
}

- (void)send {
    NSArray *check_sum = @[@"API0027_feedback",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.textViewContent.text
                           ];
    
    NSDictionary *dictParam = @{
                                @"KEY":@"API0027_feedback",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"content_feedback":self.textViewContent.text
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        
        [Utils alertError:@"Thông báo" content:@"Khiếu nại góp ý đã được gửi thành công. Xin trân thành cảm ơn" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}


@end
