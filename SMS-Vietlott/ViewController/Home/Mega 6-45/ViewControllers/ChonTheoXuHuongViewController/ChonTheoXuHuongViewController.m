//
//  ChonTheoXuHuongViewController.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ChonTheoXuHuongViewController.h"
#import <UIKit/UIKit.h>
#import "ChonSoCollectionViewCell.h"
#import "Utils.h"
#import "UserTicketNormalTableViewCell.h"
#import "UserTicketBao5TableViewCell.h"
#import "UserTicketBao7TableViewCell.h"
#import "UserTicketBao18TableViewCell.h"
#import "UserTicketBao12TableViewCell.h"


@interface ChonTheoXuHuongViewController ()<UITableViewDelegate, UITableViewDataSource, UserTicketCellDelegate>

@end

@implementation ChonTheoXuHuongViewController {
    NSMutableArray *arrTicketXuHuong;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init selected tickets list
    if(self.arrSelectedTickets == nil) {
        self.arrSelectedTickets = [[NSMutableArray alloc] init];
    } else {
        [self.arrSelectedTickets removeAllObjects];
    }
    
    arrTicketXuHuong = [[NSMutableArray alloc] init];
    
    //init data or call api
    [self initData];
    
    [self initUI];
}

- (IBAction)onClickClose:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)onClickbtnHelp:(id)sender {
    
}

- (IBAction)onClickXacnhan:(id)sender {
    
    for(int i = 0; i< self.arrSelectedTickets.count; i++){
        
        BoSoObj *ticket = self.arrSelectedTickets[i];
        switch (i) {
            case 0:
                ticket.name = @"A";
                break;
            case 1:
                ticket.name = @"B";
                break;
            case 2:
                ticket.name = @"C";
                break;
            case 3:
                ticket.name = @"D";
                break;
            case 4:
                ticket.name = @"E";
                break;
            case 5:
                ticket.name = @"F";
                break;
            default:
                break;
        }
    }
    
    if(self.delegate != nil){
        [self.delegate selectTicketSuccess:self.arrSelectedTickets];
    }
    
}


- (void) initUI {
    [self getDataByTab];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSString*) validateTickets {
    
    for(int i = 0; i < self.arrTickets.count; i++){
        int ticketNumberMax = self.ticketType.quantitySelectNumber;
        BoSoObj *ticket = self.arrTickets[i];
        
        if([ticket isAddingNumber] && ![ticket isValidNumber]){
            return [NSString stringWithFormat:@"Vé %@ chưa chọn đủ %d số",ticket.name, ticketNumberMax];
        }
    }
    
    return @"";
}

- (void) getDataByTab {
    
    if(self.arrTickets == nil) {
        self.arrTickets = [[NSMutableArray alloc] init];
    } else {
        [self.arrTickets removeAllObjects];
    }
    
    self.arrTickets = [arrTicketXuHuong mutableCopy];
    [self.tableView reloadData];
}

- (void) initData {
    //init data tab mua nhieu
    [arrTicketXuHuong removeAllObjects];
    BoSoObj *item;
    for(int i = 0; i < 20; i++){
        item = [[BoSoObj alloc] init];
        
        item.name = @"";
        item.price = 10000;
        item.type = _ticketType;
        item.isFavorited = FALSE;
        
        for(int i = 0; i < self.ticketType.quantitySelectNumber; i++){
            NSUInteger randomNumber = arc4random() % 45;
            NSString *number = [NSString stringWithFormat:@"%lu",(unsigned long)randomNumber];
            item.arrNumber[i] = number;
        }
        
        [arrTicketXuHuong addObject:item];
    }
}

// -MARK: process delegates
- (void)onFavouriteAction:(BOOL)isFavourite atIndexPath:(NSIndexPath *)indexPath {
    BoSoObj *ticket = self.arrTickets[indexPath.row];
    ticket.isFavorited = isFavourite;
    [self.tableView reloadData];
}

- (void)onSelectAction:(BOOL)isSelected atIndexPath:(NSIndexPath *)indexPath {
    if(isSelected) {
        [self addTicketToSelectedList:self.arrTickets[indexPath.row]];
    } else {
        [self removeTicketFromSelectedList:self.arrTickets[indexPath.row]];
    }
    [self.tableView reloadData];
}

- (BOOL) isSelected: (BoSoObj*) ticket{
    for(int i= 0; i< self.arrSelectedTickets.count; i++){
        BoSoObj *item = self.arrSelectedTickets[i];
        
        if(item.arrNumber == ticket.arrNumber){
            return TRUE;
        }
    }
    return FALSE;
}

- (void) addTicketToSelectedList: (BoSoObj*) ticket {
    
    //check max so luong ve
    if (self.arrSelectedTickets.count == self.ticketType.quantitySelectNumber) {
        NSString *errorMessage = [NSString stringWithFormat:@"Bạn đã chọn đủ số vé của loại %@",self.ticketType.name];
        
        [Utils alertError:@"Thông báo" content:errorMessage viewController:self completion:^{
            
        }];
        return;
    }
    
    BOOL isAdded = false;
    for(int i= 0; i< self.arrSelectedTickets.count; i++){
        BoSoObj *item = self.arrSelectedTickets[i];
        
        if(item.arrNumber == ticket.arrNumber){
            isAdded = TRUE;
            break;
        }
    }
    
    if(!isAdded){
        [self.arrSelectedTickets addObject:ticket];
    }
}

- (void) removeTicketFromSelectedList: (BoSoObj*) ticket {
    int index = -1;
    for(int i= 0; i< self.arrSelectedTickets.count; i++){
        BoSoObj *item = self.arrSelectedTickets[i];
        
        if(item.arrNumber == ticket.arrNumber){
            index = i;
            break;
        }
    }
    if(index != -1){
        [self.arrSelectedTickets removeObjectAtIndex:index];
    }
}


// -MARK: table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BoSoObj *item = [_arrTickets objectAtIndex:indexPath.row];
    
    if ([item.type.typeId isEqualToString:@"6"]) { //ve thuong bao 6
        static NSString *cellIdentifier = @"UserTicketNormalTableViewCell";
        UserTicketNormalTableViewCell *cell = (UserTicketNormalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        item.isSelected = [self isSelected:item];
        [cell setDataChonTicket:item];
        
        return cell;
    } else if ([item.type.typeId isEqualToString:@"5"]) { //bao 5
        static NSString *cellIdentifier = @"UserTicketBao5TableViewCell";
        UserTicketBao5TableViewCell *cell = (UserTicketBao5TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        item.isSelected = [self isSelected:item];
        [cell setDataChonTicket:item];
        
        return cell;
    } else if ([item.type.typeId isEqualToString:@"7"]) { //bao 7
        static NSString *cellIdentifier = @"UserTicketBao7TableViewCell";
        UserTicketBao7TableViewCell *cell = (UserTicketBao7TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        item.isSelected = [self isSelected:item];
        [cell setDataChonTicket:item];
        
        return cell;
    }  else if ([item.type.typeId isEqualToString:@"8"]
                || [item.type.typeId isEqualToString:@"9"]
                || [item.type.typeId isEqualToString:@"10"]
                || [item.type.typeId isEqualToString:@"11"]
                || [item.type.typeId isEqualToString:@"12"]) { //bao 7
        static NSString *cellIdentifier = @"UserTicketBao12TableViewCell";
        UserTicketBao12TableViewCell *cell = (UserTicketBao12TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        item.isSelected = [self isSelected:item];
        [cell setDataChonTicket:item];
        
        return cell;
    } else if ([item.type.typeId isEqualToString:@"13"]
               || [item.type.typeId isEqualToString:@"14"]
               || [item.type.typeId isEqualToString:@"15"]
               || [item.type.typeId isEqualToString:@"18"]) {
        static NSString *cellIdentifier = @"UserTicketBao18TableViewCell";
        UserTicketBao18TableViewCell *cell = (UserTicketBao18TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        item.isSelected = [self isSelected:item];
        [cell setDataChonTicket:item];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.ticketType.typeId isEqualToString:@"5"]
       || [self.ticketType.typeId isEqualToString:@"6"]
       || [self.ticketType.typeId isEqualToString:@"7"]) {
        return 55;
    }
    
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrTickets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
