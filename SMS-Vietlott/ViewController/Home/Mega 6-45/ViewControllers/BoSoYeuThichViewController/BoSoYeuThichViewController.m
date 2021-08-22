//
//  BoSoYeuThichViewController.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "BoSoYeuThichViewController.h"
#import <UIKit/UIKit.h>
#import "ChonSoCollectionViewCell.h"
#import "Utils.h"
#import "FavoriteTicketBao6TableViewCell.h"
#import "FavoriteTicketBao5TableViewCell.h"
#import "FavoriteTicketBao7TableViewCell.h"
#import "FavoriteTicketBao18TableViewCell.h"
#import "FavoriteTicketBao12TableViewCell.h"
#import "GroupBoSoObj.h"


@interface BoSoYeuThichViewController ()<UITableViewDelegate, UITableViewDataSource, UserTicketCellDelegate>

@end

@implementation BoSoYeuThichViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    NSMutableArray *selectedTicket;
    for(int i=0; i < self.arrTicketGroups.count; i++){
        GroupBoSoObj *group = self.arrTicketGroups[i];
        if(group.isSelected){
            selectedTicket = group.arrTickets;
        }
    }
    
    if(selectedTicket != nil) {
        if(self.delegate != nil){
            [self.delegate selectFavouriteTicketGroup:selectedTicket];
        }
        [self.navigationController popViewControllerAnimated:TRUE];
    } else {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn bộ số!" viewController:self completion:^{
            
        }];
    }
    
}

- (void)onSelectAction:(BOOL)isSelected atIndexPath:(NSIndexPath *)indexPath{
    for(int i=0; i < self.arrTicketGroups.count; i++){
        GroupBoSoObj *group = self.arrTicketGroups[i];
        if(i == indexPath.section){
            [group setSelected:isSelected];
        } else {
            [group setSelected:FALSE];
        }
    }
    
    [self.tableView reloadData];
}


- (void) initUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void) initData {
    //init data tab mua nhieu
    if(self.arrTicketGroups == nil) {
        self.arrTicketGroups = [[NSMutableArray alloc] init];
    } else {
        [self.arrTicketGroups removeAllObjects];
    }
    
    GroupBoSoObj *group;
    for(int i= 0; i< 10; i++){
        group = [[GroupBoSoObj alloc] init];
        group.groupId = [NSString stringWithFormat:@"%d",i];
        
        NSMutableArray *arrTickets = [NSMutableArray array];
        BoSoObj *item;
        for(int i = 0; i < self.ticketType.numberTicketofGroup; i++){
            item = [[BoSoObj alloc] init];
            
            switch (i) {
                case 0:
                    item.name = @"A";
                    break;
                case 1:
                    item.name = @"B";
                    break;
                case 2:
                    item.name = @"C";
                    break;
                case 3:
                    item.name = @"D";
                    break;
                case 4:
                    item.name = @"E";
                    break;
                case 5:
                    item.name = @"F";
                    break;
                default:
                    break;
            }
            
            item.price = 10000;
            item.type = _ticketType;
            item.isFavorited = FALSE;
            
            for(int i = 0; i < self.ticketType.number; i++){
                NSUInteger randomNumber = arc4random() % 45;
                NSString *number = [NSString stringWithFormat:@"%lu",(unsigned long)randomNumber];
                item.arrNumber[i] = number;
            }
            
            [arrTickets addObject:item];
        }
        group.arrTickets = arrTickets;
        [self.arrTicketGroups addObject:group];
    }
}


// -MARK: table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GroupBoSoObj *group = self.arrTicketGroups[indexPath.section];
    BoSoObj *item = [group.arrTickets objectAtIndex:indexPath.row];
    
    if ([item.type.typeId isEqualToString:@"6"]) { //ve thuong bao 6
        static NSString *cellIdentifier = @"FavoriteTicketBao6TableViewCell";
        FavoriteTicketBao6TableViewCell *cell = (FavoriteTicketBao6TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if ([item.type.typeId isEqualToString:@"5"]) { //bao 5
        static NSString *cellIdentifier = @"FavoriteTicketBao5TableViewCell";
        FavoriteTicketBao5TableViewCell *cell = (FavoriteTicketBao5TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if ([item.type.typeId isEqualToString:@"7"]) { //bao 7
        static NSString *cellIdentifier = @"FavoriteTicketBao7TableViewCell";
        FavoriteTicketBao7TableViewCell *cell = (FavoriteTicketBao7TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    }  else if ([item.type.typeId isEqualToString:@"8"]
                || [item.type.typeId isEqualToString:@"9"]
                || [item.type.typeId isEqualToString:@"10"]
                || [item.type.typeId isEqualToString:@"11"]
                || [item.type.typeId isEqualToString:@"12"]) { //bao 7
        static NSString *cellIdentifier = @"FavoriteTicketBao12TableViewCell";
        FavoriteTicketBao12TableViewCell *cell = (FavoriteTicketBao12TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if ([item.type.typeId isEqualToString:@"13"]
               || [item.type.typeId isEqualToString:@"14"]
               || [item.type.typeId isEqualToString:@"15"]
               || [item.type.typeId isEqualToString:@"18"]) {
        static NSString *cellIdentifier = @"FavoriteTicketBao18TableViewCell";
        FavoriteTicketBao18TableViewCell *cell = (FavoriteTicketBao18TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
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
    GroupBoSoObj *group = self.arrTicketGroups[section];
    return group.arrTickets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrTicketGroups.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    return line;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger) section{
    if(section == 0){
        return 1;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    return line;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

}

@end
