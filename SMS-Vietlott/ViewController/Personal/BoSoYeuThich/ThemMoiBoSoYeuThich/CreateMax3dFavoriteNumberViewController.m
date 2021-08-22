//
//  CreateMax3dFavoriteNumberViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/29/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "CreateMax3dFavoriteNumberViewController.h"

@interface CreateMax3dFavoriteNumberViewController ()

@end

@implementation CreateMax3dFavoriteNumberViewController {
    NSString *numberOne;
    NSString *numberTwo;
    NSString *numberThree;
    
    NSMutableArray *arrTicketTypes;
    TicketTypeObj *selectedTicketType;
    int currentViTriOm;
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
        
        if ([selectedTicketType.typeId isEqualToString:idMax3DOm]) {
            self.viewChonViTriOm.hidden = NO;
            self.heightViewChonViTriOm.constant = 100;
            [self settupViTriOmWithTag];
        }else{
            self.viewChonViTriOm.hidden = YES;
            self.heightViewChonViTriOm.constant = 0;
            [self resetArrayBtnNumber];
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

- (IBAction)reloadNumber:(id)sender {
    numberOne = nil;
    numberTwo = nil;
    numberThree = nil;
    
    [self selectNumberWithTag:-1 inArray:self.arrayNumberOne];
    [self selectNumberWithTag:-1 inArray:self.arrayNumberTwo];
    [self selectNumberWithTag:-1 inArray:self.arrayNumberThree];
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
    }else{
        if (self.dictEdit) {
            [self updateFavoriteNumber];
        }else{
            [self addToFavorite];
        }
    }
}

- (IBAction)chonViTriOm:(UIButton *)sender {
    for (UIButton *btn in self.arrayBtnChonViTri) {
        if (btn == sender) {
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_radio_selected"] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_radio_unselect"] forState:UIControlStateNormal];
        }
    }
    
    currentViTriOm = (int)sender.tag;
    [self settupViTriOmWithTag];
}

- (void)resetArrayBtnNumber {
    for (int i=0;i < self.arrayNumberOne.count;i++) {
        UIButton *btn1 = self.arrayNumberOne[i];
        btn1.enabled = YES;
        [btn1 setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        
        UIButton *btn2 = self.arrayNumberTwo[i];
        btn2.enabled = YES;
        [btn2 setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        
        UIButton *btn3 = self.arrayNumberThree[i];
        btn3.enabled = YES;
        [btn3 setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
    }
}

- (void)settupViTriOmWithTag {
    [self resetArrayBtnNumber];
    
    switch (currentViTriOm) {
        case 0:
        {
            for (UIButton *btn in self.arrayNumberOne) {
                btn.enabled = NO;
                [btn setTitle:@"*" forState:UIControlStateNormal];
            }
            numberOne = @"*";
        }
            break;
            
        case 1:
        {
            for (UIButton *btn in self.arrayNumberTwo) {
                btn.enabled = NO;
                [btn setTitle:@"*" forState:UIControlStateNormal];
            }
            numberTwo = @"*";
        }
            break;
            
        case 2:
        {
            for (UIButton *btn in self.arrayNumberThree) {
                btn.enabled = NO;
                [btn setTitle:@"*" forState:UIControlStateNormal];
            }
            numberThree = @"*";
        }
            break;
            
        default:
            break;
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
    
    currentViTriOm = 0;
    self.viewChonViTriOm.hidden = YES;
    self.heightViewChonViTriOm.constant = 0;
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
        
        self.navigationItem.title = @"Chỉnh sửa bộ số yêu thích";
    }
}

#pragma mark CallAPI

- (void)getTypeGames {
    NSArray *check_sum = @[@"API0044_get_type_play",
                           idMax3D
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0044_get_type_play",
                                @"id":idMax3D
    };
    
    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *array = dictData[@"info"];
        [self initTicketTypeListOnline:array];
    }];
}

- (void)addToFavorite {
    NSArray *check_sum = @[@"API0036_insert_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           idMax3D,
                           [NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                           [NSString stringWithFormat:@"%@%@%@",numberOne,numberTwo,numberThree]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0036_insert_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"game_id":idMax3D,
                                @"type_play_id":[NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                                @"favorite_numbers":[NSString stringWithFormat:@"%@%@%@",numberOne,numberTwo,numberThree]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoriteMax3DSuccess object:nil];
        
        [Utils alertError:@"Thông báo" content:@"Thêm bộ số yêu thích thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (void)updateFavoriteNumber {
    NSArray *check_sum = @[@"API0054_update_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%@",self.dictEdit[@"id"]],
                           idMax3D,
                           [NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                           [NSString stringWithFormat:@"%@%@%@",numberOne,numberTwo,numberThree]
    ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0054_update_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"id":[NSString stringWithFormat:@"%@",self.dictEdit[@"id"]],
                                @"game_id":idMax3D,
                                @"type_play_id":[NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                                @"favorite_numbers":[NSString stringWithFormat:@"%@%@%@",numberOne,numberTwo,numberThree]
    };
    
    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameAddFavoriteMax3DSuccess object:nil];
        
        [Utils alertError:@"Thông báo" content:@"Chỉnh sửa bộ số yêu thích thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

@end
