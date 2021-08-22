//
//  Max4DViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/6/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "Max4DViewController.h"
#import "TicketTypeObj.h"
#import "UIBarButtonItem+Badge.h"
#import "Max4DTableViewCell.h"
#import "Max3DCollectionViewCell.h"
#import "Max4DSelectNumberViewController.h"

@interface Max4DViewController ()

@end

@implementation Max4DViewController {
    int totalPrice;
    NSMutableArray *arrTicketTypes;
    TicketTypeObj *selectedTicketType;
    
    NSMutableArray *arrKyquay;
    CommonSelectionObj *selectedKyQuay;
    
    NSMutableArray *arrayTickets;
    
    long long DEFAULT_PRICE;
    
    NSMutableArray *arrayNumbers;
}

static NSString *cellIdentifier = @"Max3DCollectionViewCell";

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
    
    self.navigationItem.title = @"Max 4D";
    
    self.viewBoSoTaoRa.hidden = YES;
    self.heightViewBoSoTaoRa.constant = 0;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier: cellIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameUpdateCart object:nil];
}

- (void) initListKyQuay {
    if ([Utils isDisconnect]) {
        [self createKyQuayOffLine];
    }else{
        [self getListKyQuay];
    }
}

- (void)createKyQuayOffLine {
    NSArray *arrayStrDateOK = [Utils createKyQuayWithIdGame:idMax4D];
    //Tạo mảng kỳ quay
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

- (void) initTicketTypeList {
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
//    typeThuong.typeId = @"M4T";
    typeThuong.typeId = idMax4DCoBan;
    typeThuong.name = @"Cơ bản";
    typeThuong.quantitySelectNumber = 4;
    typeThuong.numberTicketofGroup = 6;
    typeThuong.price = DEFAULT_PRICE;
    [arrTicketTypes addObject:typeThuong];
    
    //add type 2
    TicketTypeObj *typeDaoSo = [[TicketTypeObj alloc] init];
//    typeDaoSo.typeId = @"M4TH";
    typeDaoSo.typeId = idMax4DToHop;
    typeDaoSo.name = @"Tổ hợp";
    typeDaoSo.quantitySelectNumber = 4;
    typeDaoSo.numberTicketofGroup = 6;
    [arrTicketTypes addObject:typeDaoSo];
    
    //add type 3
    TicketTypeObj *typeBao = [[TicketTypeObj alloc] init];
//    typeBao.typeId = @"M4B";
    typeBao.typeId = idMax4DBao;
    typeBao.name = @"Bao";
    typeBao.quantitySelectNumber = 4;
    typeBao.numberTicketofGroup = 6;
    [arrTicketTypes addObject:typeBao];
    
    //add type 4
    TicketTypeObj *typeCuon1 = [[TicketTypeObj alloc] init];
//    typeCuon1.typeId = @"M4C1";
    typeCuon1.typeId = idMax4DCuon1;
    typeCuon1.name = @"Cuộn 1";
    typeCuon1.quantitySelectNumber = 4;
    typeCuon1.numberTicketofGroup = 6;
    [arrTicketTypes addObject:typeCuon1];
    
    //add type 5
    TicketTypeObj *typeCuon4 = [[TicketTypeObj alloc] init];
//    typeCuon4.typeId = @"M4C4";
    typeCuon4.typeId = idMax4DCuon4;
    typeCuon4.name = @"Cuộn 4";
    typeCuon4.quantitySelectNumber = 4;
    typeCuon4.numberTicketofGroup = 6;
    [arrTicketTypes addObject:typeCuon4];
    
    //set first item
    selectedTicketType = arrTicketTypes[0];
    self.lblChonCachChoiValue.text = selectedTicketType.name;
    [self initListTicketsByType:selectedTicketType];
}

- (void) initListTicketsByType: (TicketTypeObj*) ticketType {
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
        
        item.price = DEFAULT_PRICE;
        item.type = ticketType;
        item.isFavorited = FALSE;
        [arrayTickets addObject:item];
    }
    [self.tableView reloadData];
}

- (void)initTicketTypeListOnline : (NSArray *)arrayType {
    arrTicketTypes = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in arrayType) {
        if ([dict[@"active"] intValue] == 1) {
            TicketTypeObj *type = [[TicketTypeObj alloc] init];
            type.typeId = [NSString stringWithFormat:@"%@",dict[@"id"]];
            type.gameId = [NSString stringWithFormat:@"%@",dict[@"game_id"]];
            type.name = [NSString stringWithFormat:@"%@",dict[@"name"]];
            type.quantitySelectNumber = 4;
            type.numberTicketofGroup = 6;
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

- (void)onSelectedLoaiVe:(TicketTypeObj * _Nullable)selectedItem {
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

- (IBAction)onSelectKyMua:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    ChonKyQuayDialogViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:@"ChonKyQuayDialogViewController"];
    dialogVC.delegate = self;
    dialogVC.selectedItem = selectedKyQuay;
    dialogVC.arrItems = arrKyquay;
    [[[self appDelegate] window] addSubview:dialogVC.view];
    [[[self appDelegate] window].rootViewController addChildViewController:dialogVC];
}

- (void)onSelectedKyQuay:(CommonSelectionObj * _Nonnull)selectedItem {
    selectedKyQuay = selectedItem;
    self.lblChonKyMuaValue.text = selectedKyQuay.name;
}

- (IBAction)onClickBtnTuChon:(id)sender {
    [self choseNumbers:0];
}

-(IBAction)onClickBtnChonXuHuong:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
    ChonTheoXuHuongViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChonTheoXuHuongViewController"];
    vc.ticketType = selectedTicketType;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onClickBtnBoSoYeuThich:(id)sender {
    if ([VariableStatic sharedInstance].isLogin) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mega645Storyboard" bundle:nil];
        BoSoYeuThichViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BoSoYeuThichViewController"];
        vc.ticketType = selectedTicketType;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [Utils showAlertLogin];
    }
}

//Delegate sau khi chọn vé ưa thích
- (void)selectFavouriteTicketGroup:(nonnull NSMutableArray *)arrTickets {
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
    for (int i=0; i < strNumber.length; i++) {
        NSString *tmp_str = [strNumber substringWithRange:NSMakeRange(i, 1)];
        [arrNumber addObject:tmp_str];
    }
    
    for (int i=0; i < arrNumber.count; i++) {
        [obj.arrNumber replaceObjectAtIndex:i withObject:arrNumber[i]];
    }
    obj.isFavorited = YES;
    obj.idFavorite = dict[@"id"];
}

- (IBAction)onClickBtnKhac:(id)sender {
    
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

- (void)updateTotalPrice {
    totalPrice = 0;
    arrayNumbers = [NSMutableArray array];
    if ([selectedTicketType.typeId isEqualToString:idMax4DCoBan]) {
        for(int i = 0; i< arrayTickets.count; i++){
            BoSoObj *ticket = arrayTickets[i];
            if([ticket isValidNumber]){
                totalPrice += ticket.price;
                ticket.quantityNumber = 1;
            }
        }
    }else if ([selectedTicketType.typeId isEqualToString:idMax4DToHop]) {
        for(int i = 0; i< arrayTickets.count; i++){
            BoSoObj *ticket = arrayTickets[i];
            if([ticket isValidNumber]){
                totalPrice += ticket.price;
                ticket.quantityNumber = 1;
            }
        }
    }else if ([selectedTicketType.typeId isEqualToString:idMax4DBao]) {
        for(int i = 0; i< arrayTickets.count; i++){
            BoSoObj *ticket = arrayTickets[i];
            if([ticket isValidNumber]){
                NSArray *arrayNumberCreate = [self createNumberM4B:ticket];
                totalPrice += arrayNumberCreate.count*ticket.price;
                [arrayNumbers addObjectsFromArray:arrayNumberCreate];
                ticket.quantityNumber = (int)arrayNumberCreate.count;
                ticket.arrNumberCreate = arrayNumberCreate;
            }
        }
    }else if ([selectedTicketType.typeId isEqualToString:idMax4DCuon1]) {
        for(int i = 0; i< arrayTickets.count; i++){
            BoSoObj *ticket = arrayTickets[i];
            if([ticket isValidNumber]){
                NSArray *arrayNumberCreate = [self createNumberM4C1:ticket];
                totalPrice += arrayNumberCreate.count*ticket.price;
                [arrayNumbers addObjectsFromArray:arrayNumberCreate];
                ticket.quantityNumber = (int)arrayNumberCreate.count;
                ticket.arrNumberCreate = arrayNumberCreate;
            }
        }
    }else if ([selectedTicketType.typeId isEqualToString:idMax4DCuon4]) {
        for(int i = 0; i< arrayTickets.count; i++){
            BoSoObj *ticket = arrayTickets[i];
            if([ticket isValidNumber]){
                NSArray *arrayNumberCreate = [self createNumberM4C4:ticket];
                totalPrice += arrayNumberCreate.count*ticket.price;
                [arrayNumbers addObjectsFromArray:arrayNumberCreate];
                ticket.quantityNumber = (int)arrayNumberCreate.count;
                ticket.arrNumberCreate = arrayNumberCreate;
            }
        }
    }
    
    self.lblChiPhiValue.text = [[Utils strCurrency:[NSString stringWithFormat:@"%d",totalPrice]] stringByAppendingFormat:@"đ"] ;
    [self collectionViewReloadData];
}

- (NSMutableArray *)createNumberM4B : (BoSoObj *)obj {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        NSString *number = obj.arrNumber[i];
            [array addObject:number];
    }
    
    NSMutableArray *arrayNumberCreate = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        for (int j=0; j<array.count; j++) {
            for (int k=0; k<array.count; k++) {
                for (int h=0; h<array.count; h++) {
                    if (k!=i && k!=j && k!=h && h!=i & h!=j && i!=j) {
                        NSString *str = [NSString stringWithFormat:@"%@%@%@%@",array[i],array[j],array[k],array[h]];
                        if (![arrayNumberCreate containsObject:str]) {
                            [arrayNumberCreate addObject:str];
                        }
                    }
                }
            }
        }
    }
    
    return arrayNumberCreate;
}

- (NSMutableArray *)createNumberM4C1 : (BoSoObj *)obj {
    NSMutableArray *arrayNumberCreate = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        NSString *str = [NSString stringWithFormat:@"%d%@%@%@",i,obj.arrNumber[1],obj.arrNumber[2],obj.arrNumber[3]];
        [arrayNumberCreate addObject:str];
    }
    
    return arrayNumberCreate;
}

- (NSMutableArray *)createNumberM4C4 : (BoSoObj *)obj {
    NSMutableArray *arrayNumberCreate = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        NSString *str = [NSString stringWithFormat:@"%@%@%@%d",obj.arrNumber[0],obj.arrNumber[1],obj.arrNumber[2],i];
        [arrayNumberCreate addObject:str];
    }
    
    return arrayNumberCreate;
}

- (void)choseNumbers : (int) index {
    NSMutableArray *array = [NSMutableArray array];
    for (BoSoObj *obj in arrayTickets) {
        NSString *str = [obj toJSONString];
        [array addObject:str];
    }
    NSString *numbers = [array componentsJoinedByString:@"#"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Max4D" bundle:nil];
    Max4DSelectNumberViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Max4DSelectNumberViewController"];
    vc.selectedIndex = index;
    vc.strTicket = numbers;
    vc.ticketType = selectedTicketType;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Max4DSelectNumber
- (void)completeSelectNumber:(NSArray *)arraySelectNumbers {
    arrayTickets = [NSMutableArray arrayWithArray:arraySelectNumbers];
    [self.tableView reloadData];
    [self updateTotalPrice];
}

- (BOOL)hasTicket {
    for (BoSoObj *ticket in arrayTickets) {
        if ([ticket isAddingNumber] && [ticket isValidNumber]) {
            return YES;
        }
    }
    return NO;
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
        if ([obj isValidNumber]) {
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
    [newItem setValue:smsCodeMax4D forKey:@"type_vietlott"];
    [newItem setValue:@"home_max4d" forKey:@"image"];
    
    
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

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Max4DTableViewCell";
    Max4DTableViewCell *cell = (Max4DTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    BoSoObj *item = [arrayTickets objectAtIndex:indexPath.row];
    [cell setData:item];
    [cell.btnRandom addTarget:self action:@selector(randomNumber:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnFavorite addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnPrice addTarget:self action:@selector(selectPrice:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayTickets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self choseNumbers:(int)indexPath.row];
}

- (void)randomNumber: (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    BoSoObj *ticket = [arrayTickets objectAtIndex:hitIndex.row];
    
    if (ticket.isValidNumber) {
        [ticket clearSelectedNumber];
        ticket.isFavorited = NO;
    }else{
        [self getRandomNumber:ticket];
    }
    
    [self updateTotalPrice];
    [self.tableView reloadData];
}

- (void)getRandomNumber : (BoSoObj *)ticket {
    NSString *number1 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    NSString *number2 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    NSString *number3 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    NSString *number4 = [NSString stringWithFormat:@"%d",[Utils getRandomNumberBetween:0 and:9]];
    
    ticket.arrNumber[0] = number1;
    ticket.arrNumber[1] = number2;
    ticket.arrNumber[2] = number3;
    ticket.arrNumber[3] = number4;
        
    if ([selectedTicketType.typeId isEqualToString:idMax4DCuon1]){
        ticket.arrNumber[0] = @"*";
    }
    
    if ([selectedTicketType.typeId isEqualToString:idMax4DCuon4]){
        ticket.arrNumber[3] = @"*";
    }
}

- (void)addToFavorite : (id)sender {
    if ([VariableStatic sharedInstance].isLogin) {
        CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
        BoSoObj *ticket = [arrayTickets objectAtIndex:hitIndex.row];
        
        if (ticket.isValidNumber) {
            ticket.isFavorited = !ticket.isFavorited;
            [self.tableView reloadData];
            if (ticket.isFavorited == YES) {
                [self addFavorite:ticket];
            }else{
                [self removeFromFavorite:ticket];
            }
        }
    }else{
        [Utils showAlertLogin];
    }
}

- (void)selectPrice : (id)sender {
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    BoSoObj *ticket = [arrayTickets objectAtIndex:hitIndex.row];
    
//    if (ticket.isValidNumber) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Max3D" bundle:nil];
        Max3DSelectPriceViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Max3DSelectPriceViewController"];
        vc.delegate = self;
        vc.currentPrice = ticket.price;
        vc.selectIndex = hitIndex;
        [[[self appDelegate] window] addSubview:vc.view];
        [[[self appDelegate] window].rootViewController addChildViewController:vc];
//    }
}

- (void)onSelectedPrice:(long long)price :(NSIndexPath *)hitIndex {
    BoSoObj *ticket = [arrayTickets objectAtIndex:hitIndex.row];
    ticket.price = price;
    [self.tableView reloadData];
    [self updateTotalPrice];
}

#pragma mark CollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Max3DCollectionViewCell *cell = (Max3DCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *number = arrayNumbers[indexPath.row];
    cell.labelNumber.text = number;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrayNumbers.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat widthPerItem = UIScreen.mainScreen.bounds.size.width / 6;
    return CGSizeMake(widthPerItem, 40);
}

- (void)collectionViewReloadData {
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    
    if (arrayNumbers.count > 0) {
        CGSize collectionViewSize = self.collectionView.contentSize;
        self.heightViewBoSoTaoRa.constant = collectionViewSize.height + 40;
        self.viewBoSoTaoRa.hidden = NO;
    }else{
        self.heightViewBoSoTaoRa.constant = 0;
        self.viewBoSoTaoRa.hidden = YES;
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

- (void)addFavorite : (BoSoObj *)obj {
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
        [arrayNumber addObject:str];
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
