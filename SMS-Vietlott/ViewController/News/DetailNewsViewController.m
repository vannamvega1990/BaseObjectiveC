//
//  DetailNewsViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "HomeNewsTableViewCell.h"

@interface DetailNewsViewController ()

@end

@implementation DetailNewsViewController {
    BOOL isWebFirstReload;
    
    NSMutableArray *arrayNews;
    int page;
    BOOL isCanLoadMore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fillInfo];
}

- (void)fillInfo {
    self.webview.scrollView.delegate = self;
    self.webview.navigationDelegate = self;
    
    self.labelTitleNews.text = [NSString stringWithFormat:@"%@",_dictNews[@"title"]];
    self.labelTimeNews.text = [NSString stringWithFormat:@"%@",_dictNews[@"create_time"]];
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",_dictNews[@"img_link"]]];
    [self.imageNews sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"news"]];
    
    NSString *strContent = [NSString stringWithFormat:@"%@",self.dictNews[@"content"]];
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=0.0, user-scalable=no'></header>";
    NSString *htmlStr = [headerString stringByAppendingString:strContent];
    [self.webview loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
    
    arrayNews = [NSMutableArray array];
    page = 1;
    [self getListNews];
    
    [self.scrollView setContentOffset: CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webview evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (result != nil) {
            [self.webview evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable height, NSError * _Nullable error) {
                self.heightWebview.constant = [height floatValue] ;
            }];
        }
    }];
}

- (void)setHeightTableView {
    CGSize tableViewSize = self.tableView.contentSize;
    self.heightTableView.constant = tableViewSize.height + 10;
    self.tableView.scrollEnabled = NO;
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
    NSDictionary *dict = [arrayNews objectAtIndex:indexPath.row];
    
    [arrayNews replaceObjectAtIndex:indexPath.row withObject:self.dictNews];
    self.dictNews = dict;
    [self fillInfo];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == arrayNews.count-1 && isCanLoadMore) {
        page++;
        [self getListNews];
    }
}

#pragma mark CallAPI

- (void)getListNews {
    NSArray *check_sum = @[@"API0029_search_news",
                           @"",
                           [NSString stringWithFormat:@"%d",page],
                           @"10",
                           [NSString stringWithFormat:@"%@",self.dictNews[@"type"]],
                           @""
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0029_search_news",
                                @"content":@"",
                                @"page":[NSString stringWithFormat:@"%d",page],
                                @"line_in_page":@"10",
                                @"type":[NSString stringWithFormat:@"%@",self.dictNews[@"type"]],
                                @"date":@""
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *array = dictData[@"info"];
        [self->arrayNews addObjectsFromArray:array];
        self->isCanLoadMore = array.count >= 10;
        
        if (self->arrayNews.count == 0) {
            self.tableView.hidden = YES;
        }else{
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            [self performSelector:@selector(setHeightTableView) withObject:nil afterDelay:1.0];
        }
        
        [self.tableView reloadData];
    }];
}

@end
