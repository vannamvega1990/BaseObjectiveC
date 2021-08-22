//
//  SelectGameViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SelectGameViewController.h"
#import "SelectGameTableViewCell.h"

@interface SelectGameViewController ()

@end

@implementation SelectGameViewController {
    NSArray *arrayVietlott;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settupView];
}

- (void)settupView {
    [self.tableView addSubview:self.refreshControl];
    
    [self getListGames];
}

- (void)setHeightTableView {
    CGSize tableViewSize = self.tableView.contentSize;
    
    if (tableViewSize.height < [UIScreen mainScreen].bounds.size.height - 80) {
        self.heightTableView.constant = tableViewSize.height - 40;
    }else{
        self.heightTableView.constant = [UIScreen mainScreen].bounds.size.height - 80;
    }
}

- (void)handleRefresh : (id)sender{
    arrayVietlott = [NSArray array];
    [self.tableView reloadData];
    [self getListGames];
    [self.refreshControl endRefreshing];
}

- (IBAction)closeView:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [self.delegate selectGameFinish:@{}];
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SelectGameTableViewCell";
    SelectGameTableViewCell *cell = (SelectGameTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = [Utils converDictRemoveNullValue:arrayVietlott[indexPath.row]];
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dict[@"game_logo"]]];
    [cell.imageGame sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"logo"]];
    cell.labelNameGame.text = [NSString stringWithFormat:@"%@",dict[@"game_name"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayVietlott.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [Utils converDictRemoveNullValue:arrayVietlott[indexPath.row]];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [self.delegate selectGameFinish:dict];
}

#pragma mark CallAPI

- (void)getListGames {
    NSArray *check_sum = @[@"API0028_get_games"
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0028_get_games"
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        if ([dictData[@"info"] isKindOfClass:[NSArray class]]) {
            NSArray *arrayGames = dictData[@"info"];
            NSMutableArray *arrayGamesAvailable = [NSMutableArray array];
            for (NSDictionary *dict in arrayGames) {
                if ([[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
                    [arrayGamesAvailable addObject:dict];
                }
            }
            self->arrayVietlott = arrayGamesAvailable;
            self.labelNotice.hidden = self->arrayVietlott.count > 0;
        }
        [self.tableView reloadData];
        [self performSelector:@selector(setHeightTableView) withObject:nil afterDelay:1.0];
    }];
}

@end
