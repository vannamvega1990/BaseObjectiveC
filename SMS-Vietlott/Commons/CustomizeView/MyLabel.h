//
//  MyLabel.h
//  Test365Child
//
//  Created by HuCuBi on 8/20/18.
//  Copyright © 2018 NeoJSC. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MyLabel : UILabel

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor * borderColor;

@end
