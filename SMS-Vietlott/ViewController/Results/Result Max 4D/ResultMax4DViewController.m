//
//  ResultMax4DViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ResultMax4DViewController.h"

@interface ResultMax4DViewController ()

@end

@implementation ResultMax4DViewController {
    int page;
    int line;
    BOOL isCanLoadMore;
    NSMutableArray *arrayResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    page = 1;
    line = 10;
    arrayResult = [NSMutableArray array];
    
    [self getListResult];
    
    [self.tableView addSubview:self.refreshControl];
}

- (void)handleRefresh : (id)sender {
    page = 1;
    arrayResult = [NSMutableArray array];
    [self.tableView reloadData];
    
    [self getListResult];
    [self.refreshControl endRefreshing];
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ResultMax4DTableViewCell";
    ResultMax4DTableViewCell *cell = (ResultMax4DTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = [arrayResult objectAtIndex:indexPath.row];
    [cell setDataWithResult:dict];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayResult.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([VariableStatic sharedInstance].isLogin) {
        
    }else{
        [Utils showAlertLogin];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == arrayResult.count-1 && isCanLoadMore) {
        page++;
        [self getListResult];
    }
}

#pragma mark CallAPI

- (void)getListResult {
    NSArray *check_sum = @[@"API0031_get_result_by_game",
                           idMax4D,
                           [NSString stringWithFormat:@"%d",page],
                           [NSString stringWithFormat:@"%d",line]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0031_get_result_by_game",
                                @"id":idMax4D,
                                @"page":[NSString stringWithFormat:@"%d",page],
                                @"line_in_page":[NSString stringWithFormat:@"%d",line]
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *result = dictData[@"info"];
        [self->arrayResult addObjectsFromArray:result];
        self->isCanLoadMore = result.count >= 10;
        self.labelNote.hidden = self->arrayResult.count > 0;
        [self.tableView reloadData];
    }];
}

@end
