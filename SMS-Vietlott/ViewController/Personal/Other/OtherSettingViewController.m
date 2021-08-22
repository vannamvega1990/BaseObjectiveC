//
//  OtherSettingViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/20/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "OtherSettingViewController.h"
#import "FeedbackViewController.h"
#import "CommonWebViewController.h"

@interface OtherSettingViewController ()

@end

@implementation OtherSettingViewController {
    NSArray *arrayOther;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOther = @[@{@"name":@"Khiếu nại, góp ý",
                     @"id":@"0"},
                   @{@"name":@"Liên hệ",
                     @"id":@"1"},
                   @{@"name":@"Điều khoản và chính sách",
                     @"id":@"2"}];
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    self.labelVersion.text = [NSString stringWithFormat:@"Version %@",appVersion];
}

- (IBAction)logout:(id)sender {
    [Utils alert:@"Đăng xuất" content:@"Bạn chắc chắn muốn đăng xuất ?" titleOK:@"Đồng ý" titleCancel:@"Hủy bỏ" viewController:nil completion:^{
        [[VariableStatic sharedInstance] cleanData];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kUserDefaultIsLogin];
        
        NSManagedObjectContext *managedObjContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Tickets"];
        NSArray *arrayTickets = [[managedObjContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        for (NSManagedObject *ticket in arrayTickets) {
            [managedObjContext deleteObject:ticket];
        }
        NSError *error = nil;
        if (![managedObjContext save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }else{
            
        }
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [[[self appDelegate] window] setRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"tabbarController"]];
    }];
}

- (IBAction)showFB:(id)sender {
    [Utils showFB];
}

- (IBAction)showYouTobe:(id)sender {
    [Utils showYoutube];
}

- (IBAction)showGroup:(id)sender {
    [Utils showGroup];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dict = arrayOther[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayOther.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = arrayOther[indexPath.row];
    int type = [dict[@"id"] intValue];
    
    switch (type) {
        case 0:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
            FeedbackViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
        {
            [Utils callSupport:@"19001080"];
        }
            break;
            
        case 2:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
            CommonWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonWebViewController"];
            vc.titleView = @"Điều khoản và chính sách";
            vc.stringUrl = @"https://policies.google.com/terms?fg=1";
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}

@end
