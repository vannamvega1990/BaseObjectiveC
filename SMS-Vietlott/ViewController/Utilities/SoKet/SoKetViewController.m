//
//  SoKetViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SoKetViewController.h"
#import "SoKetTableViewCell.h"

@interface SoKetViewController ()

@end

@implementation SoKetViewController {
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
    arrayNumber = @[@{@"number":@"999",
                      @"percent":@"90",
                      @"quantity":@"123"
    },
                    @{@"number":@"9999",
                      @"percent":@"87",
                      @"quantity":@"23"
                    },
                    @{@"number":@"69",
                      @"percent":@"78",
                      @"quantity":@"56"
                    },
                    @{@"number":@"63",
                      @"percent":@"50",
                      @"quantity":@"22"
                    },
                    @{@"number":@"78",
                      @"percent":@"90",
                      @"quantity":@"33"
                    },
                    @{@"number":@"56",
                      @"percent":@"40",
                      @"quantity":@"45"
                    },
                    @{@"number":@"76",
                      @"percent":@"30",
                      @"quantity":@"67"
                    },
                    @{@"number":@"69",
                      @"percent":@"10",
                      @"quantity":@"100"
                    }];
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
            nameArea = dict[@"number"];
            
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
    static NSString *cellIdentifier = @"SoKetTableViewCell";
    SoKetTableViewCell *cell = (SoKetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *dict = arrayNumber[indexPath.row];
    if (isSearch) {
        dict = arraySearch[indexPath.row];
    }
    
    cell.labelNumber.text = dict[@"number"];
    cell.labelPercent.text = [NSString stringWithFormat:@"%@%c",dict[@"percent"],'%'];
    cell.labelQuantity.text = [NSString stringWithFormat:@"%@ lượt",dict[@"quantity"]];
    
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
