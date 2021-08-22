//
//  FavoriteNumbersViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "FavoriteNumbersViewController.h"
#import "BoSoYeuThichTableViewCell.h"
#import "CreateFavotiteNumberViewController.h"
#import "CreateMax3dFavoriteNumberViewController.h"
#import "CreateMax4dFavoriteNumberViewController.h"

@interface FavoriteNumbersViewController ()

@end

@implementation FavoriteNumbersViewController {
    NSArray *arrayFavorite;
    NSMutableArray *arraySelectFavorite;
    NSMutableArray *deleteIndexPaths;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    arraySelectFavorite = [NSMutableArray array];
    [self setBtnDeleteEnable:NO];
    
    [self getListFavorite];
    
    [self.tableView addSubview:self.refreshControl];
    
    if ([self.gameId isEqualToString:idMega645]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectAllFavoriteMega object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameAddFavoriteMegaSuccess object:nil];
    }else if ([self.gameId isEqualToString:idPower655]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectAllFavoritePower object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameAddFavoritePowerSuccess object:nil];
    }else if ([self.gameId isEqualToString:idMax3D]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectAllFavoriteMax3D object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameAddFavoriteMax3DSuccess object:nil];
    }else if ([self.gameId isEqualToString:idMax4D]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectAllFavoriteMax4D object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameAddFavoriteMax4DSuccess object:nil];
    }
    
}

- (void)setBtnDeleteEnable : (BOOL) enable {
    if (enable == YES) {
        self.btnDelete.enabled = YES;
        self.btnDelete.backgroundColor = RGB_COLOR(235, 13, 30);
        self.btnDelete.borderColor = [UIColor clearColor];
        [self.btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.btnDelete.enabled = NO;
        self.btnDelete.backgroundColor = RGB_COLOR(255, 255, 255);
        self.btnDelete.borderColor = RGB_COLOR(214, 217, 219);
        [self.btnDelete setTitleColor:RGB_COLOR(214, 217, 219) forState:UIControlStateNormal];
    }
}

- (void)handleRefresh : (id)sender{
    arrayFavorite = [NSArray array];
    arraySelectFavorite = [NSMutableArray array];
    [self setBtnDeleteEnable:NO];
    [self.tableView reloadData];
    
    [self getListFavorite];
    [self.refreshControl endRefreshing];
}

- (IBAction)deleteFavorite:(id)sender {
    [Utils alert:@"Thông báo" content:@"Bạn chắc chắn muốn xóa bộ số yêu thích" titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:self completion:^{
        [self removeFromFavorite];
    }];
}

- (IBAction)addFavorite:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    
    if ([self.gameId isEqualToString:idMega645]) {
        CreateFavotiteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateFavotiteNumberViewController"];
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.gameId isEqualToString:idPower655]) {
        CreateFavotiteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateFavotiteNumberViewController"];
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.gameId isEqualToString:idMax3D]) {
        CreateMax3dFavoriteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateMax3dFavoriteNumberViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.gameId isEqualToString:idMax4D]) {
        CreateMax4dFavoriteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateMax4dFavoriteNumberViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    NSDictionary *dict = arrayFavorite[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    
    if ([self.gameId isEqualToString:idMega645]) {
        CreateFavotiteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateFavotiteNumberViewController"];
        vc.type = 0;
        vc.dictEdit = dict;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.gameId isEqualToString:idPower655]) {
        CreateFavotiteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateFavotiteNumberViewController"];
        vc.type = 1;
        vc.dictEdit = dict;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.gameId isEqualToString:idMax3D]) {
        CreateMax3dFavoriteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateMax3dFavoriteNumberViewController"];
        vc.dictEdit = dict;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.gameId isEqualToString:idMax4D]) {
        CreateMax4dFavoriteNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateMax4dFavoriteNumberViewController"];
        vc.dictEdit = dict;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)onClickBtnSelect : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    
    NSDictionary *dict = arrayFavorite[hitIndex.row];
    
    if ([arraySelectFavorite containsObject:dict]) {
        [arraySelectFavorite removeObject:dict];
        [self.tableView reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationNone];
        [deleteIndexPaths removeObject:hitIndex];
    }else{
        [arraySelectFavorite addObject:dict];
        [self.tableView reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationNone];
        [deleteIndexPaths addObject:hitIndex];
    }
    [self setBtnDeleteEnable:arraySelectFavorite.count > 0];
}

#pragma mark CallAPI

- (void)getListFavorite {
    NSArray *check_sum = @[@"API0037_get_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.gameId,
                           @""
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0037_get_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"game_id":self.gameId,
                                @"type_play_id":@""
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        
        self->arrayFavorite = dictData[@"info"];
        self.labelNotice.hidden = self->arrayFavorite.count != 0;
        [self.tableView reloadData];
    }];
}

- (void)removeFromFavorite {
    NSMutableArray *arrayIdFavorite = [NSMutableArray array];
    for (NSDictionary *dict in arraySelectFavorite) {
        [arrayIdFavorite addObject:[NSString stringWithFormat:@"%@",dict[@"id"]]];
    }
    
    NSArray *check_sum = @[@"API0038_delete_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           [arrayIdFavorite componentsJoinedByString:@"#"]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0038_delete_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"id":[arrayIdFavorite componentsJoinedByString:@"#"]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [Utils alertError:@"Thông báo" content:@"Xóa bộ số yêu thích thành công" viewController:self completion:^{
            [self getListFavorite];
        }];
    }];
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectAllFavoriteMega] ||
        [notif.name isEqualToString:kNotificationNameSelectAllFavoritePower] ||
        [notif.name isEqualToString:kNotificationNameSelectAllFavoriteMax3D] ||
        [notif.name isEqualToString:kNotificationNameSelectAllFavoriteMax4D]) {
        arraySelectFavorite = [NSMutableArray arrayWithArray:arrayFavorite];
        [self setBtnDeleteEnable:YES];
        [self.tableView reloadData];
    }else if ([notif.name isEqualToString:kNotificationNameAddFavoriteMegaSuccess] ||
              [notif.name isEqualToString:kNotificationNameAddFavoritePowerSuccess] ||
              [notif.name isEqualToString:kNotificationNameAddFavoriteMax3DSuccess] ||
              [notif.name isEqualToString:kNotificationNameAddFavoriteMax4DSuccess]) {
        [self getListFavorite];
    }
}


@end
