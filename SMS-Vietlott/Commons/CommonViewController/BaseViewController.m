//
//  BaseViewController.m
//  NoiBaiAirPort
//
//  Created by HuCuBi on 5/27/18.
//  Copyright © 2018 NeoJSC. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.barTintColor = RGB_COLOR(75, 109, 179);
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
//    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    
    _buttonLeft  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_buttonLeft setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [_buttonLeft.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_buttonLeft addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_buttonLeft];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = RGB_COLOR(240, 240, 240);
    self.refreshControl.tintColor = RGB_COLOR(100, 100, 100);
    [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goback {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleRefresh : (id)sender{
    
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
