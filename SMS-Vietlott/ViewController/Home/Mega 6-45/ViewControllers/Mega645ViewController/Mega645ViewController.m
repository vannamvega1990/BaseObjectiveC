//
//  Mega645ViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "Mega645ViewController.h"
#import "UserTicketBao5TableViewCell.h"
#import "UserTicketBao7TableViewCell.h"
#import "UserTicketBao18TableViewCell.h"
#import "UserTicketBao12TableViewCell.h"
#import "UserTicketNormalTableViewCell.h"
#import "UIBarButtonItem+Badge.h"


@interface Mega645ViewController ()


@end

@implementation Mega645ViewController {
    int totalPrice;
    NSMutableArray *arrTicketTypes;
    TicketTypeObj *selectedTicketType;
    
    NSMutableArray *arrKyquay;
    CommonSelectionObj *selectedKyQuay;
    
    NSMutableArray *arrayTickets;
    
    long long DEFAULT_PRICE;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    totalPrice = 0;
    DEFAULT_PRICE = 10000;
    [self initUIView];
    [self initTicketTypeList];
    [self initListKyQuay];
    [self getDataFromCoreData];
}

- (void) initUIView {
    UIButton *btnQuestion  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnQuestion setImage:[UIImage imageNamed:@"icon_question"] forState:UIControlStateNormal];
    [btnQuestion.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [btnQuestion addTarget:self action:@selector(onClickBtnHelp:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonQuestion = [[UIBarButtonItem alloc] initWithCustomView:btnQuestion];
    
    UIButton *btnCart  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnCart setImage:[[UIImage imageNamed:@"icon_cart.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btnCart.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [btnCart addTarget:self action:@selector(onClickbtnShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonCart = [[UIBarButtonItem alloc] initWithCustomView:btnCart];
    
    self.navigationItem.rightBarButtonItems = @[rightBarButtonCart,rightBarButtonQuestion];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.constraintTableViewHeight.constant = 330;
    
    if (self.type == 0) {
        self.navigationItem.title = @"Mega 6/45";
    }else if (self.type == 1){
        self.navigationItem.title = @"Power 6/55";
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameUpdateCart object:nil];
}


- (IBAction)onClickBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)onClickBtnHelp:(id)sender {
    
}

- (IBAction)onClickbtnShoppingCart:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self.navigationController pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"GioHangViewController"] animated:YES];
}

- (IBAction)onSelectCachChoi:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    SelectTypePlayViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:@"SelectTypePlayViewController"];
    dialogVC.delegate = self;
    dialogVC.selectedTicketType = selectedTicketType;
    dialogVC.arrItems = arrTicketTypes;
    [[[self appDelegate] window] addSubview:dialogVC.view];
    [[[self appDelegate] window].rootViewController addChildViewController:dialogVC];
}

- (IBAction)onSelectKyMua:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    ChonKyQuayDialogViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:@"ChonKyQuayDialogViewController"];
    dialogVC.delegate = self;
    dialogVC.selectedItem = selectedKyQuay;
    dialogVC.arrItems = arrKyquay;
    [[[self appDelegate] window] addSubview:dialogVC.view];
    [[[self appDelegate] window].rootViewController addChildViewController:dialogVC];
}

- (IBAction)onClickBtnTuChon:(id)sender {
    int i=0;
    for (BoSoObj *obj in arrayTickets) {
        if ([obj isValidNumber] == NO) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self makeRandomNumber:indexPath];
            [self.tableView reloadData];
            [self updateTotalPrice];
            break;
        }
        i++;
    }
}

- (IBAction)onClickBtnChonXuHuong:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
//    ManageChonTheoXuHuongViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ManageChonTheoXuHuongViewController"];
//    vc.ticketType = selectedTicketType;
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];
    [Utils alertError:@"Thông báo" content:@"Chức năng đang xây dựng" viewController:self completion:^{
        
    }];
}

- (void)manageSelectTicketSuccess:(NSMutableArray *)arrTickets {
    arrayTickets = arrTickets;
    [self.tableView reloadData];
    [self updateTotalPrice];
}

- (IBAction)onClickBtnBoSoYeuThich:(id)sender {
    if ([VariableStatic sharedInstance].isLogin == NO) {
        [Utils showAlertLogin];
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
        BoSoYeuThichViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BoSoYeuThichViewController"];
        vc.ticketType = selectedTicketType;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//Delegate sau khi chọn vé ưa thích
- (void)selectFavouriteTicketGroup:(NSMutableArray *)arrTickets {
    NSMutableArray *arrayBoSoChange = [NSMutableArray array];
    for (BoSoObj *obj in arrayTickets) {
        if ([obj isValidNumber] == NO) {
            [arrayBoSoChange addObject:obj];
        }
    }
    
    NSUInteger count = arrayBoSoChange.count < arrTickets.count ? arrayBoSoChange.count : arrTickets.count;
    
    for (int i=0; i < count; i++) {
        [self updateNumberBoSoObj:arrayBoSoChange[i] :arrTickets[i]];
    }
    
    [self.tableView reloadData];
    [self updateTotalPrice];
}

- (void)updateNumberBoSoObj :(BoSoObj *)obj : (NSDictionary *)dict {
    NSString *strNumber = dict[@"favorite_numbers"];
    NSMutableArray *arrNumber = [NSMutableArray array];
    for (int i=0; i < strNumber.length; i=i+2) {
        NSString *tmp_str = [strNumber substringWithRange:NSMakeRange(i, 2)];
        [arrNumber addObject:tmp_str];
    }
    
    for (int i=0; i < arrNumber.count; i++) {
        [obj.arrNumber replaceObjectAtIndex:i withObject:arrNumber[i]];
    }
    obj.isFavorited = YES;
    obj.idFavorite = dict[@"id"];
}

- (void)onFavouriteAction:(BOOL)isFavourite atIndexPath:(NSIndexPath *)indexPath {
    if ([VariableStatic sharedInstance].isLogin == NO) {
        [Utils showAlertLogin];
    }else{
        BoSoObj *ticket = arrayTickets[indexPath.row];
        ticket.isFavorited = isFavourite;
        if (isFavourite) {
            [self addToFavorite:ticket];
        }else{
            [self removeFromFavorite:ticket];
        }
        
        [self.tableView reloadData];
    }
}

- (IBAction)onClickBtnKhac:(id)sender {
    [Utils alertError:@"Thông báo" content:@"Chức năng đang xây dựng" viewController:self completion:^{
        
    }];
}

- (IBAction)onClickBtnAddCart:(id)sender {
    if ([self hasTicket]) {
        [self saveTicketToCoreData : NO];
    }else{
        [Utils alertError:@"Thông báo" content:@"Bạn chưa chọn bộ số nào" viewController:self completion:^{
            
        }];
    }
}

- (IBAction)onClickBtnPayment:(id)sender {
    if ([self hasTicket]) {
        [self saveTicketToCoreData : YES];
    }else{
        [Utils alertError:@"Thông báo" content:@"Bạn chưa chọn bộ số nào" viewController:self completion:^{
            
        }];
    }
}

// xử lý khi delegate khi click chọn cach choi
- (void) onSelectedLoaiVe:(TicketTypeObj *)selectedItem {
    if (selectedTicketType != selectedItem) {
        selectedTicketType = selectedItem;
        self.lblChonCachChoiValue.text = selectedTicketType.name;
        
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];
        
        CGSize tableViewSize = self.tableView.contentSize;
        self.constraintTableViewHeight.constant = tableViewSize.height;
        
        [self initListTicketsByType:selectedTicketType];
        
        [self updateTotalPrice];
    }
}

- (void) onSelectedKyQuay:(CommonSelectionObj *)selectedItem{
    selectedKyQuay = selectedItem;
    self.lblChonKyMuaValue.text = selectedKyQuay.name;
}

- (void)onDeleteAction:(BOOL)isDeleted atIndexPath:(NSIndexPath *)indexPath {
    BoSoObj *ticket = arrayTickets[indexPath.row];
    [ticket clearSelectedNumber];
    ticket.isFavorited = NO;
    [self.tableView reloadData];
    [self updateTotalPrice];
}

- (void)onRandomAction : (BOOL) isSelected atIndexPath:(NSIndexPath*) indexPath {
    [self makeRandomNumber:indexPath];
    [self.tableView reloadData];
    [self updateTotalPrice];
}

- (void)updateTotalPrice {
    totalPrice = 0;
    for(int i = 0; i< arrayTickets.count; i++){
        BoSoObj *ticket = arrayTickets[i];
        if([ticket isValidNumber]){
            totalPrice += ticket.price;
        }
    }
    
    self.lblChiPhiValue.text = [[Utils strCurrency:[NSString stringWithFormat:@"%d",totalPrice]] stringByAppendingFormat:@"đ"] ;
}

- (void)choseNumbers : (int) index {
    NSMutableArray *array = [NSMutableArray array];
    for (BoSoObj *obj in arrayTickets) {
        NSString *str = [obj toJSONString];
        [array addObject:str];
    }
    NSString *numbers = [array componentsJoinedByString:@"#"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    TuChonSoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TuChonSoViewController"];
    vc.ticketType = selectedTicketType;
    vc.selectedIndex = index;
    vc.type = self.type;
//    vc.arrTickets = arrayTickets;
    vc.strTicket = numbers;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectTicketSuccess:(NSMutableArray *)arrTickets {
    arrayTickets = arrTickets;
    [self.tableView reloadData];
    [self updateTotalPrice];
}

- (void)makeRandomNumber:(NSIndexPath*) indexPath {
    BoSoObj *ticket = arrayTickets[indexPath.row];
    [ticket clearSelectedNumber];
    
    int maxNumber = self.type == 0 ? 45 : 55;
    do {
        int number = [Utils getRandomNumberBetween:1 and:maxNumber];
        NSString *strNumber = number < 10 ? [NSString stringWithFormat:@"0%d",number] : [NSString stringWithFormat:@"%d",number];
        if (![ticket.arrNumber containsObject:strNumber]) {
            for(int i=0; i < ticket.type.quantitySelectNumber; i++) {
                NSString *number = ticket.arrNumber[i];
                if([number isEqualToString:@""]){
                    [ticket.arrNumber replaceObjectAtIndex:i withObject:strNumber];
                    break;
                }
            }
        }
    } while ([ticket isAddingNumber] && ![ticket isValidNumber]);
}

- (BOOL)hasTicket {
    for (BoSoObj *ticket in arrayTickets) {
        if ([ticket isAddingNumber] && [ticket isValidNumber]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BoSoObj *item = [arrayTickets objectAtIndex:indexPath.row];
    
    if (selectedTicketType.quantitySelectNumber == 6) { //ve thuong bao 6
        static NSString *cellIdentifier = @"UserTicketNormalTableViewCell";
        UserTicketNormalTableViewCell *cell = (UserTicketNormalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if (selectedTicketType.quantitySelectNumber == 5) { //bao 5
        static NSString *cellIdentifier = @"UserTicketBao5TableViewCell";
        UserTicketBao5TableViewCell *cell = (UserTicketBao5TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if (selectedTicketType.quantitySelectNumber == 7) { //bao 7
        static NSString *cellIdentifier = @"UserTicketBao7TableViewCell";
        UserTicketBao7TableViewCell *cell = (UserTicketBao7TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    }  else if ((selectedTicketType.quantitySelectNumber >= 8) && (selectedTicketType.quantitySelectNumber <= 12)) { //bao 8-12
        static NSString *cellIdentifier = @"UserTicketBao12TableViewCell";
        UserTicketBao12TableViewCell *cell = (UserTicketBao12TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    } else if ((selectedTicketType.quantitySelectNumber >= 13) && (selectedTicketType.quantitySelectNumber <= 18)) { //bao 13,14,15,18
        static NSString *cellIdentifier = @"UserTicketBao18TableViewCell";
        UserTicketBao18TableViewCell *cell = (UserTicketBao18TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setData:item];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedTicketType.quantitySelectNumber < 8) {
        return 55;
    }
    
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayTickets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self choseNumbers:(int)indexPath.row];
}

- (void)initTicketTypeList {
    if ([Utils isDisconnect]) {
        [self initTicketTypeListOffline];
    }else{
        [self getTypeGames];
    }
}

- (void)initTicketTypeListOffline {
    arrTicketTypes = [[NSMutableArray alloc] init];
    
    //add type 1
    TicketTypeObj *typeThuong = [[TicketTypeObj alloc] init];
    typeThuong.typeId = self.type == 0 ? idMegaCoBan : idPowerCoBan;
    typeThuong.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeThuong.name = @"Vé thường";
    typeThuong.quantitySelectNumber = 6;
    typeThuong.numberTicketofGroup = 6;
    typeThuong.price = DEFAULT_PRICE;
    typeThuong.des = @"";
    [arrTicketTypes addObject:typeThuong];
    
    //add type 2
    TicketTypeObj *typeBao5 = [[TicketTypeObj alloc] init];
    typeBao5.typeId = self.type == 0 ? idMegaBao5 : idPowerBao5;
    typeBao5.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao5.name = @"Bao 5";
    typeBao5.quantitySelectNumber = 5;
    typeBao5.numberTicketofGroup = 6;
    typeBao5.price = 40 * DEFAULT_PRICE;
    typeBao5.des = @"";
    [arrTicketTypes addObject:typeBao5];
    
    //add type 3
    TicketTypeObj *typeBao7 = [[TicketTypeObj alloc] init];
    typeBao7.typeId = self.type == 0 ? idMegaBao7 : idPowerBao7;
    typeBao7.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao7.name = @"Bao 7";
    typeBao7.quantitySelectNumber = 7;
    typeBao7.numberTicketofGroup = 6;
    typeBao7.price = 7 * DEFAULT_PRICE;
    typeBao7.des = @"";
    [arrTicketTypes addObject:typeBao7];
    
    //add type 4
    TicketTypeObj *typeBao8 = [[TicketTypeObj alloc] init];
    typeBao8.typeId = self.type == 0 ? idMegaBao8 : idPowerBao8;
    typeBao8.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao8.name = @"Bao 8";
    typeBao8.quantitySelectNumber = 8;
    typeBao8.numberTicketofGroup = 6;
    typeBao8.price = 28 * DEFAULT_PRICE;
    typeBao8.des = @"";
    [arrTicketTypes addObject:typeBao8];
    
    //add type 5
    TicketTypeObj *typeBao9 = [[TicketTypeObj alloc] init];
    typeBao9.typeId = self.type == 0 ? idMegaBao9 : idPowerBao9;
    typeBao9.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao9.name = @"Bao 9";
    typeBao9.quantitySelectNumber = 9;
    typeBao9.numberTicketofGroup = 6;
    typeBao9.price = 84 * DEFAULT_PRICE;
    typeBao9.des = @"";
    [arrTicketTypes addObject:typeBao9];
    
    //add type 6
    TicketTypeObj *typeBao10 = [[TicketTypeObj alloc] init];
    typeBao10.typeId = self.type == 0 ? idMegaBao10 : idPowerBao10;
    typeBao10.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao10.name = @"Bao 10";
    typeBao10.quantitySelectNumber = 10;
    typeBao10.numberTicketofGroup = 6;
    typeBao10.price = 210 * DEFAULT_PRICE;
    typeBao10.des = @"";
    [arrTicketTypes addObject:typeBao10];
    
    //add type 7
    TicketTypeObj *typeBao11 = [[TicketTypeObj alloc] init];
    typeBao11.typeId = self.type == 0 ? idMegaBao11 : idPowerBao11;
    typeBao11.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao11.name = @"Bao 11";
    typeBao11.quantitySelectNumber = 11;
    typeBao11.numberTicketofGroup = 6;
    typeBao11.price = 462 * DEFAULT_PRICE;
    typeBao11.des = @"";
    [arrTicketTypes addObject:typeBao11];
    
    //add type 8
    TicketTypeObj *typeBao12 = [[TicketTypeObj alloc] init];
    typeBao12.typeId = self.type == 0 ? idMegaBao12 : idPowerBao12;
    typeBao12.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao12.name = @"Bao 12";
    typeBao12.quantitySelectNumber = 12;
    typeBao12.numberTicketofGroup = 6;
    typeBao12.price = 924 * DEFAULT_PRICE;
    typeBao12.des = @"";
    [arrTicketTypes addObject:typeBao12];
    
    //add type 9
    TicketTypeObj *typeBao13 = [[TicketTypeObj alloc] init];
    typeBao13.typeId = self.type == 0 ? idMegaBao13 : idPowerBao13;
    typeBao13.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao13.name = @"Bao 13";
    typeBao13.quantitySelectNumber = 13;
    typeBao13.numberTicketofGroup = 6;
    typeBao13.price = 1716 * DEFAULT_PRICE;
    typeBao13.des = @"";
    [arrTicketTypes addObject:typeBao13];
    
    //add type 10
    TicketTypeObj *typeBao14 = [[TicketTypeObj alloc] init];
    typeBao14.typeId = self.type == 0 ? idMegaBao14 : idPowerBao14;
    typeBao14.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao14.name = @"Bao 14";
    typeBao14.quantitySelectNumber = 14;
    typeBao14.numberTicketofGroup = 6;
    typeBao14.price = 3003 * DEFAULT_PRICE;
    typeBao14.des = @"";
    [arrTicketTypes addObject:typeBao14];
    
    //add type 11
    TicketTypeObj *typeBao15 = [[TicketTypeObj alloc] init];
    typeBao15.typeId = self.type == 0 ? idMegaBao15 : idPowerBao15;
    typeBao15.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao15.name = @"Bao 15";
    typeBao15.quantitySelectNumber = 15;
    typeBao15.numberTicketofGroup = 6;
    typeBao15.price = 5005 * DEFAULT_PRICE;
    typeBao15.des = @"";
    [arrTicketTypes addObject:typeBao15];
    
    //add type 12
    TicketTypeObj *typeBao18 = [[TicketTypeObj alloc] init];
    typeBao18.typeId = self.type == 0 ? idMegaBao18 : idPowerBao18;
    typeBao18.gameId = [NSString stringWithFormat:@"%@",self.dictGame[@"id"]];
    typeBao18.name = @"Bao 18";
    typeBao18.quantitySelectNumber = 18;
    typeBao18.numberTicketofGroup = 6;
    typeBao18.price = 18564 * DEFAULT_PRICE;
    typeBao18.des = @"";
    [arrTicketTypes addObject:typeBao18];
    
    //set first item
    selectedTicketType = arrTicketTypes[0];
    self.lblChonCachChoiValue.text = selectedTicketType.name;
    [self initListTicketsByType:selectedTicketType];
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
        selectedTicketType = arrTicketTypes[0];
        self.lblChonCachChoiValue.text = selectedTicketType.name;
        [self initListTicketsByType:selectedTicketType];
    }else{
        [self initTicketTypeListOffline];
    }
}

- (void)initListKyQuay {
    if ([Utils isDisconnect]) {
        [self createKyQuayOffLine];
    }else{
        [self getListKyQuay];
    }
}

- (void)createKyQuayOffLine {
    //Tạo mảng kỳ quay
    NSArray *arrayStrDateOK = [Utils createKyQuayWithIdGame:idMega645];
    if (self.type != 0) {
        arrayStrDateOK = [Utils createKyQuayWithIdGame:idPower655];
    }
    
    arrKyquay = [[NSMutableArray alloc] init];
    for (NSString *str in arrayStrDateOK) {
        CommonSelectionObj *item = [[CommonSelectionObj alloc] init];
        item.idKyQuay = @"";
        item.name = str;
        [arrKyquay addObject:item];
    }
    
    //set ki quay mac dinh
    selectedKyQuay = arrKyquay[0];
    self.lblChonKyMuaValue.text = selectedKyQuay.name;
}

- (void)createKyQuayOnLine : (NSArray *)array {
    if (array.count > 0) {
        arrKyquay = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            CommonSelectionObj *item = [[CommonSelectionObj alloc] init];
            item.idKyQuay = [NSString stringWithFormat:@"#%@",dict[@"code"]];
            item.name = [[[NSString stringWithFormat:@"%@",dict[@"time_play"]] componentsSeparatedByString:@" "] firstObject];
            [arrKyquay addObject:item];
        }
    }else{
        [self createKyQuayOffLine];
    }
    
    //set ki quay mac dinh
    selectedKyQuay = arrKyquay[0];
    self.lblChonKyMuaValue.text = selectedKyQuay.name;
}

- (void)initListTicketsByType: (TicketTypeObj*) ticketType {
    arrayTickets = [NSMutableArray array];
    for(int i = 0; i < ticketType.numberTicketofGroup; i++){
        BoSoObj *item = [[BoSoObj alloc] init];
        
        switch (i) {
            case 0:
                item.name = @"A";
                break;
            case 1:
                item.name = @"B";
                break;
            case 2:
                item.name = @"C";
                break;
            case 3:
                item.name = @"D";
                break;
            case 4:
                item.name = @"E";
                break;
            case 5:
                item.name = @"F";
                break;
            default:
                break;
        }
        
        item.price = ticketType.price;
        item.type = ticketType;
        item.isFavorited = FALSE;
        [arrayTickets addObject:item];
    }
    [self.tableView reloadData];
}

#pragma mark - Core Data stack

- (void)getDataFromCoreData {
    NSManagedObjectContext *managedObjContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Tickets"];
    NSArray *arrayObj = [[managedObjContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    self.labelValueShoppingCart.hidden = arrayObj.count == 0;
    self.labelValueShoppingCart.text = [NSString stringWithFormat:@"%lu",(unsigned long)arrayObj.count];
    
//    self.btnCart.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)arrayObj.count];
    self.navigationItem.rightBarButtonItems[0].badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)arrayObj.count];
}

- (void)saveTicketToCoreData : (BOOL) isBuy {
    NSManagedObjectContext *managedObjContext = [self managedObjectContext];
    
    NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Tickets" inManagedObjectContext:managedObjContext];
    
    NSMutableArray *array = [NSMutableArray array];
    for (BoSoObj *obj in arrayTickets) {
        if ([obj isAddingNumber]) {
            NSString *str = [obj toJSONString];
            [array addObject:str];
        }
    }
    NSString *numbers = [array componentsJoinedByString:@"#"];
    
    [newItem setValue:selectedKyQuay.name forKey:@"date"];
    [newItem setValue:selectedKyQuay.idKyQuay forKey:@"id_ky_quay"];
    [newItem setValue:numbers forKey:@"numbers"];
    [newItem setValue:[NSString stringWithFormat:@"%d",totalPrice] forKey:@"price"];
    [newItem setValue:selectedTicketType.name forKey:@"type_ticket"];
    
    if (self.type == 0) {
        [newItem setValue:smsCodeMega forKey:@"type_vietlott"];
        [newItem setValue:@"home_mega645" forKey:@"image"];
    }else if (self.type == 1) {
        [newItem setValue:smsCodePower forKey:@"type_vietlott"];
        [newItem setValue:@"home_power655" forKey:@"image"];
    }
    
    
    NSError *errorSave = nil;
    // Save the object to persistent store
    if (![managedObjContext save:&errorSave]) {
        NSLog(@"Can't Save! %@ %@", errorSave, [errorSave localizedDescription]);
    }else{
        NSLog(@"Luu thanh cong");
        [self getDataFromCoreData];
        [self initListTicketsByType:selectedTicketType];
        [self updateTotalPrice];
        
        if (isBuy) {
            [self onClickbtnShoppingCart:nil];
        }
    }
}

#pragma mark CallAPI

- (void)getTypeGames {
    NSArray *check_sum = @[@"API0044_get_type_play",
                           [NSString stringWithFormat:@"%@",self.dictGame[@"id"]]
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0044_get_type_play",
                                @"id":[NSString stringWithFormat:@"%@",self.dictGame[@"id"]]
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                NSArray *array = dictData[@"info"];
                [self initTicketTypeListOnline:array];
            }else{
                [self initTicketTypeListOffline];
            }
        }else{
            [self initTicketTypeListOffline];
        }
    }];
}

- (void)getListKyQuay {
    NSArray *check_sum = @[@"api0046_get_period_of_game",
                           [NSString stringWithFormat:@"%@",self.dictGame[@"id"]]
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0046_get_period_of_game",
                                @"id":[NSString stringWithFormat:@"%@",self.dictGame[@"id"]]
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                NSArray *array = dictData[@"info"];
                [self createKyQuayOnLine:array];
            }else{
                [self createKyQuayOffLine];
            }
        }else{
            [self createKyQuayOffLine];
        }
    }];
}

- (void)addToFavorite : (BoSoObj *)obj {
    NSArray *check_sum = @[@"API0036_insert_favorite_numbers",
                           [VariableStatic sharedInstance].phoneNumber,
                           [NSString stringWithFormat:@"%@",self.dictGame[@"id"]],
                           [NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                           [self getStrBoso:obj]
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"API0036_insert_favorite_numbers",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"game_id":[NSString stringWithFormat:@"%@",self.dictGame[@"id"]],
                                @"type_play_id":[NSString stringWithFormat:@"%@",selectedTicketType.typeId],
                                @"favorite_numbers":[self getStrBoso:obj]
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                obj.idFavorite = [NSString stringWithFormat:@"%@",dictData[@"id"]];
            }else{
                
            }
        }else{
            
        }
    }];
}

- (void)removeFromFavorite : (BoSoObj *)obj {
    if (obj.idFavorite.length > 0) {
        NSArray *check_sum = @[@"API0038_delete_favorite_numbers",
                               [VariableStatic sharedInstance].phoneNumber,
                               obj.idFavorite
                               ];
        
        NSDictionary *dictParam = @{@"KEY":@"API0038_delete_favorite_numbers",
                                    @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                    @"id":obj.idFavorite
                                    };

        [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:self completeBlock:^(NSDictionary *dictData) {
            if (dictData) {
                if ([dictData[@"error"]  isEqual:@"0000"]) {
                    obj.idFavorite = @"";
                }else{
                    
                }
            }else{
                
            }
        }];
    }
}

- (NSString *)getStrBoso : (BoSoObj *)obj {
    NSMutableArray *arrayNumber = [NSMutableArray array];
    for (NSString *str in obj.arrNumber) {
        if (str.length == 1) {
            [arrayNumber addObject:[@"0" stringByAppendingString:str]];
        }else if (str.length == 2) {
            [arrayNumber addObject:str];
        }
    }
    
    NSString *content = [arrayNumber componentsJoinedByString:@""];
    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return content;
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameUpdateCart]) {
        [self getDataFromCoreData];
    }
}

@end
