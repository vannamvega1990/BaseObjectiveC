//
//  ManageTKNTViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "ManageTKNTViewController.h"
#import "ManageTKNTTableViewCell.h"
#import "CreateTKNTViewController.h"
#import "SelectBankViewController.h"
#import "EditTKNTViewController.h"

@interface ManageTKNTViewController ()

@end

@implementation ManageTKNTViewController{
    NSArray *arrayTKNT;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getListTKNT];
    
    [self.tableView addSubview:self.refreshControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameCreateTKNTSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectTKTT object:nil];
}

- (void)handleRefresh : (id)sender {
    arrayTKNT = [NSArray array];
    [self.tableView reloadData];
    [self getListTKNT];
    [self.refreshControl endRefreshing];
}

- (IBAction)createNew:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    SelectBankViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectBankViewController"];
    vc.type = tknt;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ManageTKNTTableViewCell";
    ManageTKNTTableViewCell *cell = (ManageTKNTTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dict = arrayTKNT[indexPath.row];
    
    NSString *linkImage = [NSString stringWithFormat:@"%@",dict[@"bank_image"]];
    [cell.imageAvatar sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"bank_vpbank"]];
    cell.labelChuTaiKhoan.text = dict[@"ten_chu_tknt"];
    cell.labelSoTaiKhoan.text = [self setAccountNumber:dict[@"so_tai_khoan_tknt"]];
    
    int status = [dict[@"status"] intValue];
    if (status != 0) {
        cell.btnSetDefault.hidden = YES;
        cell.viewDefault.hidden = NO;
    }else{
        cell.btnSetDefault.hidden = NO;
        cell.viewDefault.hidden = YES;
    }
    
    [cell.btnSetDefault addTarget:self action:@selector(setDefault:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self action:@selector(deleteTKNT:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnEdit addTarget:self action:@selector(editTKNT:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayTKNT.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictTKNT = arrayTKNT[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    EditTKNTViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EditTKNTViewController"];
    vc.dictTKNT = dictTKNT;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)setAccountNumber : (NSString *)number {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [number length]; i++) {
        NSString *c = [NSString stringWithFormat:@"%C", [number characterAtIndex:i]];
        [array addObject: [c uppercaseString]];
    }
    return [array componentsJoinedByString:@" "];
}

- (void)deleteTKNT : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    NSDictionary *dictTKNT = [arrayTKNT objectAtIndex:hitIndex.row];
    
    [Utils alert:@"Thông báo" content:@"Bạn chắc chắn muốn xóa tài khoản nhận thưởng này?" titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:self completion:^{
        [self callDeleteTKNT:dictTKNT];
    }];
}

- (void)setDefault : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    NSDictionary *dictTKNT = [arrayTKNT objectAtIndex:hitIndex.row];
    
    [Utils alert:@"Thông báo" content:@"Bạn chắc chắn muốn đặt tài khoản nhận thưởng này làm mặc định?" titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:self completion:^{
        [self callSetDefault:dictTKNT];
    }];
}

- (void)editTKNT : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    NSDictionary *dictTKNT = [arrayTKNT objectAtIndex:hitIndex.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    EditTKNTViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EditTKNTViewController"];
    vc.dictTKNT = dictTKNT;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark CallAPI

- (void)getListTKNT{
    NSArray *check_sum = @[@"api0015_get_tknt",
                           [VariableStatic sharedInstance].phoneNumber
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0015_get_tknt",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber
                                };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        self->arrayTKNT = dictData[@"info"];
        if (self->arrayTKNT.count == 0) {
            self.viewNoBank.hidden = NO;
            self.tableView.hidden = YES;
            self.btnAddNew.hidden = YES;
        }else{
            self.viewNoBank.hidden = YES;
            self.tableView.hidden = NO;
            self.btnAddNew.hidden = NO;
            [self.tableView reloadData];
        }
    }];
}

- (void)callDeleteTKNT : (NSDictionary *)dict {
    NSArray *check_sum = @[@"API0018_delete_bank_account",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%@",dict[@"id"]]
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0018_delete_bank_account",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"id":[NSString stringWithFormat:@"%@",dict[@"id"]],
                                };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [self getListTKNT];
    }];
}

- (void)callSetDefault : (NSDictionary *)dict {
    NSArray *check_sum = @[@"api0016_update_tknt_default",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%@",dict[@"id"]]
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0016_update_tknt_default",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"id":[NSString stringWithFormat:@"%@",dict[@"id"]],
                                };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [self getListTKNT];
    }];
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameCreateTKNTSuccess]) {
        [self getListTKNT];
    }else if ([notif.name isEqualToString:kNotificationNameSelectTKTT]) {
        NSDictionary *dictBank = notif.object;
        if (dictBank) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            CreateTKNTViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateTKNTViewController"];
            vc.dictTKTT = dictBank;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
