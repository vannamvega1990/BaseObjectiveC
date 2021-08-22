//
//  NewsViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "NewsViewController.h"
#import "HomeNewsTableViewCell.h"
#import "DetailNewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController {
    NSMutableArray *arrayNews;
    int page;
    BOOL isCanLoadMore;
    NSDictionary *dictFirstNew;
    BOOL isSettupView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if (isSettupView == NO) {
        isSettupView = YES;
        arrayNews = [NSMutableArray array];
        page = 1;
        [self getListNews];
        [self.tableView addSubview:self.refreshControl];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectDateNews object:nil];
    }
}

- (void)handleRefresh : (id)sender{
    arrayNews = [NSMutableArray array];
    page = 1;
    dictFirstNew = nil;
    [self.tableView reloadData];
    
    [self getListNews];
    [self.refreshControl endRefreshing];
}

- (IBAction)showFirstNews:(id)sender {
    if (dictFirstNew.count > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailNewsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNewsViewController"];
        vc.dictNews = dictFirstNew;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HomeNewsTableViewCell";
    HomeNewsTableViewCell *cell = (HomeNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = [arrayNews objectAtIndex:indexPath.row];
    
    cell.labelContent.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    cell.labelDateTime.text = [NSString stringWithFormat:@"%@",dict[@"create_time"]];
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dict[@"img_link"]]];
    [cell.labelImageNews sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"news"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayNews.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == arrayNews.count-1 && isCanLoadMore) {
        page++;
        [self getListNews];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailNewsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNewsViewController"];
    vc.dictNews = [arrayNews objectAtIndex:indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark CallAPI

- (void)getListNews {
    NSArray *check_sum = @[@"API0029_search_news",
                           @"",
                           [NSString stringWithFormat:@"%d",page],
                           @"10",
                           [NSString stringWithFormat:@"%lu",(unsigned long)self.typeNews],
                           self.date
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0029_search_news",
                                @"content":@"",
                                @"page":[NSString stringWithFormat:@"%d",page],
                                @"line_in_page":@"10",
                                @"type":[NSString stringWithFormat:@"%lu",(unsigned long)self.typeNews],
                                @"date":self.date
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *array = dictData[@"info"];
        [self->arrayNews addObjectsFromArray:array];
        self->isCanLoadMore = array.count >= 10;
        
        if (self->arrayNews.count > 0) {
            self->dictFirstNew = self->arrayNews[0];
            [self fillFirstNews:self->arrayNews[0]];
            [self->arrayNews removeObjectAtIndex:0];
        }else{
            [self fillFirstNews:@{}];
        }
        
        [self.tableView reloadData];
    }];
}

- (void)fillFirstNews : (NSDictionary *)dictNews {
    if (dictNews.count > 0) {
        self.viewFirstNews.hidden = NO;
        
        self.labelTitleFirstNews.text = [NSString stringWithFormat:@"%@",dictNews[@"title"]];
        self.labelContentFirstNews.text = [NSString stringWithFormat:@"%@",dictNews[@"describle"]];
        self.labelDateFirstNews.text = [NSString stringWithFormat:@"%@",dictNews[@"create_time"]];
        
        NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dictNews[@"img_link"]]];
        [self.imageFirstNews sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"news"]];
    }else{
        self.viewFirstNews.hidden = NO;
        self.labelTitleFirstNews.text = @"không có tin tức";
        self.labelContentFirstNews.text = @"";
        self.labelDateFirstNews.text = @"";
        self.imageFirstNews.image = [UIImage imageNamed:@""];
    }
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectDateNews]) {
        self.date = notif.object;
        [self handleRefresh:nil];
    }
}

@end
