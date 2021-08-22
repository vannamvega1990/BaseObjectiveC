//
//  DetailNotificationSelectNumberViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/15/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "DetailNotificationSelectNumberViewController.h"

@interface DetailNotificationSelectNumberViewController ()

@end

@implementation DetailNotificationSelectNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillInfo];
}

- (void)fillInfo {
    self.labelTitle.text = [NSString stringWithFormat:@"%@",self.dictNotification[@"title"]];
    
    NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",self.dictNotification[@"img_link"]]];
    [self.imageNotification sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"trung_thuong_645"]];
}

- (IBAction)selectNumber:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameSelectTabbarHome object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
