//
//  ManageChonTheoXuHuongViewController.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 5/15/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketTypeObj.h"
#import "BaseViewController.h"
#import "ChonTheoXuHuongViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ManageChonTheoXuHuongViewControllerDelegate<NSObject>

- (void) manageSelectTicketSuccess:(NSMutableArray*) arrTickets;

@end

@interface ManageChonTheoXuHuongViewController : BaseViewController<UIScrollViewDelegate, ChonTheoXuHuongViewControllerDelegate>

@property (strong, nonatomic) TicketTypeObj *ticketType;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayBtn;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *arrayViewLine;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign, nonatomic) id <ManageChonTheoXuHuongViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
