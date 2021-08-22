//
//  SelectBankHeaderCollectionReusableView.h
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/26/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectBankHeaderCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *labelNameHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelSubNameHeader;

@end

NS_ASSUME_NONNULL_END
