//
//  Max4DSelectNumberViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/11/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "Max4DSelectNumberViewController.h"

@interface Max4DSelectNumberViewController ()

@end

@implementation Max4DSelectNumberViewController {
    int totalPrice;
    BoSoObj *currentTicket;
    NSMutableArray *arrTickets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settupView];
}

- (IBAction)btnBoSoClickWithTag:(UIButton *)sender {
    [self updateTabsbyIndex:(int)sender.tag];
}

- (IBAction)btnPriceClickWithTag:(UIButton *)sender {
    [self updatePriceWithTag:(int)sender.tag];
}

- (IBAction)btnRandomClick:(id)sender {
    [self getRandomNumber];
}

- (IBAction)btnXuHuongClick:(id)sender {
    
}

- (IBAction)btnBoSoYeuThichClick:(id)sender {
    
}

- (IBAction)btnOtherClick:(id)sender {
    
}

- (IBAction)btnResetClick:(id)sender {
    BoSoObj *ticket = arrTickets[self.selectedIndex];
    [ticket clearSelectedNumber];
    
    [currentTicket clearSelectedNumber];
    currentTicket.price = 10000;
    
    [self fillNumberWithTicket:currentTicket];
    [self updatePriceWithTag:(int)(currentTicket.price/1000)];
}

- (IBAction)btnContinueClick:(id)sender {
    if ([self checkSelectTicketSuccess]) {
        [self.delegate completeSelectNumber:arrTickets];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)selectNumberOne:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberOne];
    currentTicket.arrNumber[0] = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (IBAction)selectNumberTwo:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberTwo];
    currentTicket.arrNumber[1] = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (IBAction)selectNumberThree:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberThree];
    currentTicket.arrNumber[2] = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (IBAction)selectNumberFour:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberFour];
    currentTicket.arrNumber[3] = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (void)settupView {
    NSArray *array = [self.strTicket componentsSeparatedByString:@"#"];
    arrTickets = [NSMutableArray array];
    for (NSString *str in array) {
        BoSoObj *obj = [[BoSoObj alloc] initWithString:str error:nil];
        if (obj) {
            [arrTickets addObject:obj];
        }
    }
    
    if ([self.ticketType.typeId isEqualToString:idMax4DCuon1]){
        for (UIButton *btn in self.arrayNumberOne) {
            btn.enabled = NO;
            [btn setTitle:@"*" forState:UIControlStateNormal];
        }
    }
    
    if ([self.ticketType.typeId isEqualToString:idMax4DCuon4]){
        for (UIButton *btn in self.arrayNumberFour) {
            btn.enabled = NO;
            [btn setTitle:@"*" forState:UIControlStateNormal];
        }
    }
    
    [self updateTabsbyIndex:self.selectedIndex];
}

- (void)updateTabsbyIndex: (int) index {
    for (UIView *view in self.arrayIndicatorView) {
        if (view.tag == index) {
            view.backgroundColor = [UIColor redColor];
        }else{
            view.backgroundColor = [UIColor clearColor];
        }
    }
    
    for (UIButton *btn in self.arrayBtnBoSo) {
        if (btn.tag == index) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    
    //Update current ticket vao mang so
    if(arrTickets.count > self.selectedIndex && currentTicket != nil) {
        arrTickets[self.selectedIndex] = currentTicket;
    }
    
    //set new index + update new current ticket
    self.selectedIndex = index;
    if(arrTickets.count > self.selectedIndex) {
        currentTicket = arrTickets[self.selectedIndex];
    }
    
    [self fillNumberWithTicket:currentTicket];
    [self updatePriceWithTag:(int)(currentTicket.price/1000)];
}

- (void)updatePriceWithTag : (int)tag {
    for (MyButton *btn in self.arrayBtnPrice) {
        if (btn.tag == tag) {
            btn.backgroundColor = RGB_COLOR(235, 13, 30);
            btn.borderColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            currentTicket.price = tag*1000;
        }else{
            btn.backgroundColor = RGB_COLOR(255, 255, 255);
            btn.borderColor = RGB_COLOR(117, 117, 117);
            [btn setTitleColor:RGB_COLOR(117, 117, 117) forState:UIControlStateNormal];
        }
    }
}

- (void)selectNumberWithTag : (int)tag inArray : (NSArray *)array {
    for (UIButton *btn in array) {
        if (btn.tag == tag && btn.enabled == YES) {
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_number_selected"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_number_unselected"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

- (void)fillNumberWithTicket : (BoSoObj *)ticket {
    if (![ticket.arrNumber[0] isEqual: @""]) {
        int number = [ticket.arrNumber[0] intValue];
        [self selectNumberWithTag:number inArray:self.arrayNumberOne];
    }else{
        [self selectNumberWithTag:-1 inArray:self.arrayNumberOne];
    }
    
    if (![ticket.arrNumber[1] isEqual: @""]) {
        int number = [ticket.arrNumber[1] intValue];
        [self selectNumberWithTag:number inArray:self.arrayNumberTwo];
    }else{
        [self selectNumberWithTag:-1 inArray:self.arrayNumberTwo];
    }
    
    if (![ticket.arrNumber[2] isEqual: @""]) {
        int number = [ticket.arrNumber[2] intValue];
        [self selectNumberWithTag:number inArray:self.arrayNumberThree];
    }else{
        [self selectNumberWithTag:-1 inArray:self.arrayNumberThree];
    }
    
    if (![ticket.arrNumber[3] isEqual: @""]) {
        int number = [ticket.arrNumber[3] intValue];
        [self selectNumberWithTag:number inArray:self.arrayNumberFour];
    }else{
        [self selectNumberWithTag:-1 inArray:self.arrayNumberFour];
    }
}

- (BOOL)checkSelectTicketSuccess {
    if ([self.ticketType.typeId isEqualToString:idMax4DCuon1] || [self.ticketType.typeId isEqualToString:idMax4DCuon4]) {
        int i=0;
        for (BoSoObj *obj in arrTickets) {
            if([obj isAddingNumber]){
                int times = 0;
                NSMutableArray *arraySelectNumber = [NSMutableArray arrayWithObjects:obj.arrNumber[0],obj.arrNumber[1],obj.arrNumber[2],obj.arrNumber[3], nil];
                for (NSString *str in arraySelectNumber) {
                    if ([str isEqualToString:@""]) {
                        times++;
                    }
                }
                
                if (times > 1) {
                    NSString *content = [NSString stringWithFormat:@"Bộ số %@ chưa chọn đủ 3 số",obj.name];
                    [Utils alertError:@"Thông báo" content:content viewController:self completion:^{
                        [self updateTabsbyIndex:i];
                    }];
                    return false;
                }else{
                    if ([self.ticketType.typeId isEqualToString:idMax4DCuon1] ) {
                        obj.arrNumber[0] = @"*";
                    }
                    
                    if ([self.ticketType.typeId isEqualToString:idMax4DCuon4] ) {
                        obj.arrNumber[3] = @"*";
                    }
                }
            }
            i++;
        }
        
        return true;
    }else{
        int i=0;
        for (BoSoObj *obj in arrTickets) {
            if([obj isAddingNumber] && ![obj isValidNumber]){
                NSString *content = [NSString stringWithFormat:@"Bộ số %@ chưa chọn đủ 4 số",obj.name];
                [Utils alertError:@"Thông báo" content:content viewController:self completion:^{
                    [self updateTabsbyIndex:i];
                }];
                return false;
            }
            i++;
        }
        
        return true;
    }
}

- (void)getRandomNumber {
    NSString *number1 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    NSString *number2 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    NSString *number3 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    NSString *number4 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    
    [self selectNumberWithTag:[number1 intValue] inArray:self.arrayNumberOne];
    currentTicket.arrNumber[0] = number1;
    
    [self selectNumberWithTag:[number2 intValue] inArray:self.arrayNumberTwo];
    currentTicket.arrNumber[1] = number2;
    
    [self selectNumberWithTag:[number3 intValue] inArray:self.arrayNumberThree];
    currentTicket.arrNumber[2] = number3;
    
    [self selectNumberWithTag:[number4 intValue] inArray:self.arrayNumberFour];
    currentTicket.arrNumber[3] = number4;
    
    if ([self.ticketType.typeId isEqualToString:idMax4DCuon1]){
        currentTicket.arrNumber[0] = @"*";
    }
    
    if ([self.ticketType.typeId isEqualToString:idMax4DCuon4]){
        currentTicket.arrNumber[3] = @"*";
    }
}


@end
