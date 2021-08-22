//
//  ChonCachChoiDialogViewController.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ChonCachChoiDialogViewController.h"
#import "SelectTicketTypeTableViewCell.h"
#import "TicketTypeObj.h"

@interface ChonCachChoiDialogViewController (){
    
}
  
@end

@implementation ChonCachChoiDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initTableView];
}

- (IBAction)onClickDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) initTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectTicketTypeTableViewCell" bundle:nil]
    forCellReuseIdentifier:@"SelectTicketTypeTableViewCell"];
}



#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SelectTicketTypeTableViewCell";
    SelectTicketTypeTableViewCell *cell = (SelectTicketTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
   
    TicketTypeObj *ticketType = [_arrItems objectAtIndex:indexPath.row];
    cell.lblContent.text = ticketType.name;
    
    if ( _selectedTicketType != nil && _selectedTicketType.typeId == ticketType.typeId) {
         cell.imgRadio.image = [UIImage imageNamed:@"btn_radio_selected"];
    } else {
        cell.imgRadio.image = [UIImage imageNamed:@"btn_radio_unselect"];
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
    _selectedTicketType = self.arrItems[indexPath.row];
    [tableView reloadData];
    [self.delegate onSelectedLoaiVe:_selectedTicketType from:self];
    //[self dismissViewControllerAnimated:true completion:nil];
    
    
}


@end
