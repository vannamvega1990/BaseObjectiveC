//
//  HomeViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/10/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNewsTableViewCell.h"
#import "HomeVietlottTableViewCell.h"
#import "Mega645ViewController.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "SelectBankViewController.h"
#import "CreateTKTTViewController.h"
#import "Max3DViewController.h"
#import "Max4DViewController.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "CallAPI.h"
#import "RSA.h"
#import "AESCrypt.h"
#import "ForgetPasswordViewController.h"
#import "ChangePasswordViewController.h"
#import "LoginViewController.h"
#import "DetailNewsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSArray *arrayVietlott;
    NSDictionary *dictBank;
    NSMutableArray *arrayTickets;
    
    float currentHeightViewLogin;
    float currentHeightViewUnlogin;
    float currentHeightViewDisconnect;
    
    NSMutableArray *arrayTinMoiNhat;
    NSMutableArray *arrayTinHoatDong;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self settupView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    [self.navigationController.navigationBar setHidden:true];
    
    if ([Utils isDisconnect]) {
        [self showViewDisconnect];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setHidden:false];
}

- (void)settupView {
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = RGB_COLOR(240, 240, 240);
    refreshControl.tintColor = RGB_COLOR(100, 100, 100);
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    currentHeightViewLogin = self.heightViewLogin.constant;
    currentHeightViewUnlogin = self.heightViewUnlogin.constant;
    currentHeightViewDisconnect = self.heightViewDisconnect.constant;
    
    [self setColorBackGround:self.viewLogin];
    [self setColorBackGround:self.viewUnlogin];
    [self setColorBackGround:self.viewDisconnect];
    [self setColorBackGround:self.viewBackGround];
    
    [self setViewLoginHiden:YES];
    [self setViewUnloginHiden:NO];
    [self setViewDisconnectHiden:YES];
    
    if ([Utils isDisconnect]) {
        [self showViewDisconnect];
    }else{
        BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultIsLogin];
        if (isLogin) {
            if ([VariableStatic sharedInstance].isFirstLogin == YES) {
                [VariableStatic sharedInstance].isFirstLogin = NO;
                NSArray *arrayTKTT = [VariableStatic sharedInstance].dictUserInfo[@"list_tktt"];
                if (arrayTKTT.count == 0) {
                    [Utils alert:@"Thêm tài khoản thanh toán" content:@"Chọn tài khoản ngân hàng/ví điện tử để thanh toán giao dịch mua vé?" titleOK:@"Đồng ý" titleCancel:@"Bỏ qua" viewController:self completion:^{
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
                        SelectBankViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SelectBankViewController"];
                        vc.type = tktt;
                        vc.modalPresentationStyle = UIModalPresentationFullScreen;
                        [self presentViewController:vc animated:YES completion:nil];
                    }];
                }
                
                [self setViewLoginHiden:NO];
                [self setViewUnloginHiden:YES];
                [self setViewDisconnectHiden:YES];
                
                [self fillPersonalInfo];
            }else{
                [self login];
            }
        }else{
            [self setViewLoginHiden:YES];
            [self setViewUnloginHiden:NO];
            [self setViewDisconnectHiden:YES];
        }
        
        [self getListGames];
        
        [self getListNews];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectTKTT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationLoginFail object:nil];
}

- (void)fillPersonalInfo {
    @try {
        self.labelName.text = [VariableStatic sharedInstance].dictUserInfo[@"name"];
        NSString *hmut = [NSString stringWithFormat:@"%@",[VariableStatic sharedInstance].dictUserInfo[@"tkdt_han_muc"]];
        self.labelHMUT.text = [[Utils strCurrency: hmut] stringByAppendingString:@"đ"];
        
        NSString *loyalty = [NSString stringWithFormat:@"%@",[VariableStatic sharedInstance].dictUserInfo[@"loyalty_rank"]];
        loyalty = loyalty.length > 0 ? loyalty : @"Tiêu chuẩn";
        self.labelLoyalty.text = [NSString stringWithFormat:@"Hạng: %@",loyalty];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)handleRefresh : (id)sender{
    arrayTinMoiNhat = [NSMutableArray array];
    arrayTinHoatDong = [NSMutableArray array];
    arrayVietlott = [NSArray array];
    [self.tableView reloadData];
    [self getListNews];
    [self getListGames];
    [refreshControl endRefreshing];
}

- (void)setColorBackGround : (UIView *)view {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, view.frame.size.height);
    gradient.colors = @[(id)RGB_COLOR(86, 84, 203).CGColor, (id)RGB_COLOR(0, 22, 99).CGColor];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    
    if (view != self.viewBackGround) {
        gradient.cornerRadius = 8;
    }
    
    [view.layer insertSublayer:gradient atIndex:0];
}

- (void)setViewLoginHiden : (BOOL) isHiden {
    self.viewLogin.hidden = isHiden;
    self.heightViewLogin.constant = isHiden ? 0 : currentHeightViewLogin;
}

- (void)setViewUnloginHiden : (BOOL) isHiden {
    self.viewUnlogin.hidden = isHiden;
    self.heightViewUnlogin.constant = isHiden ? 0 : currentHeightViewUnlogin;
}

- (void)setViewDisconnectHiden : (BOOL) isHiden {
    self.viewDisconnect.hidden = isHiden;
    self.heightViewDisconnect.constant = isHiden ? 0 : currentHeightViewDisconnect;
}

- (IBAction)changeViewLogin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    [[self appDelegate].window setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]];
    [[self appDelegate].window makeKeyAndVisible];
}

- (IBAction)refreshConnect:(id)sender {
    if (![Utils isDisconnect]) {
        BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultIsLogin];
        if (isLogin) {
            [self login];
        }else{
            [self setViewLoginHiden:YES];
            [self setViewUnloginHiden:NO];
            [self setViewDisconnectHiden:YES];
        }
        [self getListGames];
        [self getListNews];
    }
}

- (IBAction)napTien:(id)sender {
    [Utils alertError:@"Thông báo" content:@"Chức năng đang xây dựng" viewController:nil completion:^{
        
    }];
}

- (void)showViewDisconnect {
    [self setViewLoginHiden:YES];
    [self setViewUnloginHiden:YES];
    [self setViewDisconnectHiden:NO];
    
    arrayVietlott = @[@{@"id":idMega645,
                        @"game_image":@"home_mega645",
                        @"next_period_time":@""
                        },
                      @{@"id":idPower655,
                        @"game_image":@"home_power655",
                        @"next_period_time":@""
                      },
                      @{@"id":idMax3D,
                        @"game_image":@"home_max3D",
                        @"next_period_time":@""
                      },
                      @{@"id":idMax4D,
                        @"game_image":@"home_max4d",
                        @"next_period_time":@""
                      }];
    
    [self.tableView reloadData];
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"HomeVietlottTableViewCell";
        HomeVietlottTableViewCell *cell = (HomeVietlottTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSDictionary *dict = [Utils converDictRemoveNullValue:arrayVietlott[indexPath.row]];
        
        cell.time = [NSString stringWithFormat:@"%@",dict[@"next_period_time"]];
        
        NSString *reward = [NSString stringWithFormat:@"%@",dict[@"max_reward"]];
        reward = [[Utils strCurrency:reward] stringByAppendingString:@"đ"];
        cell.labelJackpot.text = reward;
        
        if ([dict[@"game_logo"] isKindOfClass:[NSString class]]) {
            NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dict[@"game_logo"]]];
            [cell.imageVietlott sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"logo"]];
        }else{
            cell.imageVietlott.image = [UIImage imageNamed:dict[@"game_image"]];
        }
        
        NSString *kyTiepTheo = [NSString stringWithFormat:@"%@",dict[@"next_period_time"]];
        kyTiepTheo = [[kyTiepTheo componentsSeparatedByString:@" "] firstObject];
        cell.labelKyQuay.text = [NSString stringWithFormat:@"Kỳ tiếp theo: %@",kyTiepTheo];
        
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *cellIdentifier = @"HomeNewNewsTableViewCell";
        HomeNewNewsTableViewCell *cell = (HomeNewNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.delegate = self;
        cell.arrayItem = arrayTinMoiNhat;
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"HomeNewsTableViewCell";
        HomeNewsTableViewCell *cell = (HomeNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSDictionary *dict = [arrayTinHoatDong objectAtIndex:indexPath.row];
        cell.labelContent.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
        cell.labelDateTime.text = [NSString stringWithFormat:@"%@",dict[@"create_time"]];
        
        NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dict[@"img_link"]]];
        [cell.labelImageNews sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"news"]];
        
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return arrayVietlott.count;
    }else if (section == 1) {
        return arrayTinMoiNhat.count > 0 ? 1 : 0;;
    }else{
        return arrayTinHoatDong.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width - 30, 40)];
    labelTitle.font = [UIFont boldSystemFontOfSize:17];
    [view addSubview:labelTitle];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 100, 40)];
    [btn setTitle:@"Xem thêm" forState:UIControlStateNormal];
    [btn setTitleColor:RGB_COLOR(3, 106, 255) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:btn];
    
    if (section == 0) {
        labelTitle.text = @"";
    }else if (section == 1) {
        labelTitle.text = @"Tin mới";
        [btn addTarget:self action:@selector(showNewNews:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        labelTitle.text = @"Tin hoạt động";
        [btn addTarget:self action:@selector(showActionNews:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return arrayTinMoiNhat.count > 0 ? 40 : 0;
    }else{
        return arrayTinHoatDong.count > 0 ? 40 : 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 300;
    }else{
        return UITableViewAutomaticDimension;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSDictionary *dict = [Utils converDictRemoveNullValue:arrayVietlott[indexPath.row]];
        NSString *idGame = [NSString stringWithFormat:@"%@",dict[@"id"]];
        if ([idGame isEqualToString:idMega645]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
            Mega645ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Mega645ViewController"];
            vc.type = 0;
            vc.dictGame = dict;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([idGame isEqualToString:idPower655]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
            Mega645ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Mega645ViewController"];
            vc.type = 1;
            vc.dictGame = dict;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([idGame isEqualToString:idMax3D]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Max3D" bundle:nil];
            Max3DViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Max3DViewController"];
            vc.dictGame = dict;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([idGame isEqualToString:idMax4D]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Max4D" bundle:nil];
            Max4DViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Max4DViewController"];
            vc.dictGame = dict;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [Utils alertError:@"Thông tin" content:@"Hệ thống đang bận vui lòng thử lại sau" viewController:self completion:^{
                
            }];
        }
    }else if (indexPath.section == 2) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailNewsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNewsViewController"];
        vc.dictNews = [arrayTinHoatDong objectAtIndex:indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)pushViewControllerShowDetailItem:(NSDictionary *)dictSkill {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailNewsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailNewsViewController"];
    vc.dictNews = dictSkill;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showNewNews: (id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectTabbarNewNews object:nil];
}

- (void)showActionNews: (id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectTabbarActionNews object:nil];
}

#pragma mark PolicyViewControllerDelegate

- (void)agreePolicy {
    [Utils alertError:@"Thông báo" content:@"Thêm tài khoản thanh toán thành công" viewController:self completion:^{
        
    }];
}

#pragma mark CallAPI

- (void)login {
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultUserName];
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultPassword];
    password = [AESCrypt decrypt:password password:kAES];
    password = [RSA encryptString:password publicKey:kPubkey];
    
    NSArray *check_sum = @[@"api0007_login",
                           username,
                           password
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0007_login",
                                @"user_name":username,
                                @"password":password
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
                
                [VariableStatic sharedInstance].isLogin = YES;
                [VariableStatic sharedInstance].accessToken = dictData[@"jwt"];
                [VariableStatic sharedInstance].phoneNumber = username;
                [VariableStatic sharedInstance].dictUserInfo = [Utils converDictRemoveNullValue:dictData[@"info"]];
                
                [self setViewLoginHiden:NO];
                [self setViewUnloginHiden:YES];
                [self setViewDisconnectHiden:YES];
                
                [self fillPersonalInfo];
            }else{
                [self setViewLoginHiden:YES];
                [self setViewUnloginHiden:NO];
                [self setViewDisconnectHiden:YES];
            }
        }else{
            [self setViewLoginHiden:YES];
            [self setViewUnloginHiden:YES];
            [self setViewDisconnectHiden:NO];
        }
    }];
}

- (void)getListNews {
    NSArray *check_sum = @[@"API0029_search_news",
                           @"",
                           @"1",
                           @"10",
                           @"",
                           @""
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0029_search_news",
                                @"content":@"",
                                @"page":@"1",
                                @"line_in_page":@"10",
                                @"type":@"",
                                @"date":@""
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        self->arrayTinMoiNhat = [NSMutableArray array];
        self->arrayTinHoatDong = [NSMutableArray array];
        NSArray *arrayResult = dictData[@"info"];
        for (NSDictionary *dict in arrayResult) {
            int type = [dict[@"type"] intValue];
            if (type == kTinMoiNhat) {
                [self->arrayTinMoiNhat addObject:dict];
            }else if (type == kTinHoatDong) {
                [self->arrayTinHoatDong addObject:dict];
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)getListGames {
    NSArray *check_sum = @[@"API0028_get_games"
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0028_get_games"
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"info"] isKindOfClass:[NSArray class]]) {
                NSArray *arrayGames = dictData[@"info"];
                NSMutableArray *arrayGamesAvailable = [NSMutableArray array];
                for (NSDictionary *dict in arrayGames) {
                    if ([[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
                        [arrayGamesAvailable addObject:dict];
                    }
                }
                self->arrayVietlott = arrayGamesAvailable;
            }
        }else{
            [self showViewDisconnect];
        }
        
        [self.tableView reloadData];
    }];
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectTKTT]) {
        dictBank = notif.object;
        if (dictBank) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            CreateTKTTViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateTKTTViewController"];
            vc.dictTKTT = dictBank;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
