//
//  ResultMega645ViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/19/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ResultMega645ViewController.h"
#import "ResultMega645TableViewCell.h"
#import "ResultDetailMega645ViewController.h"

@interface ResultMega645ViewController ()

@end

@implementation ResultMega645ViewController {
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
    static NSString *cellIdentifier = @"ResultMega645TableViewCell";
    ResultMega645TableViewCell *cell = (ResultMega645TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dictResult = [arrayResult objectAtIndex:indexPath.row];
    [cell setDataWithResult:dictResult atIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayResult.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([VariableStatic sharedInstance].isLogin) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Results" bundle:nil];
        ResultDetailMega645ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ResultDetailMega645ViewController"];
        vc.dictResult = [arrayResult objectAtIndex:indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
                           idMega645,
                           [NSString stringWithFormat:@"%d",page],
                           [NSString stringWithFormat:@"%d",line]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0031_get_result_by_game",
                                @"id":idMega645,
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
