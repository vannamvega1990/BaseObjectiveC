//
//  GioHang645TableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/23/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "GioHangTableViewCell.h"
#import "BoSoObj.h"

@implementation GioHangTableViewCell {
    NSMutableArray *arrayBoSo;
    TicketTypeObj *selectedTicketType;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setData:(NSManagedObject *) obj {
    NSString *strNumber = [obj valueForKey:@"numbers"];
    NSArray *array = [strNumber componentsSeparatedByString:@"#"];
    arrayBoSo = [NSMutableArray array];
    for (NSString *str in array) {
        
        BoSoObj *obj = [[BoSoObj alloc] initWithString:str error:nil];
        if (obj) {
            selectedTicketType = obj.type;
            [arrayBoSo addObject:obj];
        }else{
            NSLog(@"Loi");
        }
    }
    
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    
    CGSize tableViewSize = self.tableView.contentSize;
    self.heightViewTicket.constant = tableViewSize.height + 10;
    self.tableView.scrollEnabled = NO;
}

//Các delegate của Mega645 và Power655
- (void)onFavouriteAction:(BOOL)isFavourite atIndexPath:(NSIndexPath *)indexPath {
    BoSoObj *ticket = arrayBoSo[indexPath.row];
    ticket.isFavorited = isFavourite;
    [self.tableView reloadData];
}

- (void)onDeleteAction:(BOOL)isDeleted atIndexPath:(NSIndexPath *)indexPath {
    BoSoObj *obj = arrayBoSo[indexPath.row];
    NSString *content = [NSString stringWithFormat:@"Bạn chắc chắn muốn xóa bộ số %@",obj.name];
    if (arrayBoSo.count == 1) {
        content = @"Bạn chắc chắn muốn xóa vé này khỏi giỏ hàng";
    }
    
    [Utils alert:@"Thông báo" content:content titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:nil completion:^{
        [self.delegate onDeleteActionIndexPath:self.indexPath atSubIndexPath:indexPath];
    }];
}

- (void)onRandomAction : (BOOL) isSelected atIndexPath:(NSIndexPath*) indexPath {
   
}

//CLick các nut trên cell 3D

- (void)deleteBoso: (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    
    BoSoObj *obj = arrayBoSo[hitIndex.row];
    NSString *content = [NSString stringWithFormat:@"Bạn chắc chắn muốn xóa bộ số %@",obj.name];
    if (arrayBoSo.count == 1) {
        content = @"Bạn chắc chắn muốn xóa vé này khỏi giỏ hàng";
    }
    
    [Utils alert:@"Thông báo" content:content titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:nil completion:^{
        [self.delegate onDeleteActionIndexPath:self.indexPath atSubIndexPath:hitIndex];
    }];
}

- (void)addToFavorite : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:hitPoint];
    
    BoSoObj *ticket = arrayBoSo[indexPath.row];
    ticket.isFavorited = !ticket.isFavorited;
    
    [self.tableView reloadData];
}

- (void)selectPrice : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];

    [self.delegate onSelectPriceActionIndexPath:self.indexPath atSubIndexPath:hitIndex];
}

#pragma mark TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BoSoObj *item = [arrayBoSo objectAtIndex:indexPath.row];
    
    if (selectedTicketType.quantitySelectNumber == 6) { //ve thuong bao 6
        static NSString *cellIdentifier = @"UserTicketNormalTableViewCell";
        UserTicketNormalTableViewCell *cell = (UserTicketNormalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if (selectedTicketType.quantitySelectNumber == 5) { //bao 5
        static NSString *cellIdentifier = @"UserTicketBao5TableViewCell";
        UserTicketBao5TableViewCell *cell = (UserTicketBao5TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if (selectedTicketType.quantitySelectNumber == 7) { //bao 7
        static NSString *cellIdentifier = @"UserTicketBao7TableViewCell";
        UserTicketBao7TableViewCell *cell = (UserTicketBao7TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    }  else if ((selectedTicketType.quantitySelectNumber >= 8) && (selectedTicketType.quantitySelectNumber <= 12)) { //bao 7
        static NSString *cellIdentifier = @"UserTicketBao12TableViewCell";
        UserTicketBao12TableViewCell *cell = (UserTicketBao12TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if ((selectedTicketType.quantitySelectNumber >= 13) && (selectedTicketType.quantitySelectNumber <= 18)) {
        static NSString *cellIdentifier = @"UserTicketBao18TableViewCell";
        UserTicketBao18TableViewCell *cell = (UserTicketBao18TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if (selectedTicketType.quantitySelectNumber == 3) {
        static NSString *cellIdentifier = @"Max3DTableViewCell";
        Max3DTableViewCell *cell = (Max3DTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setData:item];
        
        [cell.btnRandom addTarget:self action:@selector(deleteBoso:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnFavorite addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPrice addTarget:self action:@selector(selectPrice:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    } else if (selectedTicketType.quantitySelectNumber == 4) {
        static NSString *cellIdentifier = @"Max4DTableViewCell";
        Max4DTableViewCell *cell = (Max4DTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setData:item];
        
        [cell.btnRandom addTarget:self action:@selector(deleteBoso:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnFavorite addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPrice addTarget:self action:@selector(selectPrice:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayBoSo.count;
}


@end
