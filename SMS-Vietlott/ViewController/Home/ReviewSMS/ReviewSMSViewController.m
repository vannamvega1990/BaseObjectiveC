//
//  ReviewSMSViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ReviewSMSViewController.h"
#import "ReviewSMSTableViewCell.h"
#import "BoSoObj.h"

@interface ReviewSMSViewController ()

@end

@implementation ReviewSMSViewController {
    NSMutableArray *arraySMS;
    NSMutableArray *arraySMSSelect;
    
    NSString *smsSend;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createArraySMS];
}

- (IBAction)onClickBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickBtnCancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onClickBtnBuyTicket:(id)sender {
    [self sendSMS];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ReviewSMSTableViewCell";
    ReviewSMSTableViewCell *cell = (ReviewSMSTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString *contentSMS = arraySMS[indexPath.row];
    cell.labelNumberSMS.text = [NSString stringWithFormat:@"Tin nhắn %ld",indexPath.row+1];
    cell.labelContentSMS.text = contentSMS;
    
    if ([arraySMSSelect containsObject:contentSMS]) {
        [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"checkbox_select"] forState:UIControlStateNormal];
    }else{
        [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"checkbox_unselect"] forState:UIControlStateNormal];
    }
    
    [cell.btnSelect addTarget:self action:@selector(selectSMS:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arraySMS.count;
}

- (void)selectSMS : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    NSString *contentSMS = [arraySMS objectAtIndex:hitIndex.row];
    
    if ([arraySMSSelect containsObject:contentSMS]) {
        [arraySMSSelect removeObject:contentSMS];
    }else{
        [arraySMSSelect addObject:contentSMS];
    }
    
    [self settupWarning];
    [self.tableView reloadData];
}

- (void)settupWarning {
    if (arraySMSSelect.count > 0) {
        self.btnBuyTicket.enabled = YES;
        self.btnBuyTicket.backgroundColor = RGB_COLOR(235, 13, 30);
        self.btnBuyTicket.borderColor = [UIColor clearColor];
        [self.btnBuyTicket setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (arraySMSSelect.count <= 1) {
            self.labelWarning.hidden = YES;
            self.imageWarning.hidden = YES;
        }else{
            self.labelWarning.hidden = NO;
            self.imageWarning.hidden = NO;
            self.labelWarning.text = [NSString stringWithFormat:@"Do giới hạn độ dài tin nhắn. Vui lòng thực hiện %lu lần đặt vé!! (miễn phí tin nhắn) ",(unsigned long)arraySMSSelect.count];
        }
    }else{
        self.btnBuyTicket.enabled = NO;
        self.btnBuyTicket.backgroundColor = RGB_COLOR(255, 255, 255);
        self.btnBuyTicket.borderColor = RGB_COLOR(214, 217, 219);
        [self.btnBuyTicket setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
    }
}

- (void)createArraySMS {
    arraySMS = [NSMutableArray array];
    arraySMSSelect = [NSMutableArray array];
    
    for (NSManagedObject *obj in self.arrayTicket) {
        NSString *strNumber = [obj valueForKey:@"numbers"];
        NSArray *array = [strNumber componentsSeparatedByString:@"#"];
        NSMutableArray *arrayContent = [NSMutableArray array];
        
        for (NSString *str in array) {
            BoSoObj *boSoObj = [[BoSoObj alloc] initWithString:str error:nil];
            if (obj) {
                [arrayContent addObject:[self createContentSMS:boSoObj:obj]];
            }
        }
        
        NSString *strContentSMS = [arrayContent componentsJoinedByString:@"\n"];
        [arraySMS addObject:strContentSMS];
        [arraySMSSelect addObject:strContentSMS];
    }
    [self settupWarning];
    [self.tableView reloadData];
}

- (NSString *)createContentSMS : (BoSoObj *)boSoObj : (NSManagedObject *)obj {
    NSMutableArray *arrayNumber = [NSMutableArray array];
    for (NSString *str in boSoObj.arrNumber) {
        if (str.length == 1) {
            [arrayNumber addObject:[@"0" stringByAppendingString:str]];
        }else if (str.length == 2) {
            [arrayNumber addObject:str];
        }
    }
    
    NSString *maSanPham = [obj valueForKey:@"type_vietlott"];
    NSString *kyDuThuong = [[obj valueForKey:@"id_ky_quay"] stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSString *phuongThucThanhToan = [NSString stringWithFormat:@"%d",self.typePayment];
    NSString *cachChoi = [NSString stringWithFormat:@"%d",boSoObj.type.quantitySelectNumber];
    NSString *boSoDuThuong = [arrayNumber componentsJoinedByString:@","];
    boSoDuThuong = [boSoDuThuong stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *price = [NSString stringWithFormat:@"%lld",boSoObj.price];
    
    NSString *sms = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@",kMaDaiLy,maSanPham,kyDuThuong,phuongThucThanhToan,cachChoi,boSoDuThuong,price];
    
    return sms;
}

- (void)resetArraySMS {
    [arraySMSSelect removeObject:smsSend];
    [arraySMS removeObject:smsSend];
    [self settupWarning];
    [self.tableView reloadData];
    
    if (arraySMSSelect.count == 0) {
        [self performSelector:@selector(finishBuyTicket) withObject:nil afterDelay:1.0];
    }
}

- (void)finishBuyTicket {
    [Utils alertError:@"Thông báo" content:@"Hoàn thành đặt mua vé" viewController:self completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

#pragma mark SMS

- (void)sendSMS {
    if ([MFMessageComposeViewController canSendText])
    {
        NSLog(@"Send SMS");
        NSArray *recipents = @[@"9969"];
        smsSend = arraySMSSelect[0];
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setRecipients:recipents];
        [messageController setBody:smsSend];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
    }
    else {
        NSLog(@"SMS Error");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result {
    
    switch (result) {
        case MessageComposeResultCancelled:{
            NSLog(@"Loi");
            [self resetArraySMS];
        }
            break;
            
        case MessageComposeResultFailed:
        {
            [Utils alertError:@"Error" content:@"Failed to send SMS!" viewController:self completion:^{
                
            }];
            break;
        }
            
        case MessageComposeResultSent:{
            NSLog(@"Da gui");
        }
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
