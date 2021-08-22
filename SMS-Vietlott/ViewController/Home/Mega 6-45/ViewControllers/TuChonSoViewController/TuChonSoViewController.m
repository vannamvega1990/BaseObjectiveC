//
//  TuChonSoViewController.m
//  SMS-Vietlott
//
//  Created by  Admin on 4/8/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "TuChonSoViewController.h"
#import <UIKit/UIKit.h>
#import "ChonSoCollectionViewCell.h"
#import "Utils.h"

@interface TuChonSoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation TuChonSoViewController {
    int totalPrice;
    BoSoObj *currentTicket;
    int maxNumber;
}

static NSString *cellIdentifier = @"ChonSoCollectionViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [self.strTicket componentsSeparatedByString:@"#"];
    self.arrTickets = [NSMutableArray array];
    for (NSString *str in array) {
        BoSoObj *obj = [[BoSoObj alloc] initWithString:str error:nil];
        if (obj) {
            [self.arrTickets addObject:obj];
        }
    }
    [self initUI];
    [self updateTotalPrice];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    
    CGSize collectionViewSize = self.collectionView.contentSize;
    self.heightCollectionView.constant = collectionViewSize.height;
}

- (IBAction)onClickClose:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)onClickbtnHelp:(id)sender {
    
}

- (IBAction)btnClickWithTag:(UIButton *)sender {
    [self updateTabsbyIndex:(int)sender.tag];
}

- (IBAction)onClickbtnTuChon:(id)sender {
    [self makeRandomNumber];
}

- (IBAction)onClickbtnChonLai:(id)sender {
    //    for(int i= 0; i < self.arrTickets.count; i++){
    BoSoObj *ticket = self.arrTickets[self.selectedIndex];
    [ticket clearSelectedNumber];
    //    }
    [currentTicket clearSelectedNumber];
    [self.collectionView reloadData];
}

- (IBAction)onClickXacnhan:(id)sender {
    if ([self checkSelectTicketSuccess]) {
        if(self.delegate != nil){
            [self.delegate selectTicketSuccess:self.arrTickets];
        }
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

- (void) initUI {
    maxNumber = self.type == 0 ? 45 : 55;
    
    [self updateTabsbyIndex: self.selectedIndex];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier: cellIdentifier];
}

- (BOOL)checkSelectTicketSuccess {
    for(int i = 0; i < self.arrTickets.count; i++){
        int ticketNumberMax = self.ticketType.quantitySelectNumber;
        BoSoObj *ticket = self.arrTickets[i];
        
        if([ticket isAddingNumber] && ![ticket isValidNumber]){
            [Utils alertError:@"Thông báo" content:[NSString stringWithFormat:@"Bộ số %@ chưa chọn đủ %d số",ticket.name, ticketNumberMax] viewController:self completion:^{
                [self updateTabsbyIndex:i];
            }];
            return false;
        }
    }
    
    return true;
}

- (void) updateTabsbyIndex: (int) index {
    
    //update current ticket to array ticket
    if(self.arrTickets.count > self.selectedIndex && currentTicket != nil) {
        self.arrTickets[self.selectedIndex] = currentTicket;
    }
    
    //set new index + update new current ticket
    self.selectedIndex = index;
    if(self.arrTickets.count > self.selectedIndex) {
        currentTicket = self.arrTickets[self.selectedIndex];
    }
    
    [self.collectionView reloadData];
    
    for (UIView *view in self.arrayIndicatorView) {
        if (view.tag == index) {
            view.backgroundColor = [UIColor redColor];
        }else{
            view.backgroundColor = [UIColor clearColor];
        }
    }
    
    for (UIButton *btn in self.arrayBtnBoSo) {
        if (btn.tag == index) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
}

- (BOOL) isSelectedNumber: (NSString*) selectedNumber {
    
    if(currentTicket != nil){
        for(int i=0; i < currentTicket.type.quantitySelectNumber; i++) {
            NSString *number = currentTicket.arrNumber[i];
            if ([number isEqualToString:selectedNumber]) {
                return TRUE;
            }
        }
    }
    
    return FALSE;
}


- (void) onSelectedNumber: (NSString*) selectedNumber {
    if(currentTicket != nil){
        int updatedIndex = -1;
        bool isAddNew = true;
        for(int i=0; i < currentTicket.type.quantitySelectNumber; i++) {
            NSString *number = currentTicket.arrNumber[i];
            BOOL isContain = [currentTicket.arrNumber containsObject:selectedNumber];
            
            if([number isEqualToString:@""] && isContain == NO){
                updatedIndex = i;
                isAddNew = true;
                break;
            } else if ([number isEqualToString:selectedNumber]) {
                updatedIndex = i;
                isAddNew = false;
                break;
            }
        }
        
        if (updatedIndex != -1) {
            if (isAddNew) {
                [currentTicket.arrNumber replaceObjectAtIndex:updatedIndex withObject:selectedNumber];
            } else {
                [currentTicket.arrNumber replaceObjectAtIndex:updatedIndex withObject:@""];
            }
        }else{
            [Utils alertError:@"Lỗi chọn số" content:[NSString stringWithFormat:@"Bạn chỉ được chọn %d số trên mỗi bảng số",currentTicket.type.quantitySelectNumber] viewController:nil completion:^{
                
            }];
        }
        
        [self updateTotalPrice];
        [self.collectionView reloadData];
    }
}

- (void)updateTotalPrice {
    totalPrice = 0;
    for(int i = 0; i< self.arrTickets.count; i++){
        BoSoObj *ticket = self.arrTickets[i];
        if([ticket isValidNumber]){
            totalPrice += ticket.price;
        }
    }
    
    self.lblChiPhiValue.text = [[Utils strCurrency:[NSString stringWithFormat:@"%d",totalPrice]] stringByAppendingFormat:@"đ"] ;
}

- (void)makeRandomNumber {
    [self onClickbtnChonLai:nil];
    
    do {
        int number = [Utils getRandomNumberBetween:1 and:maxNumber];
        NSString *strNumber = number < 10 ? [NSString stringWithFormat:@"0%d",number] : [NSString stringWithFormat:@"%d",number];
        
        if (![currentTicket.arrNumber containsObject:strNumber]) {
            for(int i=0; i < currentTicket.type.quantitySelectNumber; i++) {
                NSString *number = currentTicket.arrNumber[i];
                if([number isEqualToString:@""]){
                    [currentTicket.arrNumber replaceObjectAtIndex:i withObject:strNumber];
                    break;
                }
            }
        }
    } while ([currentTicket isAddingNumber] && ![currentTicket isValidNumber]);
}


// -MARK: collection view
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *selectedNumber = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    if (selectedNumber.length == 1) {
        selectedNumber = [NSString stringWithFormat:@"0%@",selectedNumber];
    }
    [self onSelectedNumber:selectedNumber];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChonSoCollectionViewCell *cell = (ChonSoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *currentNumber = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    if (currentNumber.length == 1) {
        currentNumber = [NSString stringWithFormat:@"0%@",currentNumber];
    }
    cell.lblNumber.text = currentNumber;
    
    BOOL isSelectedNumber = [self isSelectedNumber:currentNumber];
    
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

@end
