//
//  BaseViewController.h
//  NoiBaiAirPort
//
//  Created by HuCuBi on 5/27/18.
//  Copyright © 2018 NeoJSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "AppDelegate.h"
#import "JVFloatLabeledTextField.h"
#import "TextFiledChoseDate.h"
#import "VariableStatic.h"
#import "MyButton.h"
#import "MyImageView.h"
#import "MyCustomView.h"
#import "CallAPI.h"
#import <CoreData/CoreData.h>
#import "TicketTypeObj.h"
#import "BoSoObj.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property UIRefreshControl *refreshControl;
@property UIButton *buttonLeft;

- (AppDelegate *) appDelegate;
- (NSManagedObjectContext *)managedObjectContext;

@end
