//
//  XuHuongViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/5/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "XuHuongViewController.h"
#import "XuHuongTableViewCell.h"

@interface XuHuongViewController ()

@end

@implementation XuHuongViewController {
    NSArray *arrayFavorite;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settupView];
}

- (void)settupView {
    [self getListFavorite];
    [self.tableView addSubview:self.refreshControl];
}

- (void)handleRefresh : (id)sender{
    [self.tableView reloadData];
    
    [self getListFavorite];
    [self.refreshControl endRefreshing];
}

// MARK: table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"XuHuongTableViewCell";
    XuHuongTableViewCell *cell = (XuHuongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = [arrayFavorite objectAtIndex:indexPath.row];
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",self.dictGame[@"game_logo"]]];
    [cell.imageGame sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"logo"]];
    cell.labelSerial.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell setData:dict];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayFavorite.count;
}

#pragma mark CallAPI

- (void)getListFavorite {
        NSArray *check_sum = @[@"API0037_get_favorite_numbers",
                               [VariableStatic sharedInstance].phoneNumber,
                               [NSString stringWithFormat:@"%@",self.dictGame[@"id"]],
                               @""
                               ];
        
        NSDictionary *dictParam = @{@"KEY":@"API0037_get_favorite_numbers",
                                    @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                    @"game_id":[NSString stringWithFormat:@"%@",self.dictGame[@"id"]],
                                    @"type_play_id":@""
                                    };

        [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
            
            self->arrayFavorite = dictData[@"info"];
            self.labelNotice.hidden = self->arrayFavorite.count > 0;
            [self.tableView reloadData];
        }];
}

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectDateThongKeMega] ||
              [notif.name isEqualToString:kNotificationNameSelectDateThongKePower] ||
              [notif.name isEqualToString:kNotificationNameSelectDateThongKeMax3D] ||
              [notif.name isEqualToString:kNotificationNameSelectDateThongKeMax4D]) {
        
        
    }
}
@end
