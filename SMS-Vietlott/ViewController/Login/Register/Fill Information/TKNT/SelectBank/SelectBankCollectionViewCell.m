//
//  SelectBankCollectionViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/26/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "SelectBankCollectionViewCell.h"

@implementation SelectBankCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [self performSelector:@selector(settupView) withObject:nil afterDelay:0.1];
}

- (void)settupView {
    self.imageAvatarBank.layer.cornerRadius = self.imageAvatarBank.frame.size.height/2;
    self.imageAvatarBank.clipsToBounds = YES;
}

@end
