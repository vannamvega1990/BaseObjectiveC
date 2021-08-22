//
//  BoSoYeuThichViewController.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "BoSoYeuThichViewController.h"
#import <UIKit/UIKit.h>
#import "ChonSoCollectionViewCell.h"
#import "Utils.h"
#import "BoSoYeuThichTableViewCell.h"
#import "GroupBoSoObj.h"


@interface BoSoYeuThichViewController ()

@end

@implementation BoSoYeuThichViewController {
    NSArray *arrayFavorite;
    NSMutableArray *arraySelectFavorite;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init data or call api
//    [self initData];
    
    [self initUI];
}

- (IBAction)onClickbtnHelp:(id)sender {
    
}

- (IBAction)onClickXacnhan:(id)sender {
    [self.delegate selectFavouriteTicketGroup:arraySelectFavorite];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    arraySelectFavorite = [NSMutableArray array];
    self.btnXacNhan.enabled = NO;
    self.btnXacNhan.alpha = 0.6;
    
    [self.tableView addSubview:self.refreshControl];
    
    [self getListFavorite];
}

- (void)handleRefresh : (id)sender{
    arrayFavorite = [NSArray array];
    arraySelectFavorite = [NSMutableArray array];
    self.btnXacNhan.enabled = NO;
    self.btnXacNhan.alpha = 0.6;
    [self.tableView reloadData];
    
    [self getListFavorite];
    [self.refreshControl endRefreshing];
}

// MARK: table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BoSoYeuThichTableViewCell";
    BoSoYeuThichTableViewCell *cell = (BoSoYeuThichTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = arrayFavorite[indexPath.row];
    [cell setData:dict];
    
    if ([arraySelectFavorite containsObject:dict]) {
        [cell.btnSelect setImage:[UIImage imageNamed:@"checkbox_select"] forState:UIControlStateNormal];
    }else{
        [cell.btnSelect setImage:[UIImage imageNamed:@"checkbox_unselect"] forState:UIControlStateNormal];
    }
    
    cell.labelIndex.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    [cell.btnSelect addTarget:self action:@selector(onClickBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayFavorite.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)onClickBtnSelect : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    
    NSDictionary *dict = arrayFavorite[hitIndex.row];
    
    if ([arraySelectFavorite containsObject:dict]) {
        [arraySelectFavorite removeObject:dict];
        [self.tableView reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        if (arraySelectFavorite.count >= 6) {
            [Utils alertError:@"Thông báo" content:@"Vui lòng chọn tối đa 6 bộ số yêu thích" viewController:self completion:^{
                
            }];
        }else{
            [arraySelectFavorite addObject:dict];
            [self.tableView reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
    self.btnXacNhan.enabled = arraySelectFavorite.count > 0;
    self.btnXacNhan.alpha = arraySelectFavorite.count > 0 ? 1 : 0.6;
}

#pragma mark CallAPI

- (void)getListFavorite {
        NSArray *check_sum = @[@"API0037_get_favorite_numbers",
                               [VariableStatic sharedInstance].phoneNumber,
                               self.ticketType.gameId,
                               self.ticketType.typeId
                               ];
        
        NSDictionary *dictParam = @{@"KEY":@"API0037_get_favorite_numbers",
                                    @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                    @"game_id":self.ticketType.gameId,
                                    @"type_play_id":self.ticketType.typeId
                                    };

        [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
            
            if ([self.ticketType.typeId isEqualToString:idMax3DOm]) {
                NSMutableArray *array = [NSMutableArray array];
                
                NSArray *arrayResult = dictData[@"info"];
                for (NSDictionary *dict in arrayResult) {
                    NSString *strNumber = [NSString stringWithFormat:@"%@",dict[@"favorite_numbers"]];
                    if ([self getViTriOm:strNumber] == self.viTriOm) {
                        [array addObject:dict];
                    }
                }
                self->arrayFavorite = array;
            }else{
                self->arrayFavorite = dictData[@"info"];
            }
            self.labelNoti.hidden = self->arrayFavorite.count != 0;
            [self.tableView reloadData];
        }];
}

- (int)getViTriOm : (NSString *)strNumber {
    int viTriOm = 0;
    for (int i=0; i < strNumber.length; i++) {
        NSString *tmp_str = [strNumber substringWithRange:NSMakeRange(i, 1)];
        if ([tmp_str isEqualToString:@"*"]) {
            viTriOm = i;
            break;
        }
    }
    return viTriOm;
}

@end
