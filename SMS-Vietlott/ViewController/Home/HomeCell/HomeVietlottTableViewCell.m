//
//  HomeVietlottTableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/6/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "HomeVietlottTableViewCell.h"
#import "Utils.h"

@implementation HomeVietlottTableViewCell {
    NSTimer *timer;
    long timeProcess;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    if ([Utils isDisconnect]) {
        self.labelTime.text = @"";
    }else{
        NSDate *date = [Utils getDateFromStringDate:self.time];
        timeProcess = [date timeIntervalSinceDate:[NSDate date]];
        [self startCallTime];
    }
}

- (void)startCallTime{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(showTimeProcess:)
                                               userInfo:nil
                                                repeats:YES];
        
    }
}

- (void)showTimeProcess:(NSTimer *)timer {
    if (timeProcess <= 0) {
        timeProcess = 0;
    }
    self.labelTime.text = [Utils secondsToMMSS:timeProcess];
    timeProcess--;
}


@end
