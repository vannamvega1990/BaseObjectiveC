//
//  ChonKyQuayDialogViewController.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ChonKyQuayDialogViewController.h"
#import "CommonSelectTableViewCell.h"
#import "TicketTypeObj.h"

@interface ChonKyQuayDialogViewController (){
    
}
  
@end

@implementation ChonKyQuayDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
   
    CommonSelectionObj *item = [_arrItems objectAtIndex:indexPath.row];
    NSString *day = [Utils getDayName:[Utils getDateFromStringDate:item.name]];
    cell.labelType.text = [NSString stringWithFormat:@"Kỳ %@ - %@, %@",item.idKyQuay,day, item.name];
    
    if ( _selectedItem != nil && _selectedItem.name == item.name) {
         cell.imageSelect.image = [UIImage imageNamed:@"btn_radio_selected"];
    } else {
        cell.imageSelect.image = [UIImage imageNamed:@"btn_radio_unselect"];
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedItem = self.arrItems[indexPath.row];
    [self.delegate onSelectedKyQuay:_selectedItem];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}


@end
