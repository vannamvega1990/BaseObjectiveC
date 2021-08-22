//
//  SearchNewsViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/15/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SearchNewsViewController.h"
#import "HomeNewsTableViewCell.h"
#import "DetailNewsViewController.h"

@interface SearchNewsViewController ()

@end

@implementation SearchNewsViewController {
    NSArray *arrayNews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textFieldSearch.delegate = self;
    [self.tableView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:true];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.textFieldSearch becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:false];
}

- (void)handleRefresh : (id)sender{
    arrayNews = [NSArray array];
    [self.tableView reloadData];
    [self getListNews];
    [self.refreshControl endRefreshing];
}

- (IBAction)goBackView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldSearch) {
        [self.textFieldSearch resignFirstResponder];
        [self getListNews];
        
        return NO;
    }
    return YES;
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
    
    cell.labelContent.text = [NSString stringWithFormat:@"%@",dict[@"describle"]];
    cell.labelDateTime.text = [NSString stringWithFormat:@"%@",dict[@"create_time"]];
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dict[@"img_link"]]];
    [cell.labelImageNews sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"news"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayNews.count;
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
                           self.textFieldSearch.text,
                           @"1",
                           @"100",
                           @"",
                           @""
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0029_search_news",
                                @"content":self.textFieldSearch.text,
                                @"page":@"1",
                                @"line_in_page":@"100",
                                @"type":@"",
                                @"date":@""
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        self->arrayNews = dictData[@"info"];
        if (self->arrayNews.count > 0) {
            self.labelNotice.hidden = YES;
        }else{
            self.labelNotice.hidden = NO;
        }
        
        [self.tableView reloadData];
    }];
}

@end
