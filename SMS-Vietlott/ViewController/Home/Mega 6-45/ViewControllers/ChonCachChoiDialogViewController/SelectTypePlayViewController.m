//
//  SelectTypePlayViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/21/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SelectTypePlayViewController.h"
#import "CommonSelectTableViewCell.h"

@interface SelectTypePlayViewController ()

@end

@implementation SelectTypePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onClickDismiss:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CommonSelectTableViewCell";
    CommonSelectTableViewCell *cell = (CommonSelectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    TicketTypeObj *ticketType = [_arrItems objectAtIndex:indexPath.row];
    cell.labelType.text = ticketType.name;
    
    if ( _selectedTicketType != nil && _selectedTicketType.typeId == ticketType.typeId) {
        cell.imageSelect.image = [UIImage imageNamed:@"btn_radio_selected"];
    } else {
        cell.imageSelect.image = [UIImage imageNamed:@"btn_radio_unselect"];
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedTicketType = self.arrItems[indexPath.row];
    [self.delegate onSelectedLoaiVe:_selectedTicketType];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
