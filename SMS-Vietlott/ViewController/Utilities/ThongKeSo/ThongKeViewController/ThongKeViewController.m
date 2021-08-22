//
//  ThongKeViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/4/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ThongKeViewController.h"
#import "ThongKeTableViewCell.h"

@interface ThongKeViewController ()

@end

@implementation ThongKeViewController {
    NSArray *arrayFavorite;
    NSString *strStartDate;
    NSString *strEndDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    strStartDate = @"";
    strEndDate = @"";
    [self getListFavorite];
    
    [self.tableView addSubview:self.refreshControl];
    
    if ([self.gameId isEqualToString:idMega645]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectDateThongKeMega object:nil];
    }else if ([self.gameId isEqualToString:idPower655]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectDateThongKePower object:nil];
    }else if ([self.gameId isEqualToString:idMax3D]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectDateThongKeMax3D object:nil];
    }else if ([self.gameId isEqualToString:idMax4D]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectDateThongKeMax4D object:nil];
    }
}

- (void)handleRefresh : (id)sender{
    arrayFavorite = [NSArray array];
    [self.tableView reloadData];
    
    [self getListFavorite];
    [self.refreshControl endRefreshing];
}

// MARK: table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ThongKeTableViewCell";
    ThongKeTableViewCell *cell = (ThongKeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = [arrayFavorite objectAtIndex:indexPath.row];
    
    cell.labelNumber.text = [NSString stringWithFormat:@"%@",dict[@"num"]];
    cell.labelQuantity.text = [NSString stringWithFormat:@"%@",dict[@"number_of_num"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayFavorite.count;
}

#pragma mark CallAPI

- (void)getListFavorite {
    NSArray *check_sum = @[@"API0034_statistics_common_winning_numbers",
                           self.gameId,
                           strStartDate,
                           strEndDate
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0034_statistics_common_winning_numbers",
                                @"game_id":self.gameId,
                                @"start_date":strStartDate,
                                @"end_date":strEndDate
                                    
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        
        self->arrayFavorite = dictData[@"info"];
        self.labelNotice.hidden = self->arrayFavorite.count != 0;
        [self.tableView reloadData];
    }];
}

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectDateThongKeMega] ||
              [notif.name isEqualToString:kNotificationNameSelectDateThongKePower] ||
              [notif.name isEqualToString:kNotificationNameSelectDateThongKeMax3D] ||
              [notif.name isEqualToString:kNotificationNameSelectDateThongKeMax4D]) {
        
        strStartDate = notif.userInfo[@"start"];
        strEndDate = notif.userInfo[@"end"];
        [self getListFavorite];
    }
}

@end
