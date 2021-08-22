//
//  DreamNumberViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/5/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "DreamNumberViewController.h"
#import "DreamNumberTableViewCell.h"

@interface DreamNumberViewController ()

@end

@implementation DreamNumberViewController {
    NSArray *arrayNumber;
    NSMutableArray *arraySearch;
    BOOL isSearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settupView];
}

- (void)settupView {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SoMo" ofType:@"plist"];
    arrayNumber = [[NSArray arrayWithContentsOfFile:plistPath]copy];
    [self.tableView reloadData];
}

- (IBAction)searchNumber:(id)sender {
    arraySearch = [NSMutableArray array];
    if (self.textFieldSearch.text.length > 0) {
        isSearch = YES;
        NSString *nameArea = @"";
        NSString *strSearch = [self.textFieldSearch.text uppercaseString];
        strSearch = [Utils changeVietNamese:strSearch];
        
        for (NSDictionary *dict in arrayNumber) {
            nameArea = dict[@"content"];
            
            nameArea = [nameArea uppercaseString];
            nameArea = [Utils changeVietNamese:nameArea];
            if ([nameArea containsString:strSearch]) {
                [arraySearch addObject:dict];
            }
        }
    }
    
    else{
        isSearch = NO;
    }
    [self.tableView reloadData];
}

#pragma mark TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DreamNumberTableViewCell";
    DreamNumberTableViewCell *cell = (DreamNumberTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = arrayNumber[indexPath.row];
    if (isSearch) {
        dict = arraySearch[indexPath.row];
    }
    
    cell.labelContent.text = dict[@"content"];
    cell.labelNumber.text = dict[@"number"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch) {
        return arraySearch.count;
    }else{
        return arrayNumber.count;
    }
}



@end
