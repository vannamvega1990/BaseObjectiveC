//
//  CreateMax4dFavoriteNumberViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/29/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "CreateMax4dFavoriteNumberViewController.h"

@interface CreateMax4dFavoriteNumberViewController ()

@end

@implementation CreateMax4dFavoriteNumberViewController {
    NSString *numberOne;
    NSString *numberTwo;
    NSString *numberThree;
    NSString *numberFour;
    
    NSMutableArray *arrTicketTypes;
    TicketTypeObj *selectedTicketType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getTypeGames];
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
        [self reloadNumber:nil];
        
        if ([selectedTicketType.typeId isEqualToString:idMax4DCuon1]){
            for (UIButton *btn in self.arrayNumberOne) {
                btn.enabled = NO;
                [btn setTitle:@"*" forState:UIControlStateNormal];
            }
            
            for (int i=0;i < self.arrayNumberFour.count;i++) {
                UIButton *btn = self.arrayNumberFour[i];
                btn.enabled = YES;
                [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            }
            
            numberOne = @"*";
        }else if ([selectedTicketType.typeId isEqualToString:idMax4DCuon4]){
            for (int i=0;i < self.arrayNumberOne.count;i++) {
                UIButton *btn = self.arrayNumberOne[i];
                btn.enabled = YES;
                [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            }
            
            for (UIButton *btn in self.arrayNumberFour) {
                btn.enabled = NO;
                [btn setTitle:@"*" forState:UIControlStateNormal];
            }
            
            numberFour = @"*";
        }else{
            for (int i=0;i < self.arrayNumberOne.count;i++) {
                UIButton *btn = self.arrayNumberOne[i];
                btn.enabled = YES;
                [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            }
            
            for (int i=0;i < self.arrayNumberFour.count;i++) {
                UIButton *btn = self.arrayNumberFour[i];
                btn.enabled = YES;
                [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            }
        }
    }
}

- (IBAction)selectNumberOne:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberOne];
    numberOne = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (IBAction)selectNumberTwo:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberTwo];
    numberTwo = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (IBAction)selectNumberThree:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberThree];
    numberThree = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (IBAction)selectNumberFour:(UIButton *)sender {
    [self selectNumberWithTag:(int)sender.tag inArray:self.arrayNumberFour];
    numberFour = [NSString stringWithFormat:@"%d",(int)sender.tag];
}

- (IBAction)reloadNumber:(id)sender {
    numberOne = nil;
    numberTwo = nil;
    numberThree = nil;
    numberFour = nil;
    
    [self selectNumberWithTag:-1 inArray:self.arrayNumberOne];
    [self selectNumberWithTag:-1 inArray:self.arrayNumberTwo];
    [self selectNumberWithTag:-1 inArray:self.arrayNumberThree];
    [self selectNumberWithTag:-1 inArray:self.arrayNumberFour];
}

- (IBAction)confirmNumber:(id)sender {
    if (numberOne == nil) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn số thứ nhất" viewController:self completion:^{
            
        }];
    }else if (numberTwo == nil) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn số thứ hai" viewController:self completion:^{
            
        }];
    }else if (numberThree == nil) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn số thứ ba" viewController:self completion:^{
            
        }];
    }else if (numberFour == nil) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn số thứ tư" viewController:self completion:^{
            
        }];
    }else{
        if (self.dictEdit) {
            [self updateFavoriteNumber];
        }else{
            [self addToFavorite];
        }
    }
}

- (void)selectNumberWithTag : (int)tag inArray : (NSArray *)array {
    for (UIButton *btn in array) {
        if (btn.tag == tag && btn.enabled == YES) {
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_number_selected"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_number_unselected"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
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
            type.quantitySelectNumber = 3;
            type.numberTicketofGroup = 6;
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
                    [self onSelectedLoaiVe:type];
                    self.labelCachChoi.text = type.name;
                    [self fillNumberToEdit];
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

- (void)fillNumberToEdit {
    if (self.dictEdit) {
        NSString *strNumber = [NSString stringWithFormat:@"%@",self.dictEdit[@"favorite_numbers"]];
        numberOne = [strNumber substringWithRange:NSMakeRange(0, 1)];
        [self selectNumberWithTag:[numberOne intValue] inArray:self.arrayNumberOne];
        
        numberTwo = [strNumber substringWithRange:NSMakeRange(1, 1)];
        [self selectNumberWithTag:[numberTwo intValue] inArray:self.arrayNumberTwo];
        
        numberThree = [strNumber substringWithRange:NSMakeRange(2, 1)];
        [self selectNumberWithTag:[numberThree intValue] inArray:self.arrayNumberThree];
        
        numberFour = [strNumber substringWithRange:NSMakeRange(3, 1)];
        [self selectNumberWithTag:[numberFour intValue] inArray:self.arrayNumberFour];
        
        self.navigationItem.title = @"Chỉnh sửa bộ số yêu thích";
    }
}


#pragma mark CallAPI

- (void)getTypeGames {
    NSArray *check_sum = @[@"API0044_get_type_play",
                           idMax4D
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0044_get_type_play",
                                @"id":idMax4D
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *array = dictData[@"info"];
        [self initTicketTypeListOnline:array];
    }];
}

- (void)addToFavorite {
    NSArray *check_sum = @[@"API0036_insert_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           idMax4D,
                           [NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                           [NSString stringWithFormat:@"%@%@%@%@",numberOne,numberTwo,numberThree,numberFour]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0036_insert_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"game_id":idMax4D,
                                @"type_play_id":[NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                                @"favorite_numbers":[NSString stringWithFormat:@"%@%@%@%@",numberOne,numberTwo,numberThree,numberFour]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoriteMax4DSuccess object:nil];
        
        [Utils alertError:@"Thông báo" content:@"Thêm bộ số yêu thích thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (void)updateFavoriteNumber {
    NSArray *check_sum = @[@"API0054_update_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%@",self.dictEdit[@"id"]],
                           idMax4D,
                           [NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                           [NSString stringWithFormat:@"%@%@%@%@",numberOne,numberTwo,numberThree,numberFour]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0054_update_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"id":[NSString stringWithFormat:@"%@",self.dictEdit[@"id"]],
                                @"game_id":idMax4D,
                                @"type_play_id":[NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                                @"favorite_numbers":[NSString stringWithFormat:@"%@%@%@%@",numberOne,numberTwo,numberThree,numberFour]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoriteMax4DSuccess object:nil];
        
        [Utils alertError:@"Thông báo" content:@"Chỉnh sửa bộ số yêu thích thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

@end
