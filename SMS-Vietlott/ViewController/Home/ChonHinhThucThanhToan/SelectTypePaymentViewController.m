//
//  SelectTypepayMentViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/23/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SelectTypePaymentViewController.h"
#import "SelectBankViewController.h"
#import "ReviewSMSViewController.h"
#import "ManageTKTTViewController.h"

@interface SelectTypePaymentViewController ()

@end

@implementation SelectTypePaymentViewController {
    NSDictionary *dictBank;
    CGFloat currentHeightViewOrther;
    int typePayment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getTotalPrice];
    [self settupView];
}

- (void)settupView {
    currentHeightViewOrther = self.heightViewOther.constant;
    typePayment = 0;
    
    NSString *hmut = [NSString stringWithFormat:@"%@",[VariableStatic sharedInstance].dictUserInfo[@"tkdt_han_muc"]];
    self.labelHMUT.text = [@"Số dư: " stringByAppendingString:[[Utils strCurrency: hmut] stringByAppendingString:@"đ"]];
    
    NSArray *arrayTKTT = [VariableStatic sharedInstance].dictUserInfo[@"list_tktt"];
    if (arrayTKTT.count == 0) {
        self.viewOther.hidden = YES;
        self.heightViewOther.constant = 0;
    }else{
        self.viewOther.hidden = NO;
        self.heightViewOther.constant = currentHeightViewOrther;
        
        for (NSDictionary *dict in arrayTKTT) {
            int status = [dict[@"status"] intValue];
            if (status != 0) {
                dictBank = dict;
                self.heightViewOther.constant = currentHeightViewOrther;
                self.labelNameOther.text = dictBank[@"bank_name"];
                //            self.labelBenefitOther.text = [Utils convertHTML:[Utils fixUnicode:dictBank[@"benefit"]]];
                
                NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dictBank[@"bank_image"]]];
                [self.imageAvatarOther sd_setImageWithURL:[NSURL URLWithString:linkImage]];
                break;
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameChoseTKTT object:nil];
}

- (IBAction)onClickBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buyMore:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)payment:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReviewSMSViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ReviewSMSViewController"];
    vc.arrayTicket = self.arrayTickets;
    vc.typePayment = typePayment;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)selectOther:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    ManageTKTTViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ManageTKTTViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chosePaymentByHMUT:(id)sender {
    typePayment = 0;
    self.imageSelectHMUT.image = [UIImage imageNamed:@"btn_radio_selected"];
    self.imageSelectOther.image = [UIImage imageNamed:@"btn_radio_unselect"];
}

- (IBAction)chosePaymentByNH:(id)sender {
    typePayment = 1;
    self.imageSelectHMUT.image = [UIImage imageNamed:@"btn_radio_unselect"];
    self.imageSelectOther.image = [UIImage imageNamed:@"btn_radio_selected"];
}

- (void)getTotalPrice {
    long long totalPrice = 0;
    
    for (NSManagedObject *obj in self.arrayTickets) {
        long long price = [[obj valueForKey:@"price"] longLongValue];
        totalPrice += price;
    }
    
    self.labelTotalPrice.text = [[Utils strCurrency:[NSString stringWithFormat:@"%lld",totalPrice]] stringByAppendingString:@"đ"];
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameChoseTKTT]) {
        dictBank = notif.object;
        if (dictBank) {
            self.viewOther.hidden = NO;
            self.heightViewOther.constant = currentHeightViewOrther;
            self.labelNameOther.text = dictBank[@"bank_name"];
            self.labelBenefitOther.text = [NSString stringWithFormat:@"%@ - %@",dictBank[@"ten_chu_tknt"],dictBank[@"so_tai_khoan_tknt"]];
            
            NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dictBank[@"bank_image"]]];;
            [self.imageAvatarOther sd_setImageWithURL:[NSURL URLWithString:linkImage]];
            
            [self chosePaymentByNH:nil];
        }
    }
    
}

@end
