//
//  CommonTableViewController.m
//  NoiBaiAirPort
//
//  Created by HuCuBi on 6/7/18.
//  Copyright © 2018 NeoJSC. All rights reserved.
//

#import "CommonTableViewController.h"

@interface CommonTableViewController ()

@end

@implementation CommonTableViewController {
    BOOL isSearch;
    NSMutableArray *arraySearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    switch (self.typeView) {
            
        case kProvince:
        {
            self.labelTitle.text = @"Chọn Tỉnh/TP";
        }
            break;
            
        case kDistrict:
        {
            self.labelTitle.text = @"Chọn Quận/Huyện";
        }
            break;
            
        case kWard:
        {
            self.labelTitle.text = @"Chọn Phường/Xã";
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.numberOfLines = 0;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"- None -";
    }else{
        NSDictionary *dict;
        if (isSearch) {
            dict = [arraySearch objectAtIndex:indexPath.row-1];
        }else{
            dict = [self.arrayItem objectAtIndex:indexPath.row-1];
        }
        
        switch (self.typeView) {
            case kProvince:
            {
                cell.textLabel.text = dict[@"pr_name"];
            }
                break;
                
            case kDistrict:
            {
                cell.textLabel.text = dict[@"dis_name"];
            }
                break;
                
            case kWard:
            {
                cell.textLabel.text = dict[@"com_name"];
            }
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict;
    if (indexPath.row == 0) {
        dict = [NSDictionary dictionary];
    }else{
        if (isSearch) {
            dict = [arraySearch objectAtIndex:indexPath.row-1];
        }else{
            dict = [self.arrayItem objectAtIndex:indexPath.row-1];
        }
    }
    
    switch (self.typeView) {
        case kProvince:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectProvince object:dict];
        }
            break;
            
        case kDistrict:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kDistrict" object:dict];
        }
            break;
            
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch) {
        return arraySearch.count+1;
    }else{
        return _arrayItem.count+1;
    }
}

- (IBAction)search:(id)sender {
    arraySearch = [NSMutableArray array];
    if (self.textFieldSearch.text.length > 0) {
        isSearch = YES;
        NSString *nameArea = @"";
        NSString *strSearch = [self.textFieldSearch.text uppercaseString];
        strSearch = [Utils changeVietNamese:strSearch];
        
        for (NSDictionary *dict in self.arrayItem) {
            switch (self.typeView) {
                case kProvince:
                {
                    nameArea = dict[@"pr_name"];
                    break;
                }
                    
                case kDistrict:
                {
                    nameArea = dict[@"dis_name"];
                    break;
                }
                    
                
                    
                case kWard: {
                    nameArea = dict[@"com_name"];
                    break;
                }
            }
            
            nameArea = [nameArea uppercaseString];
            nameArea = [Utils changeVietNamese:nameArea];
            if ([nameArea containsString:strSearch]) {
                [arraySearch addObject:dict];
            }
        }
    }else{
        isSearch = NO;
    }
    [self.tableView reloadData];
}

- (IBAction)backToHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
