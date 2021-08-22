//
//  GioHangViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/23/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "GioHangViewController.h"
#import "GioHangTableViewCell.h"
#import "SelectTypePaymentViewController.h"

@interface GioHangViewController ()

@end

@implementation GioHangViewController {
    NSMutableArray *arrayTickets;
    NSIndexPath *currentSubIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDataFromCoreData];
}

- (IBAction)closeView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)empty:(id)sender {
    [Utils alert:@"Thông báo" content:@"Bạn có chắc chắn muốn xóa tất cả vé trong giỏ hàng?" titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:nil completion:^{
        NSManagedObjectContext *managedObjContext = [self managedObjectContext];
        for (NSManagedObject *ticket in self->arrayTickets) {
            [managedObjContext deleteObject:ticket];
        }
        NSError *error = nil;
        if (![managedObjContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }else{
            self->arrayTickets = [NSMutableArray array];
            self.labelNotice.hidden = NO;
            [self getTotalPrice];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameUpdateCart object:nil];
        }
    }];
}

- (IBAction)payment:(id)sender {
    if ([Utils isLogin]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SelectTypePaymentViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectTypePaymentViewController"];
        vc.arrayTickets = arrayTickets;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [Utils alert:@"Thông báo" content:@"Vui lòng đăng nhập để sử dụng chức năng này" titleOK:@"Đăng nhập" titleCancel:@"Để sau" viewController:nil completion:^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            [[self appDelegate].window setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]];
            [[self appDelegate].window makeKeyAndVisible];
        }];
    }
}

- (void)getDataFromCoreData {
    NSManagedObjectContext *managedObjContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Tickets"];
    arrayTickets = [[managedObjContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    self.labelNotice.hidden = arrayTickets.count != 0;
    [self getTotalPrice];
    [self.tableView reloadData];
    
    [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:1.0];
}

- (void)reloadTableView {
    [self.tableView reloadData];
}

- (void)deleteTicket:(id)sender {
    [Utils alert:@"Thông báo" content:@"Bạn chắc chắn muốn xóa vé này khỏi giỏ hàng?" titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:nil completion:^{
        CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
        NSManagedObject *ticket = [self->arrayTickets objectAtIndex:hitIndex.row];
        
        NSManagedObjectContext *managedObjContext = [self managedObjectContext];
        [managedObjContext deleteObject:ticket];
        
        NSError *error = nil;
        if (![managedObjContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }else{
            [self->arrayTickets removeObjectAtIndex:hitIndex.row];
            [self getTotalPrice];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameUpdateCart object:nil];
        }
    }];
}

- (void)getTotalPrice {
    long long totalPrice = 0;
    
    for (NSManagedObject *obj in arrayTickets) {
        long long price = [[obj valueForKey:@"price"] longLongValue];
        totalPrice += price;
    }
    
    self.labelTotal.text = [[Utils strCurrency:[NSString stringWithFormat:@"%lld",totalPrice]] stringByAppendingString:@"đ"];
}

#pragma mark TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"GioHang645TableViewCell";
    GioHangTableViewCell *cell = (GioHangTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSManagedObject *obj = arrayTickets[indexPath.row];
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.imageVietlott.image = [UIImage imageNamed:[obj valueForKey:@"image"]];
    cell.labelNumberTicket.text = [NSString stringWithFormat:@"Vé %ld:",(long)indexPath.row+1];
    cell.labelPrice.text = [[Utils strCurrency:[obj valueForKey:@"price"]] stringByAppendingString:@"đ"];
    
    NSString *day = [Utils getDayName:[Utils getDateFromStringDate:[obj valueForKey:@"date"]]];
    NSString *date = [obj valueForKey:@"date"];
    NSString *idKyQuay = [obj valueForKey:@"id_ky_quay"];
    NSString *name = [obj valueForKey:@"type_ticket"];
    cell.labelDate.text = [NSString stringWithFormat:@"%@, %@ - %@ - %@",day,date,idKyQuay,name];
    [cell setData:obj];
    
    [cell.btnDelete addTarget:self action:@selector(deleteTicket:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayTickets.count;
}

//Delegate xóa bộ số
- (void)onDeleteActionIndexPath:(NSIndexPath *)indexPath atSubIndexPath:(NSIndexPath *)subIndexPath {
    NSManagedObjectContext *managedObjContext = [self managedObjectContext];
    
    NSManagedObject *ticket = [self->arrayTickets objectAtIndex:indexPath.row];
    
    NSString *strNumber = [ticket valueForKey:@"numbers"];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[strNumber componentsSeparatedByString:@"#"]];
    [array removeObjectAtIndex:subIndexPath.row];
    
    if (array.count > 0) {
        NSString *numbers = [array componentsJoinedByString:@"#"];
        [ticket setValue:numbers forKey:@"numbers"];
        
        int totalPrice = [self updateTotalPrice : ticket];
        [ticket setValue:[NSString stringWithFormat:@"%d",totalPrice] forKey:@"price"];
        
        NSError *error = nil;
        if (![managedObjContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }else{
            [self->arrayTickets replaceObjectAtIndex:indexPath.row withObject:ticket];
            [self getTotalPrice];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameUpdateCart object:nil];
        }
    }else{
        [managedObjContext deleteObject:ticket];
        
        NSError *error = nil;
        if (![managedObjContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }else{
            [self->arrayTickets removeObjectAtIndex:indexPath.row];
            [self getTotalPrice];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameUpdateCart object:nil];
        }
    }
}

- (int)updateTotalPrice : (NSManagedObject *)ticket {
    int totalPrice = 0;
    
    NSString *strNumber = [ticket valueForKey:@"numbers"];
    NSArray *array = [strNumber componentsSeparatedByString:@"#"];
    
    for (NSString *str in array) {
        BoSoObj *obj = [[BoSoObj alloc] initWithString:str error:nil];
        if (obj) {
            TicketTypeObj *ticketType = obj.type;
            if (ticketType.quantitySelectNumber == 3) {
                totalPrice += obj.price * obj.quantityNumber;
            }else if (ticketType.quantitySelectNumber == 4) {
                totalPrice += obj.price * obj.quantityNumber;
            }else{
                totalPrice += ticketType.price;
            }
        }
    }
    
    return totalPrice;
}

//Delegate chọn lại giá vé
- (void)onSelectPriceActionIndexPath:(NSIndexPath *)indexPath atSubIndexPath:(NSIndexPath *)subIndexPath {
    NSManagedObject *obj = [self->arrayTickets objectAtIndex:indexPath.row];
    NSString *strNumber = [obj valueForKey:@"numbers"];
    NSArray *array = [strNumber componentsSeparatedByString:@"#"];
    NSMutableArray *arrayBoSo = [NSMutableArray array];
    for (NSString *str in array) {
        BoSoObj *obj = [[BoSoObj alloc] initWithString:str error:nil];
        if (obj) {
            [arrayBoSo addObject:obj];
        }
    }
    
    BoSoObj *ticket = [arrayBoSo objectAtIndex:subIndexPath.row];
    currentSubIndexPath = subIndexPath;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Max3D" bundle:nil];
    Max3DSelectPriceViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Max3DSelectPriceViewController"];
    vc.delegate = self;
    vc.currentPrice = ticket.price;
    vc.selectIndex = indexPath;
    [[[self appDelegate] window] addSubview:vc.view];
    [[[self appDelegate] window].rootViewController addChildViewController:vc];
}

- (void)onSelectedPrice:(long long)price :(NSIndexPath *)hitIndex {
    NSManagedObject *ticket = [self->arrayTickets objectAtIndex:hitIndex.row];
    NSString *strNumber = [ticket valueForKey:@"numbers"];
    NSArray *array = [strNumber componentsSeparatedByString:@"#"];
    NSMutableArray *arrayBoSo = [NSMutableArray array];
    for (NSString *str in array) {
        BoSoObj *obj = [[BoSoObj alloc] initWithString:str error:nil];
        if (obj) {
            [arrayBoSo addObject:obj];
        }
    }
    
    BoSoObj *boSoObj = [arrayBoSo objectAtIndex:currentSubIndexPath.row];
    boSoObj.price = price;
    
    [arrayBoSo replaceObjectAtIndex:currentSubIndexPath.row withObject:boSoObj];
    
    NSMutableArray *newArray = [NSMutableArray array];
    for (BoSoObj *obj in arrayBoSo) {
        if ([obj isValidNumber]) {
            NSString *str = [obj toJSONString];
            [newArray addObject:str];
        }
    }
    NSString *numbers = [newArray componentsJoinedByString:@"#"];
    [ticket setValue:numbers forKey:@"numbers"];
    
    int totalPrice = [self updateTotalPrice : ticket];
    [ticket setValue:[NSString stringWithFormat:@"%d",totalPrice] forKey:@"price"];
    
    NSManagedObjectContext *managedObjContext = [self managedObjectContext];
    NSError *error = nil;
    if (![managedObjContext save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }else{
        [self->arrayTickets replaceObjectAtIndex:hitIndex.row withObject:ticket];
        [self getTotalPrice];
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameUpdateCart object:nil];
    }
}

@end
