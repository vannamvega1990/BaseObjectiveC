//
//  SelectBankViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/26/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SelectBankViewController.h"
#import "SelectBankCollectionViewCell.h"
#import "SelectBankHeaderCollectionReusableView.h"
#import "Utils.h"
#import "CallAPI.h"

static NSString *cellIdentifier = @"SelectBankCollectionViewCell";
static NSString *tBankLK = @"Ngân hàng liên kết";
static NSString *tBankKLK = @"Ngân hàng chỉ hỗ trợ";
static NSString *tEWalletLK = @"Ví điện tử liên kết";
static NSString *tEWalletKLK = @"Ví điện tử chỉ hỗ trợ";

@interface SelectBankViewController ()

@end

@implementation SelectBankViewController {
    NSArray *arraySectionBank;
    NSMutableDictionary *listBank;
    NSDictionary *listSectionBank;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.type) {
        case bank:
        {
            self.labelTitle.text = @"Chọn ngân hàng";
        }
            break;
            
        case eWallet:
        {
            self.labelTitle.text = @"Chọn ví điện tử";
        }
            break;
            
        case tktt:
        {
            self.labelTitle.text = @"Thêm tài khoản thanh toán";
        }
            break;
            
        case tknt:
        {
            self.labelTitle.text = @"Thêm tài khoản nhận thưởng";
        }
            break;
            
        case edit_tknt:
        {
            self.labelTitle.text = @"Sửa tài khoản nhận thưởng";
        }
            break;
            
        default:
            break;
    }
    
    [self getListBank];
}

- (void)settupArrayBank : (NSArray *)arrayBank {
    listBank = [NSMutableDictionary dictionary];
    
    switch (self.type) {
        case bank:
        {
            arraySectionBank = @[tBankLK,
                                 tBankKLK];
            
            [listBank setValue:[NSMutableArray array] forKey:tBankLK];
            [listBank setValue:[NSMutableArray array] forKey:tBankKLK];
        }
            break;
            
        case eWallet:
        {
            arraySectionBank = @[tEWalletLK,
                                 tEWalletKLK];
            
            [listBank setValue:[NSMutableArray array] forKey:tEWalletLK];
        }
            break;
            
        case tktt:
        {
            arraySectionBank = @[tBankLK,
                                 tEWalletLK];
            
            [listBank setValue:[NSMutableArray array] forKey:tBankLK];
            [listBank setValue:[NSMutableArray array] forKey:tEWalletLK];
        }
            break;
            
        case tknt:
        {
            arraySectionBank = @[tBankLK,
                                 tBankKLK,
                                 tEWalletLK,
                                 tEWalletKLK];
            
            [listBank setValue:[NSMutableArray array] forKey:tBankLK];
            [listBank setValue:[NSMutableArray array] forKey:tBankKLK];
            [listBank setValue:[NSMutableArray array] forKey:tEWalletLK];
            [listBank setValue:[NSMutableArray array] forKey:tEWalletKLK];
        }
            break;
            
        case edit_tknt:
        {
            arraySectionBank = @[tBankLK,
                                 tBankKLK,
                                 tEWalletLK,
                                 tEWalletKLK];
            
            [listBank setValue:[NSMutableArray array] forKey:tBankLK];
            [listBank setValue:[NSMutableArray array] forKey:tBankKLK];
            [listBank setValue:[NSMutableArray array] forKey:tEWalletLK];
            [listBank setValue:[NSMutableArray array] forKey:tEWalletKLK];
        }
            
        default:
            break;
    }
    
    for (NSDictionary *dict in arrayBank) {
        if ([[NSString stringWithFormat:@"%@",dict[@"type"]] isEqualToString:@"1"]) {
            if ([[NSString stringWithFormat:@"%@",dict[@"connect_vdi"]] isEqualToString:@"1"]) {
                [listBank[tBankLK] addObject:dict];
            }else{
                [listBank[tBankKLK] addObject:dict];
            }
        }else{
            if ([[NSString stringWithFormat:@"%@",dict[@"connect_vdi"]] isEqualToString:@"1"]) {
                [listBank[tEWalletLK] addObject:dict];
            }else{
                [listBank[tEWalletKLK] addObject:dict];
            }
        }
    }

    listSectionBank = @{tBankLK:@"Miễn phí nạp tiền",
                        tBankKLK:@"Phí nạp tiền 1.800đ + 1,2%",
                        tEWalletLK:@"",
                        tEWalletKLK:@""
                        };
    
    [self.collectionView reloadData];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark CollectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *nameSection = arraySectionBank[indexPath.section];
    NSArray *arrayBank = listBank[nameSection];
    NSDictionary *dictBank = [Utils converDictRemoveNullValue:arrayBank[indexPath.row]];
    
    switch (self.type) {
        case bank:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectBank object:dictBank];
        }
            break;
            
        case eWallet:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectEWallet object:dictBank];
        }
            break;
            
        case tktt:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectTKTT object:dictBank];
        }
            break;
            
        case tknt:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectTKTT object:dictBank];
        }
            break;
            
        case edit_tknt:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectEditTKTT object:dictBank];
        }
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *nameSection = arraySectionBank[section];
    NSArray *arrayBank = listBank[nameSection];
    return arrayBank.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectBankCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    NSString *nameSection = arraySectionBank[indexPath.section];
    NSArray *arrayBank = listBank[nameSection];
    NSDictionary *dictBank = [Utils converDictRemoveNullValue:arrayBank[indexPath.row]];
    
    cell.labelNameBank.text = dictBank[@"code"];
    NSString *linkImage = [NSString stringWithFormat:@"%@",dictBank[@"image"]];
    [cell.imageAvatarBank sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"bank_vpbank"]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return listBank.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int width = (int)(collectionView.frame.size.width-3)/4;
    int height = (int) width*4/3;
    
    return CGSizeMake(width, height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SelectBankHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SelectBankHeaderCollectionReusableView" forIndexPath:indexPath];
        
        NSString *nameSection = arraySectionBank[indexPath.section];
        headerView.labelNameHeader.text = nameSection;
        headerView.labelSubNameHeader.text = listSectionBank[nameSection];
        
        reusableview = headerView;
    }
    
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    NSString *nameSection = arraySectionBank[section];
    NSArray *arrayBank = listBank[nameSection];
    if (arrayBank.count > 0) {
        CGSize headerViewSize = CGSizeMake(collectionView.frame.size.width, 60);
        return headerViewSize;
    }else{
        CGSize headerViewSize = CGSizeMake(collectionView.frame.size.width, 0);
        return headerViewSize;
    }
}

#pragma mark CallAPI

- (void)getListBank {
    NSArray *check_sum = @[@"api0005_get_list_bank"];
    
    NSDictionary *dictParam = @{@"KEY":@"api0005_get_list_bank"};

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *arrayBank = dictData[@"info"];
        [self settupArrayBank:arrayBank];
    }];
}


@end
