//
//  Max3DSelectPriceViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/7/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "Max3DSelectPriceViewController.h"
#import "CommonSelectTableViewCell.h"
#import "Utils.h"

@interface Max3DSelectPriceViewController ()

@end

@implementation Max3DSelectPriceViewController {
    NSArray *arrayPrice;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrayPrice = @[@"10000",@"20000",@"50000",@"100000",@"200000",@"500000",@"1000000"];
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
    
    
    cell.labelType.text = [Utils strCurrency:arrayPrice[indexPath.row]];
    
    if ( [arrayPrice[indexPath.row] longLongValue] == self.currentPrice) {
        cell.imageSelect.image = [UIImage imageNamed:@"btn_radio_selected"];
    } else {
        cell.imageSelect.image = [UIImage imageNamed:@"btn_radio_unselect"];
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayPrice.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate onSelectedPrice:[arrayPrice[indexPath.row] longLongValue]:self.selectIndex];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
