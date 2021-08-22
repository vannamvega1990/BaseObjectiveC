//
//  ListNotificationViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/14/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ListNotificationViewController.h"
#import "ListNotificationTableViewCell.h"
#import "DetailNotificationOtherViewController.h"
#import "DetailNotificationSelectNumberViewController.h"

@interface ListNotificationViewController ()

@end

@implementation ListNotificationViewController {
    NSMutableArray *arrayNotifi;
    BOOL isCanLoadMore;
    int page;
    
    BOOL isSearch;
    NSMutableArray *arraySearch;
    
    int unread;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
    
    [self.tableView addSubview:self.refreshControl];
}

- (void)settupView {
    arrayNotifi = [NSMutableArray array];
    page = 1;
    [self getListNotification];
}

- (void)handleRefresh : (id)sender {
    [self settupView];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (IBAction)searchNotification:(id)sender {
    if ([Utils lenghtText:self.textFieldSearch.text] == 0) {
        isSearch = NO;
    }else{
        isSearch = YES;
        [self getListSearch];
    }
    
    [self.tableView reloadData];
}

- (IBAction)readAll:(id)sender {
    if (unread > 0) {
        [Utils alert:@"Thông báo" content:@"Bạn chắc chắn muốn đánh dấu đã đọc tất cả các thông báo?" titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:self completion:^{
            NSMutableArray *arrayId = [NSMutableArray array];
            for (NSDictionary *dict in self->arrayNotifi) {
                if (![[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
                    [arrayId addObject:[NSString stringWithFormat:@"%@",dict[@"id"]]];
                }
            }
            [self setAllNotificationIsRead:[arrayId componentsJoinedByString:@"#"]];
        }];
    }
}

- (void)getNumberUnread {
    unread = 0;
    for (NSDictionary *dict in arrayNotifi) {
        if (![[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
            unread++;
        }
    }
    self.labelTotal.text = [NSString stringWithFormat:@"Số thông báo chưa đọc (%d)",unread];
}

- (void)getListSearch {
    arraySearch = [NSMutableArray array];
    NSString *strSearch = [self.textFieldSearch.text uppercaseString];
    strSearch = [Utils changeVietNamese:strSearch];
    
    for (NSDictionary *dict in arrayNotifi) {
        NSString *titleNoti = [[Utils changeVietNamese:[NSString stringWithFormat:@"%@",dict[@"title"]]] uppercaseString];
        NSString *contentNoti = [[Utils changeVietNamese:[NSString stringWithFormat:@"%@",dict[@"short_content"]]] uppercaseString];
        
        if ([titleNoti containsString:strSearch] || [contentNoti containsString:strSearch]) {
            [arraySearch addObject:dict];
        }
    }
}

#pragma mark - tableview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ListNotificationTableViewCell";
    ListNotificationTableViewCell *cell = (ListNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict;
    
    if (isSearch) {
        dict = arraySearch[indexPath.row];
    }else{
        dict = arrayNotifi[indexPath.row];
    }
    
    cell.labelTitle.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    cell.labelContent.text = [NSString stringWithFormat:@"%@",dict[@"short_content"]];
    cell.labelTime.text = [NSString stringWithFormat:@"%@",dict[@"time_create"]];
    
    UIImage *placeholderImage;
    if ([[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
        placeholderImage = [UIImage imageNamed:@"mail_open"];
        cell.labelTitle.textColor = RGB_COLOR(117, 117, 117);
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
    }else{
        placeholderImage = [UIImage imageNamed:@"mail"];
        cell.labelTitle.textColor = RGB_COLOR(33, 33, 33);
        cell.labelTitle.font = [UIFont boldSystemFontOfSize:15];
    }
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dict[@"img_link"]]];
    [cell.imageNotifi sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:placeholderImage];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch) {
        return arraySearch.count;
    }else{
        return arrayNotifi.count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = arrayNotifi[indexPath.row];
    [self setNotificationIsRead:dict :indexPath];
    
    int type = [[NSString stringWithFormat:@"%@",dict[@"type"]] intValue];
    switch (type) {
        case 1://Tin thông báo
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            DetailNotificationOtherViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationOtherViewController"];
            vc.dictNotification = dict;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2://Tin trả thưởng
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            DetailNotificationOtherViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationOtherViewController"];
            vc.dictNotification = dict;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3://Tin trúng thưởng
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            DetailNotificationOtherViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationOtherViewController"];
            vc.dictNotification = dict;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 4://Chọn số thành công
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            DetailNotificationSelectNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationSelectNumberViewController"];
            vc.dictNotification = dict;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            DetailNotificationOtherViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNotificationOtherViewController"];
            vc.dictNotification = dict;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == arrayNotifi.count-1 && isCanLoadMore) {
        page++;
        [self getListNotification];
    }
}

#pragma mark CallAPI

- (void)getListNotification {
    NSArray *check_sum = @[@"API0025_get_list_notify",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%d",page],
                           @"10"
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0025_get_list_notify",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"page":[NSString stringWithFormat:@"%d",page],
                                @"line_in_page":@"10"
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *array = dictData[@"info"];
        [self->arrayNotifi addObjectsFromArray:array];
        self->isCanLoadMore = array.count >= 10;
        
        self.labelNotice.hidden = self->arrayNotifi.count != 0;
        [self getNumberUnread];
        
        if (self->isSearch) {
            [self getListSearch];
        }
        [self.tableView reloadData];
    }];
}

- (void)setNotificationIsRead : (NSDictionary *)dictNotifi : (NSIndexPath *)indexPath {
    NSString *strID = [NSString stringWithFormat:@"%@",dictNotifi[@"id"]];
    NSArray *check_sum = @[@"API0026_update_seen_notifys",
                           [VariableStatic sharedInstance].phoneNumber,
                           strID
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0026_update_seen_notifys",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"notify_ids":strID
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSDictionary *dict = @{@"id":[NSString stringWithFormat:@"%@",dictNotifi[@"id"]],
                               @"title":[NSString stringWithFormat:@"%@",dictNotifi[@"title"]],
                               @"short_content":[NSString stringWithFormat:@"%@",dictNotifi[@"short_content"]],
                               @"time_create":[NSString stringWithFormat:@"%@",dictNotifi[@"time_create"]],
                               @"img_link":[NSString stringWithFormat:@"%@",dictNotifi[@"img_link"]],
                               @"status":@"1",
                               };
        
        if (self->isSearch) {
            [self->arraySearch replaceObjectAtIndex:indexPath.row withObject:dict];
        }else{
            [self->arrayNotifi replaceObjectAtIndex:indexPath.row withObject:dict];
        }
        
        [self getNumberUnread];
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReadNotification object:nil];
    }];
}

- (void)setAllNotificationIsRead : (NSString *)strID {
    NSArray *check_sum = @[@"API0026_update_seen_notifys",
                           [VariableStatic sharedInstance].phoneNumber,
                           strID
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0026_update_seen_notifys",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"notify_ids":strID
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [self settupView];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReadNotification object:nil];
    }];
}

@end
