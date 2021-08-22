//
//  UtiliesViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "UtiliesViewController.h"
#import "UtilitiesCollectionViewCell.h"
#import "CommonWebViewController.h"
#import "ManageFavoriteNumbersViewController.h"
#import "ManageThongKeViewController.h"
#import "SoKetViewController.h"
#import "DreamNumberViewController.h"
#import "ManageXuHuongViewController.h"

static NSString *cellIdentifier = @"UtilitiesCollectionViewCell";
static int space = 10;

@interface UtiliesViewController ()

@end

@implementation UtiliesViewController {
    NSArray *arrayUtilities;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    
    arrayUtilities = @[@{@"id":@"0",
                         @"name":@"Thống kê",
                         @"image":@"utils_thong_ke",
                         @"color":RGB_COLOR(251, 231, 232)
                        },
                       @{@"id":@"1",
                         @"name":@"Số kết",
                         @"image":@"utils_so_ket",
                         @"color":RGB_COLOR(255, 247, 235)
                       },
                       @{@"id":@"2",
                         @"name":@"Sổ mơ",
                         @"image":@"utils_so_mo",
                         @"color":RGB_COLOR(252, 242, 249)
                       },
                       @{@"id":@"3",
                         @"name":@"Ngũ hành",
                         @"image":@"utils_ngu_hanh",
                         @"color":RGB_COLOR(230, 240, 255)
                       },
                       @{@"id":@"4",
                         @"name":@"Bộ số yêu thích",
                         @"image":@"utils_bo_so_yeu_thich",
                         @"color":RGB_COLOR(252, 231, 232)
                       },
                       @{@"id":@"5",
                         @"name":@"Xu hướng",
                         @"image":@"utils_xu_huong",
                         @"color":RGB_COLOR(230, 240, 255)
                       },
                       @{@"id":@"6",
                         @"name":@"Số VIP",
                         @"image":@"utils_vip",
                         @"color":RGB_COLOR(250, 240, 247)
                       },
                       @{@"id":@"7",
                         @"name":@"Hướng dẫn chơi",
                         @"image":@"utils_huong_dan_choi",
                         @"color":RGB_COLOR(255, 247, 235)
                       }
                        ];
    
    [self.collectionView reloadData];
}

#pragma mark CollectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [arrayUtilities objectAtIndex:indexPath.row];
    int idUtility = [dict[@"id"] intValue];
    
    switch (idUtility) {
        case 0:
        {
            UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
            ManageThongKeViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"ManageThongKeViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
        {
            UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
            SoKetViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"SoKetViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2:
        {
            UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
            DreamNumberViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"DreamNumberViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3:
        {
            
        }
            break;
            
        case 4:
        {
            if ([VariableStatic sharedInstance].isLogin) {
                UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                ManageFavoriteNumbersViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"ManageFavoriteNumbersViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [Utils showAlertLogin];
            }
        }
            break;
            
        case 5:
        {
            UIStoryboard *personalStoryboard = [UIStoryboard storyboardWithName:@"Utilities" bundle:nil];
            ManageXuHuongViewController *vc = [personalStoryboard instantiateViewControllerWithIdentifier:@"ManageXuHuongViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 6:
        {
            
        }
            break;
            
        case 7:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            CommonWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonWebViewController"];
            vc.titleView = @"Hướng dẫn";
            vc.stringUrl = @"https://vietlott.vn/vi/choi/mega-6-45/cach-choi";
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrayUtilities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UtilitiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dict = [arrayUtilities objectAtIndex:indexPath.row];
    
    cell.viewUtility.backgroundColor = dict[@"color"];
    cell.labelUtility.text = dict[@"name"];
    cell.imageUtility.image = [UIImage imageNamed:dict[@"image"]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat paddingSpace = space * (3 + 2);
    CGFloat availableWidth = self.view.frame.size.width - paddingSpace;
    CGFloat widthPerItem = availableWidth / 3;
    
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(space, space, space, space);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return space*3/2;
}


@end
