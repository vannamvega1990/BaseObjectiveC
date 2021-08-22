//
//  MyCustomView.m
//  BanChoKenh
//
//  Created by HuCuBi on 7/12/17.
//  Copyright © 2017 HuCuBi. All rights reserved.
//

#import "MyCustomView.h"


@implementation MyCustomView

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (void)setShadowOffset:(CGFloat)shadowOffset {
    self.layer.shadowOffset = CGSizeMake(shadowOffset, shadowOffset);
    self.layer.masksToBounds = false;
}

@end
