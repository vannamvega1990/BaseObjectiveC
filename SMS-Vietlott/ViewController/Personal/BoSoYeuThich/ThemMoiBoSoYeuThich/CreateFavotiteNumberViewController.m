//
//  CreateFavotiteNumberViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/29/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "CreateFavotiteNumberViewController.h"
#import "ChonSoCollectionViewCell.h"

@interface CreateFavotiteNumberViewController ()

@end

@implementation CreateFavotiteNumberViewController {
    int maxNumber;
    NSMutableArray *arrTicketTypes;
    long long DEFAULT_PRICE;
    TicketTypeObj *selectedTicketType;
    
    NSMutableArray *arrayNumberSelect;
}

static NSString *cellIdentifier = @"ChonSoCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    
    CGSize collectionViewSize = self.collectionView.contentSize;
    self.heightCollectionView.constant = collectionViewSize.height;
    self.viewBtn.hidden = NO;
}

- (void) initUI {
    maxNumber = self.type == 0 ? 45 : 55;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier: cellIdentifier];
    
    DEFAULT_PRICE = 10000;
    [self getTypeGames];
    
    arrayNumberSelect = [NSMutableArray array];
    if (self.dictEdit) {
        NSString *strNumber = [NSString stringWithFormat:@"%@",self.dictEdit[@"favorite_numbers"]];
        for (int i=0; i < strNumber.length; i=i+2) {
            @try {
                NSString *tmp_str = [strNumber substringWithRange:NSMakeRange(i, 2)];
                [arrayNumberSelect addObject:tmp_str];
            } @catch (NSException *exception) {
                
            } @finally {
                    
            }
        }
        self.navigationItem.title = @"Chỉnh sửa bộ số yêu thích";
    }
}

- (void)initTicketTypeListOnline : (NSArray *)arrayType {
    arrTicketTypes = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in arrayType) {
        if ([dict[@"active"] intValue] == 1) {
            TicketTypeObj *type = [[TicketTypeObj alloc] init];
            type.typeId = [NSString stringWithFormat:@"%@",dict[@"id"]];
            type.gameId = [NSString stringWithFormat:@"%@",dict[@"game_id"]];
            type.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
            type.quantitySelectNumber = [[NSString stringWithFormat:@"%@",dict[@"select_number"]] intValue];
            type.numberTicketofGroup = 6;
            type.price =  [[NSString stringWithFormat:@"%@",dict[@"total_numbers"]] intValue] * DEFAULT_PRICE;
            type.des =  [NSString stringWithFormat:@"%@",dict[@"des"]];
            [arrTicketTypes addObject:type];
        }
    }
    
    if (arrTicketTypes.count > 0) {
        if (self.dictEdit) {
            for (TicketTypeObj *type in arrTicketTypes) {
                NSString *typeID = type.typeId;
                NSString *typePlayID = [NSString stringWithFormat:@"%@",self.dictEdit[@"type_play_id"]];
                if ([typeID isEqualToString:typePlayID]) {
                    selectedTicketType = type;
                    self.labelCachChoi.text = selectedTicketType.name;
                    break;
                }
            }
        }else{
            selectedTicketType = arrTicketTypes[0];
            self.labelCachChoi.text = selectedTicketType.name;
        }
    }else{
        self.labelCachChoi.text = @"";
    }
}

- (IBAction)chonCachChoi:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    SelectTypePlayViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectTypePlayViewController"];
    dialogVC.delegate = self;
    dialogVC.selectedTicketType = selectedTicketType;
    dialogVC.arrItems = arrTicketTypes;
    [[[self appDelegate] window] addSubview:dialogVC.view];
    [[[self appDelegate] window].rootViewController addChildViewController:dialogVC];
}

// xử lý khi delegate khi click chọn cach choi
- (void) onSelectedLoaiVe:(TicketTypeObj *)selectedItem {
    if (selectedTicketType != selectedItem) {
        selectedTicketType = selectedItem;
        self.labelCachChoi.text = selectedTicketType.name;
        [self resetNumber:nil];
    }
}

- (IBAction)resetNumber:(id)sender {
    arrayNumberSelect = [NSMutableArray array];
    [self.collectionView reloadData];
}

- (IBAction)finishSelectNumber:(id)sender {
    if (selectedTicketType.quantitySelectNumber != arrayNumberSelect.count) {
        [Utils alertError:@"Thông báo" content:[NSString stringWithFormat:@"Vui lòng chọn đủ %d số",selectedTicketType.quantitySelectNumber] viewController:self completion:^{
            
        }];
    }else{
        if (self.dictEdit != nil) {
            [self updateFavoriteNumber];
        }else{
            [self addToFavorite];
        }
    }
}

// - MARK: collection view
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *selectedNumber = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    if (selectedNumber.length == 1) {
        selectedNumber = [NSString stringWithFormat:@"0%@",selectedNumber];
    }
    
    if ([arrayNumberSelect containsObject:selectedNumber]) {
        [arrayNumberSelect removeObject:selectedNumber];
    }else{
        if (arrayNumberSelect.count == selectedTicketType.quantitySelectNumber) {
            [Utils alert:@"Thông báo" content:[NSString stringWithFormat:@"Đã chọn đủ %d số, bạn muốn thêm bộ số này vào bộ số yêu thích ?",selectedTicketType.quantitySelectNumber] titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:self completion:^{
                [self addToFavorite];
            }];
        }else{
            [arrayNumberSelect addObject:selectedNumber];
        }
    }
    
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChonSoCollectionViewCell *cell = (ChonSoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *currentNumber = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    if (currentNumber.length == 1) {
        currentNumber = [NSString stringWithFormat:@"0%@",currentNumber];
    }
    cell.lblNumber.text = currentNumber;
    
    BOOL isSelectedNumber = [arrayNumberSelect containsObject:currentNumber];
    
    if(isSelectedNumber) {
        cell.imgBackground.image = [UIImage imageNamed:@"bg_number_selected"];
        cell.lblNumber.textColor = [UIColor whiteColor];
    } else {
        cell.imgBackground.image = [UIImage imageNamed:@"bg_number_unselected"];
        cell.lblNumber.textColor = [UIColor darkTextColor];
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return maxNumber;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat paddingSpace = 8 * (6 + 1);
    CGFloat availableWidth = self.view.frame.size.width - paddingSpace;
    CGFloat widthPerItem = availableWidth / 6;
    
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

#pragma mark CallAPI

- (void)getTypeGames {
    NSArray *check_sum = @[@"API0044_get_type_play",
                           self.type == 0 ? idMega645 : idPower655
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0044_get_type_play",
                                @"id":self.type == 0 ? idMega645 : idPower655
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *array = dictData[@"info"];
        [self initTicketTypeListOnline:array];
    }];
}

- (void)addToFavorite {
    NSArray *check_sum = @[@"API0036_insert_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.type == 0 ? idMega645 : idPower655,
                           [NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                           [arrayNumberSelect componentsJoinedByString:@""]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0036_insert_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"game_id":self.type == 0 ? idMega645 : idPower655,
                                @"type_play_id":[NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                                @"favorite_numbers":[arrayNumberSelect componentsJoinedByString:@""]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (self.type == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoriteMegaSuccess object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoritePowerSuccess object:nil];
        }
        
        [Utils alertError:@"Thông báo" content:@"Thêm bộ số yêu thích thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (void)updateFavoriteNumber {
    NSArray *check_sum = @[@"API0054_update_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%@",self.dictEdit[@"id"]],
                           self.type == 0 ? idMega645 : idPower655,
                           [NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                           [arrayNumberSelect componentsJoinedByString:@""]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0054_update_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"id":[NSString stringWithFormat:@"%@",self.dictEdit[@"id"]],
                                @"game_id":self.type == 0 ? idMega645 : idPower655,
                                @"type_play_id":[NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                                @"favorite_numbers":[arrayNumberSelect componentsJoinedByString:@""]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (self.type == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoriteMegaSuccess object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoritePowerSuccess object:nil];
        }
        
        [Utils alertError:@"Thông báo" content:@"Chỉnh sửa bộ số yêu thích thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

@end
